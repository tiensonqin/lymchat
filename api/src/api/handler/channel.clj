(ns api.handler.channel
  (:require [api
             [schemas :refer :all]
             [util :refer [doc]]]
            [api.db
             [channel :as channel]
             [user :as user]
             [message :as message]
             [util :refer [default-db]]]
            [api.handler.ws :as ws]
            [api.handler.util :refer [join]]
            [api.services.slack :refer [error]]
            [environ-plus.core :refer [env]]
            [plumbing.core :refer [defnk]]
            [schema.core :as s]
            [clojure.java.jdbc :as j]
            [api.pg.core :as pg]))

(defnk $:id$join$GET
  "Join channel."
  {:responses {200 s/Any
               401 Unauthorized
               400 Wrong
               404 NotFound}}
  [[:request
    [:uri-args id :- ID]
    [:custom user-id :- ID]]]
  (j/with-db-transaction [db default-db]
    (join db id user-id)
    {:body {:messages (message/get-channel-latest-messages (:redis env) id)}}))

(defnk $:id$leave$GET
  "Leave channel."
  {:responses {200 Ack
               401 Unauthorized
               400 Wrong
               404 NotFound}}
  [[:request
    [:uri-args id :- ID]
    [:custom user-id :- ID]]]
  (j/with-db-transaction [db default-db]
    (when (channel/member-exists? db id user-id)
      (channel/leave db id user-id)
      (channel/dec-members db id)
      (user/remove-channel db user-id id)
      (when-let [user (user/get db user-id)]
        (ws/send-channel-message
         {:channel_id (str id)
          :body "left"
          :name (:name user)
          :username (:username user)
          :avatar (:avatar user)
          :user_id (str user-id)
          :language (:language user)
          :timezone (:timezone user)}))))
  ;; ws notification
  ack)
