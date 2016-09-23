(ns lymchat.db
  (:require [schema.core :as s :include-macros true]))

(def schema {:app-ready? s/Bool})

(def app-db {:app-ready? false})
