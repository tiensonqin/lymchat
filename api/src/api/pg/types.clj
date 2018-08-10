(ns api.pg.types
  "Participate in clojure.java.jdbc's ISQLValue and IResultSetReadColumn protocols
   to allow using PostGIS geometry types without the PGgeometry wrapper, support the
   PGjson type and allow coercing clojure structures into PostGIS types."
  (:require [api.pg.coerce :as coerce]
            [clojure.java.jdbc :as jdbc]
            [clojure.xml :as xml]
            [cheshire.core :as json])
  (:import [org.postgresql.util PGobject]
           [org.postgis Geometry PGgeometry PGgeometryLW]
           [java.sql PreparedStatement ParameterMetaData]))

;;
;; Helpers
;;

(defn pmd
  [^java.sql.ParameterMetaData md i]
  "Convert ParameterMetaData to a map."
  {:parameter-class (.getParameterClassName md i)
   :parameter-mode (.getParameterMode md i)
   :parameter-type (.getParameterType md i)
   :parameter-type-name (.getParameterTypeName md i)
   :precision (.getPrecision md i)
   :scale (.getScale md i)
   :nullable? (.isNullable md i)
   :signed? (.isSigned md i)})

(defn rsmd
  "Convert ResultSetMetaData to a map."
  [^java.sql.ResultSetMetaData md i]
  {:catalog-name (.getCatalogName md i)
   :column-class-name (.getColumnClassName md i)
   :column-display-size (.getColumnDisplaySize md i)
   :column-label (.getColumnLabel md i)
   :column-type (.getColumnType md i)
   :column-type-name (.getColumnTypeName md i)
   :precision (.getPrecision md i)
   :scale (.getScale md i)
   :schema-name (.getSchemaName md i)
   :table-name (.getTableName md i)
   :auto-increment? (.isAutoIncrement md i)
   :case-sensitive? (.isCaseSensitive md i)
   :currency? (.isCurrency md i)
   :definitely-writable? (.isDefinitelyWritable md i)
   :nullable? (.isNullable md i)
   :read-only? (.isReadOnly md i)
   :searchable? (.isSearchable md i)
   :signed? (.isSigned md i)
   :writable? (.isWritable md i)})

;;;;
;;
;; Data type conversion for SQL query parameters
;;
;;;;


;;
;; Extend clojure.java.jdbc's protocol for getting SQL values of things to support PostGIS objects.
;;
(extend-protocol jdbc/ISQLValue
  org.postgis.Geometry
  (sql-value [v]
    (PGgeometryLW. v)))

;;
;; Extend clojure.java.jdbc's protocol for converting query parameters to SQL values.
;; We try to determine which SQL type is correct for which clojure structure.
;; 1. See query parameter meta data. JDBC might already know what PostgreSQL wants.
;; 2. Look into parameter's clojure metadata for type hints
;;

;; multimethod selector for conversion funcs
(defn parameter-dispatch-fn
  [_ type-name]
  (keyword type-name))

;;
;; Convert Clojure maps to SQL parameter values
;;

(defmulti map->parameter parameter-dispatch-fn)

(defmethod map->parameter :geometry
  [m _]
  (jdbc/sql-value (coerce/geojson->postgis m)))

(defn- to-pg-json [data json-type]
  (doto (PGobject.)
    (.setType (name json-type))
    (.setValue (json/generate-string data))))

(defmethod map->parameter :json
  [m _]
  (to-pg-json m :json))

(defmethod map->parameter :jsonb
  [m _]
  (to-pg-json m :jsonb))


(extend-protocol jdbc/ISQLParameter
  clojure.lang.IPersistentMap
  (set-parameter [m ^PreparedStatement s ^long i]
    (let [meta (.getParameterMetaData s)]
      (if-let [type-name (keyword (.getParameterTypeName meta i))]
        (.setObject s i (map->parameter m type-name))
        (.setObject s i m)))))

;;
;; Convert clojure vectors to SQL parameter values
;;

(defmulti vec->parameter parameter-dispatch-fn)

(defmethod vec->parameter :inet
  [v _]
  (if (= (count v) 4)
    (doto (PGobject.) (.setType "inet") (.setValue (clojure.string/join "." v)))
    v))

(defmethod vec->parameter :default
  [v _]
  v)

