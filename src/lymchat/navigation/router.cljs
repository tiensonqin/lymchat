(ns lymchat.navigation.router
  (:require [lymchat.utils.module :as m]
            [lymchat.scene.home :refer [home-scene]]
            [lymchat.scene.exponent :refer [exponent-scene]]))

(def router (m/create-router
             (fn []
               #js {:home home-scene
                    :exponent exponent-scene})))
