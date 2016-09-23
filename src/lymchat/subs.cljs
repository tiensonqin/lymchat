(ns lymchat.subs
  (:require-macros [reagent.ratom :refer [reaction]])
  (:require [re-frame.core :refer [register-sub subscribe]]))

(register-sub
 :app-ready?
 (fn [db _]
   (reaction (:app-ready? @db))))
