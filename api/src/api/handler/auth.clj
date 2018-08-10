(ns api.handler.auth
  (:require [api
             [schemas :refer :all]
             [util :refer [app-auth? doc production? get-avatar get-cdn-path]]]
            [api.db
             [user :as user]
             [util :refer [default-db wrap-temp-username]]]
            [api.services.slack :refer [error]]
            [api.services.s3 :refer [put-image]]
            [api.handler.util :refer [user-token]]
            [environ-plus.core :refer [env]]
            [plumbing.core :refer [defnk]]
            [schema.core :as s]
            [api.pg.core :as pg]
            [clojure.java.jdbc :as j]))

(defnk $POST
  "Authenticate."
  {:responses {200 s/Any
               401 Unauthorized
               400 Wrong}}
  [[:request
    body :- s/Any
    [:custom app-key :- s/Str]]]
  (let [body (dissoc body :app-key :app-secret)]
    (j/with-db-transaction [db default-db]
      (if-let [user (user/get-by-oauth db (:oauth_type body) (:oauth_id body))]
        {:body (user-token db user app-key)}

        (let [body (wrap-temp-username body)
              new-user (user/create db body)
              avatar-name (str (:id new-user))]
          ;; s3 upload avatar
          (future
            (put-image avatar-name (get-avatar (:avatar new-user)))
            (user/update db (:id new-user) {:avatar (get-cdn-path avatar-name)}))
          {:body (assoc
                  (user-token db new-user app-key)
                  :new true)})))))
