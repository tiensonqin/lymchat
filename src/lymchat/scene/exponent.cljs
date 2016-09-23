(ns lymchat.scene.exponent
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch dispatch-sync]]
            [lymchat.utils.module :as m]))

(defn exponent-scene
  []
  (r/create-class
   {:route {:navigationBar {:title "Exponent"
                            :backgroundColor "red"}}
    :reagent-render
    (fn []
      [m/view {:style {:align-items "center"
                       :justify-content "center"
                       :flex 1}}
       [m/text "Exponent scene!"]])}))
