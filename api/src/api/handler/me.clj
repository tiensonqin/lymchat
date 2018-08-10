(ns api.handler.me
  (:require [api
             [schemas :refer :all]
             [util :refer [doc]]]
            [api.db
             [user :as user]
             [channel :as channel]
             [mention :as mention]
             [util :refer [default-db]]]
            [api.services.slack :refer [error]]
            [api.handler.util :refer [join]]
            [environ-plus.core :refer [env]]
            [plumbing.core :refer [defnk]]
            [schema.core :as s]
            [clojure.java.jdbc :as j]
            [clojure.string :as str]))

(defnk $PATCH
  "Update current user"
  {:responses {200 Ack
               400 Wrong
               401 Unauthorized
               404 Missing}}
  [[:request
    [:custom user-id :- ID]
    body :- UserPatch]]
  (j/with-db-connection [db default-db]
    (let [result (user/update db user-id body)]
      (when (:username body)
        ;; join lym channel
        (join db #uuid "10000000-3c59-4887-995b-cf275db86343" user-id))
      (if (= [:error :duplicated] result)
        (bad "Duplicate!")
        ack))))

(defnk $contacts$:id$DELETE
  "Get contacts."
  {:responses {200 s/Any
               404 Missing}}
  [[:request
    [:uri-args id :- ID]
    [:custom user-id :- ID]]]
  (j/with-db-connection [db default-db]
    (user/remove-contact db user-id id)
    ack))

(defnk $channels$search$GET
  "Get matches."
  {:responses {200 s/Any
               404 Missing}}
  [[:request
    [:query-params
     q :- s/Str
     {limit :- s/Int 5}]
    [:custom user-id :- ID]]]
  {:body {:channels (channel/search-by-name-prefix q limit)}})

(defnk $mentions$GET
  "Get mentions."
  {:responses {200 s/Any
               404 Missing}}
  [[:request
    [:query-params
     {before-id :- s/Int nil}
     {after-id :- s/Int nil}
     {limit :- s/Int 20}]
    [:custom user-id :- ID]]]
  {:body {:mentions (mention/get (:redis env) user-id {:before-id before-id
                                                       :after-id after-id
                                                       :limit limit})}})
