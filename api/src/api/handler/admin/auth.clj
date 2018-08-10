(ns api.handler.admin.auth
  (:require [api
             [schemas :refer :all]
             [util :refer [app-auth? doc production?]]]
            [api.db
             [user :as user]
             [util :refer [default-db]]]
            [api.services.slack :refer [error]]
            [api.handler.util :refer [admin-token]]
            [environ-plus.core :refer [env]]
            [plumbing.core :refer [defnk]]
            [schema.core :as s]
            [api.pg.core :as pg]
            [clojure.java.jdbc :as j]))

(defnk admin$POST
  "admin login."
  {:responses {200 s/Any
               401 Unauthorized
               400 Wrong}}
  [[:request
    [:body key :- s/Str secret :- s/Str]]]
  (j/with-db-connection [db default-db]
    (if-not (contains? (:admin env) {:key key
                                     :secret secret})
      (unauthorized)
      {:body (admin-token db)})))
