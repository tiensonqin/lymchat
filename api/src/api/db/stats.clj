(ns api.db.stats
  (:require [taoensso.carmine :as car]
            [api.util :refer [wcar*]]
            [clojure.java.jdbc :as j]
            [environ-plus.core :refer [env]]
            [clj-time.core :refer [now]]
            [api.db.util :refer [default-db]]
            [clj-time.coerce :as cc]
            [clj-time.format :as f]
            [manifold.time :as mf]))

(defonce ^:private messages-key "stats:messages")
(defonce ^:private photos-key "stats:photos")

;; TODO rejected, how long
(defonce ^:private videos-key "stats:videos")

(defn- today
  []
  (f/unparse (f/formatter "yyyy-MM-dd") (now)))

(defn inc-point
  [db type]
  (when-let [key (case type
                   :message messages-key
                   :photo photos-key
                   :video videos-key
                   nil)]
    (wcar* db
           (car/hincrby key (today) 1))))

(defn sync->pg
  []
  (let [redis (:redis env)
        day (today)
        stats (->>
               (wcar* redis
                      (car/hget messages-key day)
                      (car/hget photos-key day)
                      (car/hget videos-key day))
               (map (fn [s] (if (nil? s) 0 (Integer/parseInt s)))))]
    (j/execute! default-db
                ["insert into stats (type,day,value) values (?,?,?) ON CONFLICT (type,day) DO UPDATE SET value = ?;"
                 "messages" (cc/to-sql-date day) (nth stats 0) (nth stats 0)])
    (j/execute! default-db
                ["insert into stats (type,day,value) values (?,?,?) ON CONFLICT (type,day) DO UPDATE SET value = ?;"
                 "photos" (cc/to-sql-date day) (nth stats 1) (nth stats 1)])
    (j/execute! default-db
                ["insert into stats (type,day,value) values (?,?,?) ON CONFLICT (type,day) DO UPDATE SET value = ?;"
                 "videos" (cc/to-sql-date day) (nth stats 2) (nth stats 2)])))

;; executed every 10 minutes
(defn run
  []
  (mf/every (* 1000 60 10) #'sync->pg))
