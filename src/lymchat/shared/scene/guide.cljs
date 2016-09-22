(ns lymchat.shared.scene.guide
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch]]
            [lymchat.styles :refer [styles]]
            [lymchat.shared.ui :refer [text view image  material-icon-button colors status-bar activity-indicator button input touchable-opacity scroll]]
            [lymchat.util :as util]
            [lymchat.realm :as realm]
            [lymchat.shared.ui :as ui]
            [lymchat.shared.scene.recommend-channels :refer [recommend-channels]]))

(defn set-username-cp
  []
  (let [current-user (subscribe [:current-user])
        current-input (subscribe [:username-input])
        loading? (subscribe [:loading?])
        hidden-input (r/atom nil)]
    (fn []
      [view {:style {:flex 1
                     :flex-direction "column"
                     :padding-left 30
                     :padding-top 50}}
       [input {:style {:height 80
                       :borderWidth 0
                       :font-size 30
                       :font-weight "bold"
                       :color "#FFFFFF"
                       :fontFamily "Optima-Bold"
                       :background-color "transparent"}
               :selectionColor "#FFF"
               :auto-correct false
               :clear-button-mode "always"
               :auto-focus true
               :autoCapitalize "none"
               :maxLength 15
               :return-key-type "go"
               :value @hidden-input
               :on-change-text (fn [value]
                                 (cond
                                   (clojure.string/blank? value)
                                   (do
                                     (dispatch [:set-username-input ""])
                                     (reset! hidden-input ""))

                                   (nil? (re-find util/username-pattern value))

                                   (let [v (subs value 0 (dec (count value)))]
                                     (dispatch [:set-username-input v])
                                     (reset! hidden-input v))

                                   :else
                                   (do
                                     (dispatch [:set-username-input value])
                                     (reset! hidden-input value)))
                                 (r/flush))
               :onSubmitEditing #(when-not (clojure.string/blank? @hidden-input)
                                   (dispatch [:set-username @hidden-input]))
               :placeholderTextColor "#FFF"
               :placeholder "Your username"}]])))

(defn channel-cp
  [{:keys [id name picture type] :as channel}]
  [touchable-opacity {:style {:flex 1
                              :padding 10}
                      :underlay-color "#eee"
                      :on-press (fn []
                                  (dispatch [:join-channel (clj->js channel)])
                                  (dispatch [:set-guide-step :done]))}
   [view {:key id
          :style {:flex-direction "row"}}
    [view {:style {:width 87
                   :height 87
                   :border-radius 4
                   :background-color "rgba(255,255,255,1)"
                   :flex 1
                   :align-items "center"
                   :justify-content "center"}}
     [text {:style {:font-size 18
                    :align-self "center"}}
      (str "#" name)]]]])

(defn vertical-scroll-cp
  [channels]
  [scroll
   {:automaticallyAdjustContentInsets false
    :scrollEventThrottle 200}
   (for [channel channels]
     ^{:key (:id channel)} [channel-cp channel])])

(defn add-channels-cp
  []
  [view {:style {:flex 1
                 :padding 30}}
   [text {:style {:font-size 20
                  :font-weight "bold"
                  :color "#FFFFFF"
                  :fontFamily "Optima-Bold"
                  :background-color "transparent"}}
    "Culture is the door, Language is the key. Which group you want to join?"]

   [view {:style {:flex 1
                  :margin-top 20}}
    (let [channels (:languages recommend-channels)]
      [vertical-scroll-cp channels])]])

(defn guide-cp
  []
  (util/remove-background-color)
  (let [current-user (subscribe [:current-user])
        guide-step (subscribe [:guide-step])
        username-set? (subscribe [:username-set?])]
    (fn []
      [view {:style {:flex 1
                     :background-color (:teal600 colors)}}
       (cond
         (false? @username-set?)
         [set-username-cp]

         (empty? (:channels @current-user))
         [add-channels-cp]

         :else
         (dispatch [:set-guide-step :done]))])))
