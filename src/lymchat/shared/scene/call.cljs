(ns lymchat.shared.scene.call
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch]]
            [lymchat.styles :refer [styles]]
            [lymchat.shared.ui :refer [text view image rtc-view button colors StatusBar touchable-opacity dimensions material-icon] :as ui]
            [lymchat.util :as util]))

(defn call-cp
  [user]
  (r/create-class
   {:component-did-mount (fn []
                           (js/setTimeout (fn []
                                            (util/remove-header))
                                          300))
    :reagent-render
    (fn [user]
      (let [remote-stream (subscribe [:remote-stream])
            local-stream (subscribe [:local-stream])
            {:keys [name avatar]} (js->clj user :keywordize-keys true)
            {:keys [width height]} (js->clj (.get dimensions "window") :keywordize-keys true)
            show-hangup? (r/atom true)]
        (fn []
          (when @local-stream
            [view {:style {:flex 1}
                   :onStartShouldSetResponder (fn []
                                                (swap! show-hangup? not)
                                                true)
                   :onResponderRelease (fn []
                                         (prn "release"))}
             (when @remote-stream
               (if (ui/ios?)
                 [rtc-view {:style (:background-stream styles)
                            :objectFit "cover"
                            :streamURL (.toURL @remote-stream)}]

                 [rtc-view {:style {:flex 1}
                            :objectFit "cover"
                            :streamURL (.toURL @remote-stream)}]))

             (if @remote-stream
               [rtc-view {:style (:top-stream styles)
                          :streamURL (.toURL @local-stream)}]

               [rtc-view {:style (:background-stream styles)
                          :objectFit "cover"
                          :streamURL (.toURL @local-stream)}])

             (when-not @remote-stream
               [view {:style {:flex 1
                              :flex-direction "row"
                              :position "absolute"
                              :top 20
                              :padding 10
                              :width width
                              :background-color "rgba(0,0,0,0.2)"}}
                [image {:source {:uri avatar}
                        :style {:height 60
                                :width 60
                                :border-radius 6}}]

                [view {:style {:padding 10}}
                 [text {:style {:font-size 20
                                :font-weight "bold"
                                :color "#ffffff"}}
                  name]
                 [text {:style {:padding-top 10
                                :color "#ffffff"}}
                  "Connecting..."]]])

             (when @show-hangup?
               (do
                 (when @remote-stream (js/setTimeout (fn [] (swap! show-hangup? not)) 3000))
                 [view {:style {:position "absolute"
                                :bottom 50
                                :left (/ (- width 60) 2)}}
                  [touchable-opacity {:style {:background-color "transparent"}}
                   [button {:style {:border-width 0
                                    :border-radius 30
                                    :height 60
                                    :width 60
                                    :background-color "#EA384D"}
                            :text-style {:font-size 20
                                         :color "#FFFFFF"}
                            :on-press #(dispatch [:hangup])}
                    [material-icon {:name "call-end"
                                    :size 24
                                    :color "#ffffff"}]]]]))]))))}))
