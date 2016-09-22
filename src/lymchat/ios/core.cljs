(ns lymchat.ios.core
  (:require [reagent.core :as r]
            [re-frame.core :refer [dispatch-sync]]
            [lymchat.handlers]
            [lymchat.subs]
            [lymchat.shared.scene.root :as root]
            [lymchat.shared.ui :as ui]))

(def app-root #'root/app-root)

(defn init []
  (dispatch-sync [:initialize-db])
  (.registerComponent ui/app-registry "Lymchat" #(r/reactify-component app-root)))
