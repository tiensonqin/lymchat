(ns api.handler.invite
  (:require [api
             [schemas :refer :all]
             [util :refer [doc]]]
            [api.db
             [invite :as invite]
             [util :refer [default-db]]]
            [api.services.slack :refer [error]]
            [environ-plus.core :refer [env]]
            [plumbing.core :refer [defnk]]
            [schema.core :as s]
            [clojure.java.jdbc :as j]
            [api.db.user :as user]
            [api.handler.ws :as ws]
            [api.db.notification :as notification]
            [clj-time.core :as t]
            [clj-time.coerce :as tc]))

(defnk $POST
  "Issue a invite request."
  {:responses {200 Ack
               401 Unauthorized
               400 Wrong}}
  [[:request [:body user_id :- ID invite_id :- ID]]]
  (j/with-db-connection [db default-db]
    (cond
      (true? (:no_invite (user/get db invite_id)))
      ack

      (user/item-exists db user_id "contacts" invite_id)
      (bad "Already in your contact.")

      :else
      (if-let [issue (-> (user/get-bare db user_id)
                         (update :id str))]
        (let [redis (:redis env)
              issue-name (:name issue)
              data {:type :invite-request
                    :user issue}]
          (invite/create db user_id invite_id)

          ;; ws notification
          (ws/send-invitation (str invite_id) issue)

          ;; push notification
          (notification/send-notification redis
                                          (str invite_id)
                                          (str issue-name " wants to be your friend.")
                                          data)
          ack)
        (bad "User not exists.")))))

(defnk $reply$POST
  "Reply a friend request."
  {:responses {200 Ack
               401 Unauthorized
               400 Wrong}}
  [[:request
    [:body
     user_id :- ID
     issue_id :- ID
     reply :- s/Bool]]]
  (j/with-db-transaction [db default-db]
    (if (user/item-exists db issue_id "contacts" user_id)
      (bad "Already in your contact.")
      (if (user/exists? db issue_id)
        (let [redis (:redis env)]
          (if reply
            (let [invite (-> (user/get-bare db user_id)
                             (update :id str))
                  data {:type :invite-accept
                        :user invite}]
              (invite/accept db user_id issue_id)

              (ws/send-message {:user_id (str user_id)
                                :to_id (str issue_id)
                                :body "I accept your friend invitation, now we can talk."
                                :data data})

              ;; push notification
              (notification/send-notification redis
                                              (str issue_id)
                                              "I accept your friend invitation, now we can talk."
                                              data))

            (invite/reject db user_id issue_id))
          ack)
        (bad "issue_id not exists.")))))
