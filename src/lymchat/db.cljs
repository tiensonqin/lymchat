(ns lymchat.db
  (:require [schema.core :as s :include-macros true]))

(def schema {:app-ready? s/Bool
             :nav {:nav s/Any}})

(def app-db {:app-ready? false
             :nav {:nav nil}})
