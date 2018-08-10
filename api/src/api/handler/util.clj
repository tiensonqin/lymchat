(ns api.handler.util
  (:require [api.db.user :as user]
            [api.db.channel :as channel]
            [api.db.message :as message]
            [api.handler.ws :as ws]
            [api.middlewares.auth :refer [build-token]]
            [environ-plus.core :refer [env]]
            [clj-time.core :as t]
            [api.util :refer [flake-id]]))

(defn user-token
  ([db user app-key]
   (user-token db user app-key (t/years 10)))
  ([db user app-key expires]
   {:user user
    :token (build-token (str (:id user)) {:expires expires
                                          :app-key app-key})}))

(defn admin-token
  [db]
  {:token (build-token "10000000-3c59-4887-995b-cf275db86343"
                       {:expires (t/months 2)})})

(defn success?
  [r]
  {:pre (integer? (:status r))}
  (<= 200 (:status r) 299))

(defn join
  [db id user-id]
  (when-not (channel/member-exists? db id user-id)
    (channel/join db id user-id)
    (channel/inc-members db id)
    (user/add-channel db user-id id)
    ;; ws notification
    (when-let [user (user/get db user-id)]
      (let [msg {:id (flake-id)
                 :channel_id (str id)
                 :body "joined, welcome!"
                 :name (:name user)
                 :username (:username user)
                 :avatar (:avatar user)
                 :user_id (str user-id)
                 :language (:language user)
                 :timezone (:timezone user)}]
        (message/channels-create (:redis env) msg)
        (ws/send-channel-message msg)))))
