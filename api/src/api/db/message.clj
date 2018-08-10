(ns api.db.message
  (:require [taoensso.carmine :as car]
            [api.util :refer [wcar*]]
            [api.db.util :refer [with-now]]
            [environ-plus.core :refer [env]]
            [api.db.stats :as stats]))

(defonce ^:private redis-key "messages:")
(defonce ^:private channels-redis-key "channels_messages:")

(defn- rk
  ([user-id]
   (rk user-id redis-key))
  ([redis-key user-id]
   (str redis-key user-id)))

;; channels only save latest 1000 messages
;; batch save to pg
(defn create
  [db {:keys [to_id] :as message}]
  (when message
    (wcar* db
          (stats/inc-point db :message)
          (car/zadd (rk redis-key to_id)
                    (:id message)
                    (with-now message [:created_at])))))

(defn channels-create
  [db {:keys [channel_id] :as message}]
  (when message
    (wcar* db
           (stats/inc-point db :message)
           (car/zadd (rk channels-redis-key channel_id)
                     (:id message)
                     (with-now message [:created_at])))))

(defn get-latest-messages
  [db user-id latest-message-id]
  (wcar* db
         (car/zrangebyscore (rk user-id)
                            (inc latest-message-id)
                            "+inf")))

(defn get-channel-latest-messages
  ([db channel-id]
   (get-channel-latest-messages db channel-id nil))
  ([db channel-id {:keys [before-id after-id limit]
                   :or {limit 20}}]
   (let [key (rk channels-redis-key channel-id)]
     (cond
      (and (nil? before-id) (nil? after-id))
      (wcar* db (car/zrevrangebyscore key "+inf" "-inf" "limit" 0 limit))

      before-id
      (wcar* db (car/zrevrangebyscore key before-id "-inf" "limit" 0 limit))

      after-id
      (wcar* db (car/zrangebyscore key after-id "+inf"))))))

(defn batch-get-channels-latest-messages
  [db channels-ids limit]
  (when (seq channels-ids)
    (let [result (wcar* db
                        (doseq [channel-id channels-ids]
                          (let [key (rk channels-redis-key channel-id)]
                            (car/zrevrangebyscore key "+inf" "-inf" "limit" 0 limit))))]
      (zipmap (map str channels-ids) result))))

(defn delete-delivered-messages
  [db user-id id]
  (wcar* db
         (car/zremrangebyscore (rk user-id)
                               "-inf"
                               id)))

(comment
  (do (require 'seeds.db)
      (let [users (:users seeds.db/seeds)]
        (def db api.db.util/default-db)
        (def id1 (:id (nth users 0)))
        (def id2 (:id (nth users 1)))
        (def id3 (:id (nth users 2)))
        (def id4 (:id (nth users 3)))

        (create (:redis env) {:id (api.util/flake-id)
                              :user_id "20000000-81c1-4f1a-aa22-eeb57d2eea98"
                              :to_id "10000000-3c59-4887-995b-cf275db86343"
                              :body "Good, I like this!"
                              :created_at (clj-time.coerce/to-date (clj-time.core/now))})

        (create (:redis env) {:id (api.util/flake-id)
                              :user_id "10000000-3c59-4887-995b-cf275db86343"
                              :to_id "20000000-81c1-4f1a-aa22-eeb57d2eea98"
                              :body "Hi tienson"
                              :created_at (clj-time.coerce/to-date (clj-time.core/now))})

        (channels-create (:redis env) {:id (api.util/flake-id)
                                       :user_id "20000000-81c1-4f1a-aa22-eeb57d2eea98"
                                       :channel_id "10000000-3c59-4887-995b-cf275db86343"
                                       :body "Bingo"
                                       :created_at (clj-time.coerce/to-date (clj-time.core/now))}))))
