(ns api.db.util
  (:require [hikari-cp.core :refer [make-datasource]]
            [environ-plus.core :refer [env]]
            [clj-time
             [coerce :refer [to-sql-time]]
             [core :refer [now]]]
            [clojure.java.jdbc :as j]
            [taoensso.carmine :as car]
            [api.util :refer [wcar*] :as util]
            ))

;; TODO `component'
(let [db (:db env)]
  (defonce pool {db {:datasource (make-datasource db)}})
  (defonce default-db (get pool (:db env))))

(defn ->sql-time
  [datetime]
  (^java.sql.Timestamp to-sql-time datetime))

(defn sql-now
  []
  (->sql-time (now)))

(defn with-now
  [m k-or-ks]
  {:pre [(map? m) (not (empty? m))]}
  (let [ks (if (sequential? k-or-ks) k-or-ks [k-or-ks])
        time (sql-now)]
    (merge (zipmap ks (repeat time))
           m)))

(defn- str-join
  [pattern l]
  (clojure.string/join (str " " (name pattern) " ") l))

(str-join :and ["id = ?" "name = ?"])

(defn- conditions-transform
  "Legal conditions will transformed to an array of three tuples, each tuple consists of key, sql operator and the value.
  Argument `conditions' could be:
  1. `1'         => [[:id = 1]],
  2. {:a 1 :b 1} => [[:a = 1] [:b = 1]],
  3. [:id > 2]   => [[:id > 2]]
  3. [[:id > 2] [:price < 100.30]]  represents `id > 2' and price < 100.30."
  [conditions]
  (cond
    ;; id
    (or (string? conditions)
        (integer? conditions)
        (instance? java.util.UUID conditions))
    [[:id "=" conditions]]

    ;; empty
    (empty? conditions)
    nil

    ;; map, equal relations
    (map? conditions)
    (into [] (for [[k v] conditions]
               [k "=" v]))

    ;; non-nested vector
    (and (vector? conditions) (not (vector? (first conditions))))
    (conditions-transform [conditions])

    ;; vector
    (vector? conditions)
    conditions

    :else
    (throw (Exception. "Conditions illegal"))))

(defn sql-mark-handler
  [[k o v :as c]]
  (cond
    (= "in" (clojure.string/lower-case o))
    [k o (if (string? v)
           v
           (str "(" (clojure.string/join "," (repeat (count v) \?)) ")"))]

    :else
    [k o "?"]))

(defn- conditions-join
  ([conditions]
   (conditions-join conditions :and))
  ([conditions bool]
   {:pre [(or (= bool :and) (= bool :or))]}
   (if-let [conditions (conditions-transform conditions)]
     (let [where (->> conditions
                      (map (fn [c]
                             (let [[k o mark] (sql-mark-handler c)]
                               (format "(%s %s %s)" (name k) (name o) mark))))
                      (str-join bool))
           args (flatten (map last conditions))]
       [where args]))))

(defn exists?
  "where support `id' or [[k rel v]]."
  [db table where]
  (let [[where-sql args] (conditions-join where)
        jdbc-sql (concat [(format "SELECT EXISTS(SELECT 1 FROM %s WHERE %s)" table where-sql)] args)]
    (-> (j/query db jdbc-sql)
        first
        :exists)))

(defn in-placeholders
  [args]
  (clojure.string/join "," (repeat (count args) "?")))

(defn scan
  ([key-fn id]
   (scan key-fn id 0 4))
  ([key-fn id withscores]
   (scan key-fn id 0 4 withscores))
  ([key-fn id offset end]
   (scan key-fn id offset end false))
  ([key-fn id offset end withscores]
   (wcar*
    (:redis env)
    (if withscores
      (car/zrevrange (key-fn id) offset end withscores)
      (car/zrevrange (key-fn id) offset end)))))

(defn wrap-scan
  [key-fn]
  (partial scan key-fn))

(defn wrap-temp-username
  [m]
  (assert (map? m) "Wrap username must be a map")
  (assoc m :username (util/flake-id->str)))
