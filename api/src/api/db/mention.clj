(ns api.db.mention
  (:refer-clojure :exclude [get])
  (:require [taoensso.carmine :as car]
            [api.util :refer [wcar*]]
            [environ-plus.core :refer [env]])
  (:import [com.twitter Extractor]))

(defonce ^:private redis-key "mentions:")
(defonce ^:private extractor (Extractor.))

(defn- rk
  [user-id]
  (str redis-key user-id))

(defn extract
  [body]
  (some-> (.extractMentionedScreennames extractor body)
          (distinct)))

(defn create
  [db user-id message]
  (wcar* db
         (car/zadd (rk user-id)
                   (:id message)
                   message)))

(defn get
  ([db user-id]
   (get db user-id nil))
  ([db user-id {:keys [before-id after-id limit]
                   :or {limit 20}}]
   (let [key (rk user-id)]
     (cond
       (and (nil? before-id) (nil? after-id))
       (wcar* db (car/zrevrange key 0 (dec limit)))

       before-id
       (wcar* db (car/zrevrangebyscore key before-id "-inf" "limit" 0 limit))

       after-id
       (wcar* db (car/zrangebyscore key after-id "+inf"))))))
