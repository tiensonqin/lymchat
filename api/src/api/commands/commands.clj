(ns api.commands.commands
  (:require [api.services.s3 :refer [put-image]]
            [clojure.java.jdbc :as j]
            [api.db.util :refer [default-db]]
            [clojure.string :as str]
            [api.util :refer [get-avatar]]
            [api.db.user :as user]
            [api.db.channel :as channel]
            [taoensso.carmine :as car]
            [api.util :refer [wcar*]]
            [environ-plus.core :refer [env]]))

(defn fb-avatar
  ([id]
   (fb-avatar id nil nil))
  ([id width height]
   (str "http://graph.facebook.com/" id "/picture?"
        (if (and width height)
          (str "width=" width "&height=" height)
          "type=large"))))

(defn all-avatars->s3
  []
  (let [users (j/query default-db ["select * from users"])]
    (doseq [{:keys [id flake_id avatar channels] :as user} users]
      (when-not (re-find #"cloudfront.net" avatar)
        (let [source (put-image (str id) (get-avatar avatar))]
          (user/update default-db id {:avatar source})
          ;; update channels
          (doseq [channel channels]
            (wcar* (:redis env)
                   (car/zremrangebyscore (str channel/redis-members-key channel) (:flake_id user) (:flake_id user))
                   (car/zadd (str channel/redis-members-key channel) (:flake_id user) (assoc user :avatar source)))))))))

(defn rebuild-members-cache
  []
  (j/with-db-connection [db default-db]
    (let [users (j/query db ["select * from users"])]
      (doseq [{:keys [id username channels] :as user} users]
        (doseq [channel channels]
          (wcar* (:redis env)
                 (car/zremrangebyscore (str channel/redis-members-key channel) (:flake_id user) (:flake_id user))
                 (car/zadd (str channel/redis-members-key channel) (:flake_id user) user)))))))

(defn rebuild-channels-members
  "Remove channel members cache, reload users."
  []
  (j/with-db-connection [db default-db]
    (let [channels (j/query db ["select * from channels"])]
      (doseq [{:keys [id name members_count] :as channel} channels]
        (when (> members_count 0)
          (let [members (channel/get-db-members db id)]
            (wcar* (:redis env)
                   (car/del (str channel/redis-members-key channel))
                   (doseq [{:keys [user_id]} members]
                     (when-let [user (first (j/query db ["select * from users where id = ?" user_id]))]
                       (car/zadd (str channel/redis-members-key id) (:flake_id user) user))))))))))

(defn delete-user
  [user_id]
  (j/with-db-connection [db default-db]
    (let [user (first (j/query db ["select * from users where id = ?" user_id]))]
      (doseq [channel-id (:channels user)]
        (wcar* (:redis env)
               (car/zremrangebyscore (str channel/redis-members-key channel-id) (:flake_id user) (:flake_id user))))
      (j/delete! db "users" ["id = ?" user_id]))))

(defn rebuild-members-count
  []
  (j/with-db-connection [db default-db]
    (let [channels (->> (j/query db ["select * from channels_members"])
                        (group-by :channel_id))]
      (doseq [[channel-id members] channels]
        (channel/update default-db channel-id {:members_count (count members)})
        (wcar* (:redis env)
               (car/del (str channel/redis-members-key channel-id))
               (doseq [{:keys [user_id]} members]
                 (when-let [user (first (j/query db ["select * from users where id = ?" user_id]))]
                   (car/zadd (str channel/redis-members-key channel-id) (:flake_id user) user))))))))
