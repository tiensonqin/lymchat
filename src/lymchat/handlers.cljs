(ns lymchat.handlers
  (:require
   [reagent.core :as r]
   [re-frame.core :refer [register-handler after dispatch]]
   [schema.core :as s :include-macros true]
   [lymchat.db :refer [app-db]]
   [lymchat.navigation.router :as router]))

;; -- Middleware ------------------------------------------------------------
;;
;; See https://github.com/Day8/re-frame/wiki/Using-Handler-Middleware
;;
(register-handler
 :initialize-db
 (fn [_ _]
   app-db))

(register-handler
 :set-app-ready?
 (fn [db [_ value]]
   (assoc db :app-ready? value)))

(register-handler
 :nav/set-nav
 (fn [db [_ value]]
   (assoc db :nav value)))

(register-handler
 :nav/push
 (fn [db [_ route]]
   (when-let [nav (:nav db)]
     (.push (:navigator nav)
            (.getRoute router/router (:key route))))
   db))
