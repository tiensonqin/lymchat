(ns api.pg.core
  "Allow using PostgreSQL from Clojure as effortlessly as possible by reading connection parameter defaults from
PostgreSQL environment variables PGDATABASE, PGHOST, PGPORT, PGUSER and by reading password from ~/.pgpass if available."
  (:require [api.pg.types]
            [cheshire.core :as json]
            [clojure.xml :as xml]
            [api.pg.pgpass :as pgpass]
            [clojure.java.jdbc :as jdbc])
  (:import org.postgresql.util.PGobject
           org.postgresql.util.PGmoney
           org.postgresql.util.PGInterval
           org.postgresql.geometric.PGbox
           org.postgresql.geometric.PGcircle
           org.postgresql.geometric.PGline
           org.postgresql.geometric.PGlseg
           org.postgresql.geometric.PGpath
           org.postgresql.geometric.PGpoint
           org.postgresql.geometric.PGpolygon
           org.postgis.PGgeometry))

(defn getenv->map
  "Convert crazy non-map thingy which comes from (System/getenv) into a keywordized map.
   If no argument given, fetch env with (System/getenv)."
  ([x]
    {:pre [(= (type x) java.util.Collections$UnmodifiableMap)]
     :post [(map? %)]}
    (zipmap
      (map keyword (keys x))
      (vals x)))
  ([]
    (getenv->map (System/getenv))))

(defn default-spec
  "Reasonable defaults as with the psql command line tool.
   Use username for user and db. Don't use host."
  []
  (let [username (java.lang.System/getProperty "user.name")]
    {:dbtype "postgresql"
     :user username
     :dbname username}))

(defn env-spec
  "Get db spec by reading PG* variables from the environment."
  [{:keys [PGDATABASE PGHOST PGPORT PGUSER] :as env}]
  {:pre [(map? env)]
   :post [(map? %)]}
  (cond-> {}
          PGDATABASE (assoc :dbname PGDATABASE)
          PGHOST (assoc :host PGHOST)
          PGPORT (assoc :port PGPORT)
          PGUSER (assoc :user PGUSER)))

(defn spec
  "Create database spec for PostgreSQL. Uses PG* environment variables by default
   and acceps options in the form:
   (pg-spec :dbname ... :host ... :port ... :user ... :password ...)"
  [& {:keys [password] :as opts}]
  {:post [(contains? % :dbname)
          (contains? % :user)]}
  (let [spec-opts (select-keys opts [:dbname :host :port :user])
        extra-opts (dissoc opts :dbname :host :port :user :password)
        db-spec (merge (default-spec)
                       (env-spec (getenv->map (System/getenv)))
                       spec-opts)
        password (or password (pgpass/pgpass-lookup db-spec))]
    (cond-> (merge extra-opts db-spec)
            password (assoc :password password))))

(defn close!
  "Close db-spec if possible. Return true if the datasource was closeable and closed."
  [{:keys [datasource] :as db-spec}]
  (when (instance? java.io.Closeable datasource)
    (.close ^java.io.Closeable datasource)
    true))

(defn tables
  [db]
  (jdbc/with-db-metadata [md db]
    (->> (doall (jdbc/metadata-result (.getTables md nil nil nil (into-array ["TABLE"]))))
      (map :table_name)
      (map keyword)
      (set))))

;;
;; Types
;;

(defn object
  "Make a custom PGobject, e.g. (pg/object \"json\" \"{}\")"
  [type value]
  (doto (PGobject.)
    (.setType (name type))
    (.setValue (str value))))

(defn interval
  "Create a PGinterval. (pg/interval :hours 2)"
  [& {:keys [years months days hours minutes seconds]
      :or {years 0 months 0 days 0 hours 0 minutes 0 seconds 0.0}}]
  (PGInterval. years months days hours minutes ^double seconds))

(defn money
  "Create PGmoney object"
  [amount]
  (PGmoney. ^double amount))

(defn xml
  "Make PostgreSQL XML object"
  [s]
  (object :xml (str s)))

;;
;; Constructors for geometric Types
;;

(defn point
  "Create a PGpoint object"
  ([x y]
    (PGpoint. x y))
  ([obj]
    (cond
      (instance? PGpoint obj) obj
      (coll? obj) (point (first obj) (second obj))
      :else (PGpoint. (str obj)))))

(defn box
  "Create a PGbox object"
  ([p1 p2]
    (PGbox. (point p1) (point p2)))
  ([x1 y1 x2 y2]
    (PGbox. x1 y1 x2 y2))
  ([obj]
    (if (instance? PGbox obj)
      obj
      (PGbox. (str obj)))))

(defn circle
  "Create a PGcircle object"
  ([x y r]
    (PGcircle. x y r))
  ([center-point r]
    (PGcircle. (point center-point) r))
  ([obj]
    (if (instance? PGcircle obj)
      obj
      (PGcircle. (str obj)))))

(defn line
  "Create a PGline object"
  ([x1 y1 x2 y2]
    (PGline. x1 y1 x2 y2))
  ([p1 p2]
    (PGline. (point p1) (point p2)))
  ([obj]
    (if (instance? PGline obj)
      obj
      (PGline. (str obj)))))

(defn lseg
  "Create a PGlseg object"
  ([x1 y1 x2 y2]
    (PGlseg. x1 y1 x2 y2))
  ([p1 p2]
    (PGlseg. (point p1) (point p2)))
  ([obj]
    (if (instance? PGlseg obj)
      obj
      (PGlseg. (str obj)))))

(defn path
  "Create a PGpath object"
  ([points open?]
    (PGpath. (into-array PGpoint (map point points)) open?))
  ([obj]
    (if (instance? PGpath obj)
      obj
      (PGpath. (str obj)))))

(defn polygon
  "Create a PGpolygon object"
  [points-or-str]
  (if (coll? points-or-str)
    (PGpolygon. ^"[Lorg.postgresql.geometric.PGpoint;" (into-array PGpoint (map point points-or-str)))
    (PGpolygon. ^String (str points-or-str))))
