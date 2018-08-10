(ns api.handler.admin
  (:require [api.schemas :refer :all]
            [schema.core :as s]
            [plumbing.core :refer :all]
            [environ-plus.core :refer [env]]
            [api.db
             [user :as user]
             [report :as report]
             [util :refer [default-db]]]
            [api.util :refer [flake-id]]
            [api.handler.ws :refer [chsk-send!]]
            [api.db.notification :as notification]
            [clojure.java.jdbc :as j]
            [clj-time.core :as t]
            [clj-time.coerce :as tc]))

(defnk users$GET
  "Get users."
  {:responses {200 s/Any
               400 Wrong
               404 NotFound}}
  [[:request
    [:query-params {limit :- s/Int 200}]]]
  (j/with-db-connection [db default-db]
    {:body (user/get-users db limit)}))

;; block user
(defnk $users$:id$block$PATCH
  "Block user"
  {:responses {200 Ack
               400 Wrong
               401 Unauthorized
               404 Missing}}
  [[:request
    [:uri-args id :- ID]]]
  (j/with-db-transaction [db default-db]
    (user/block db id)
    (report/block db :user id)
    ;; send notification
    (let [msg {:id (flake-id)
               :user_id "10000000-3c59-4887-995b-cf275db86343"
               :to_id (str id)
               :body "Please update your profile picture, then your friends understand that you are really a human. If you don't want to be matched, just toggle don't match me. Hope you agree with this."
               :created_at (tc/to-date (t/now))}]

      (chsk-send! (str id)
                  [:chat/new-message msg])

      (notification/send-notification (:redis env) (str id)
                                      "Lym: Please update your profile picture"
                                      {:type "new-message"
                                       :message msg})))
  ack)

(defnk $users$:id$unblock$PATCH
  "Unblock user"
  {:responses {200 Ack
               400 Wrong
               401 Unauthorized
               404 Missing}}
  [[:request
    [:uri-args id :- ID]]]
  (j/with-db-transaction [db default-db]
    (user/unblock db id)
    (report/unblock db :user id))
  ack)

;; reports
(defnk reports$GET
  "Get reports."
  {:responses {200 s/Any
               400 Wrong
               404 NotFound}}
  [[:request
    [:query-params {limit :- s/Int 200}]]]
  (j/with-db-connection [db default-db]
    {:body (report/get-reports db limit)}))

;; get lym messages
