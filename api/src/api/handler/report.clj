(ns api.handler.report
  (:require [api
             [schemas :refer :all]
             [util :refer [doc]]]
            [api.db
             [report :as report]
             [util :refer [default-db]]]
            [api.services.slack :refer [error]]
            [environ-plus.core :refer [env]]
            [plumbing.core :refer [defnk]]
            [schema.core :as s]
            [clojure.java.jdbc :as j]
            [api.pg.core :as pg]))

(defnk $POST
  "Create new report."
  {:responses {201 s/Any
               401 Unauthorized
               400 Wrong
               404 NotFound}}
  [[:request body :- NewReport]]
  (j/with-db-connection [db default-db]
    (let [new-report (report/create db body)]
      {:status 201
       :body new-report})))