(extend-protocol jdbc/ISQLParameter
  clojure.lang.IPersistentVector
  (set-parameter [v ^PreparedStatement s ^long i]
    (let [conn (.getConnection s)
          meta (.getParameterMetaData s)
          type-name (.getParameterTypeName meta i)]
      (if-let [elem-type (when type-name (second (re-find #"^_(.*)" type-name)))]
        (.setObject s i (.createArrayOf conn elem-type (to-array v)))
        (.setObject s i (vec->parameter v type-name))))))

;;
;; Convert all sequables to SQL parameter values by handling them like vectors.
;;

(extend-protocol jdbc/ISQLParameter
  clojure.lang.Seqable
  (set-parameter [seqable ^PreparedStatement s ^long i]
    (jdbc/set-parameter (vec (seq seqable)) s i)))

;;
;; Convert numbers to SQL parameter values.
;; Conversion is done for target types like timestamp
;; for which it makes sense to accept numeric values.
;;

(defmulti num->parameter parameter-dispatch-fn)

(defmethod num->parameter :timestamptz
  [v _]
  (java.sql.Timestamp. v))

(defmethod num->parameter :timestamp
  [v _]
  (java.sql.Timestamp. v))

(defmethod num->parameter :default
  [v _]
  v)

(extend-protocol clojure.java.jdbc/ISQLParameter
  java.lang.Number
  (set-parameter [num ^java.sql.PreparedStatement s ^long i]
    (let [conn (.getConnection s)
          meta (.getParameterMetaData s)
          type-name (.getParameterTypeName meta i)]
      (.setObject s i (num->parameter num type-name)))))


;; Inet addresses
(extend-protocol clojure.java.jdbc/ISQLParameter
  java.net.InetAddress
  (set-parameter [^java.net.InetAddress inet-addr ^java.sql.PreparedStatement s ^long i]
    (.setObject s i (doto (PGobject.)
                      (.setType "inet")
                      (.setValue (.getHostAddress inet-addr))))))

;;;;
;;
;; Data type conversions for query result set values.
;;
;;;;


;;
;; PGobject parsing magic
;;

(defn read-pg-vector
  "oidvector, int2vector, etc. are space separated lists"
  [s]
  (when-not (empty? s)
    (clojure.string/split s #"\s+")))

(defn read-pg-array
  "Arrays are of form {1,2,3}"
  [s]
  (when-not (empty? s)
    (when-let [[_ content] (re-matches #"^\{(.+)\}$" s)]
      (if-not (empty? content)
        (clojure.string/split content #"\s*,\s*")
        []))))

(defmulti read-pgobject
  "Convert returned PGobject to Clojure value."
  #(keyword (when % (.getType ^org.postgresql.util.PGobject %))))

(defmethod read-pgobject :oidvector
  [^org.postgresql.util.PGobject x]
  (when-let [val (.getValue x)]
    (mapv read-string (read-pg-vector val))))

(defmethod read-pgobject :int2vector
  [^org.postgresql.util.PGobject x]
  (when-let [val (.getValue x)]
    (mapv read-string (read-pg-vector val))))

(defmethod read-pgobject :anyarray
  [^org.postgresql.util.PGobject x]
  (when-let [val (.getValue x)]
    (vec (read-pg-array val))))

(defmethod read-pgobject :json
  [^org.postgresql.util.PGobject x]
  (when-let [val (.getValue x)]
    (json/parse-string val)))

(defmethod read-pgobject :jsonb
  [^org.postgresql.util.PGobject x]
  (when-let [val (.getValue x)]
    (json/parse-string val)))



(defmethod read-pgobject :default
  [^org.postgresql.util.PGobject x]
  (.getValue x))

;;
;; Extend clojure.java.jdbc's protocol for interpreting ResultSet column values.
;;
(extend-protocol jdbc/IResultSetReadColumn

  ;; Return the PostGIS geometry object instead of PGgeometry wrapper
  org.postgis.PGgeometry
  (result-set-read-column [val _ _]
    (coerce/postgis->geojson (.getGeometry val)))

  ;; Parse SQLXML to a Clojure map representing the XML content
  java.sql.SQLXML
  (result-set-read-column [val _ _]
    (xml/parse (.getBinaryStream val)))

  ;; Covert java.sql.Array to Clojure vector
  java.sql.Array
  (result-set-read-column [val _ _]
    (into [] (.getArray val)))

  ;; PGobjects have their own multimethod
  org.postgresql.util.PGobject
  (result-set-read-column [val _ _]
    (read-pgobject val)))
