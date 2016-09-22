(ns lymchat.shared.scene.me
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch]]
            [lymchat.styles :refer [styles pl-style]]
            [lymchat.shared.ui :refer [text view touchable-highlight button colors gradient material-icon icon-button input alert image switch open-url  scroll touchable-opacity modal dimensions StatusBar activity-indicator] :as ui]
            [lymchat.realm :as realm]
            [lymchat.photo :refer [offline-avatar-cp]]
            [lymchat.util :as util]
            [lymchat.fs :as fs]))

(defn seperator-cp
  [num]
  [view {:style {:margin-top num
                 :margin-bottom num}}])

(defn avatar-cp
  []
  (let [me (subscribe [:current-user])
        uploading? (subscribe [:uploading?])]
    (fn []
      (let [{:keys [width height]} (js->clj (.get dimensions "window") :keywordize-keys true)]
        [view {:style (merge (pl-style :header-container)
                             {:background-color "rgba(0,0,0,0.6)"
                              :align-items "center"
                              :justify-content "center"})}
         (when @uploading?
           [activity-indicator {:position "absolute"
                                :top 42
                                :animating true
                                :color "#65BC54"}])

         [touchable-opacity {:on-press (fn [] (dispatch [:nav/pop]))}
          [offline-avatar-cp
           (:id @me)
           (util/get-avatar (:avatar @me) :large)
           {:width width
            :height height
            :resizeMode "contain"}]]]))))

(defn me-cp
  []
  (let [me (subscribe [:current-user])
        invites (subscribe [:invites])
        no-disturb? (subscribe [:no-disturb?])
        hidden-no-disturb? (r/atom @no-disturb?)
        hidden-no-invite? (r/atom (:no_invite @me))]
    (fn []
      [scroll {:style (merge
                       (pl-style :header-container)
                       {:background-color "#efefef"})
               :removeClippedSubviews true
               :automaticallyAdjustContentInsets false}
       [view {:style {:min-height 578}}
        [view {:style {:flex-direction "row"
                       :padding 10
                       :background-color "#ffffff"}}
         [touchable-opacity {:on-press #(dispatch [:nav/push {:key :show-avatar
                                                              :title "Avatar"}])}
          [offline-avatar-cp
           (:id @me)
           (:avatar @me)
           {:width 60
            :height 60
            :border-radius 4}]]
         (let [name-cp (fn [name]
                         [text {:style {:padding-left 10
                                        :font-weight "500"
                                        :font-size 16}}
                          name])]
           [view {:style {:flex 1
                          :flex-direction "column"
                          :justify-content "center"}}
            [touchable-opacity {:on-press (fn []
                                            (dispatch [:nav/push {:key :change-name
                                                                  :title "Change Name"}]))}
             (name-cp (:name @me))]
            [text {:style {:padding-left 10
                           :padding-top 5
                           :font-weight "300"
                           :font-size 14}}
             (str "@" (:username @me))]])
         (when-not (empty? @invites)
           [view {:style {:flex 1
                          :align-items "flex-end"}}
            [touchable-opacity {:style {:padding-top 10
                                        :padding-left 10}
                                :on-press #(dispatch [:nav/push {:key :invitations
                                                                 :title "Invitations"}])}
             [view {:flex-direction "row"
                    :align-items "center"}
              [text {:style {:color "#65BC54"
                             :font-size 24
                             :font-weight "bold"}}
               (count @invites)]
              [text {:style {:color "#65BC54"
                             :font-size 12
                             :font-weight "bold"}}
               " invitations"]]]])]

        [seperator-cp 10]

        [view {:style (:setting-item styles)}
         [text {:style {:font-size 14}}
          "Don't vibrate"]
         (cond
           (ui/android?)
           [ui/md-switch {:trackSize 13
                          :trackLength 32
                          :onColor (:teal100 colors)
                          :thumbOnColor (:teal300 colors)
                          :thumbRadius 10
                          :checked @hidden-no-disturb?
                          :onCheckedChange #(let [v (aget % "checked")]
                                              (prn {:v v})
                                              (reset! hidden-no-disturb? v)
                                              (js/setTimeout (fn [] (dispatch [:set-no-disturb? v])) 50))}]

           :else
           [switch {:on-value-change #(do
                                       (reset! hidden-no-disturb? %)
                                       (js/setTimeout (fn [] (dispatch [:set-no-disturb? %])) 50))
                   :on-tint-color "#65BC54"
                   :value @hidden-no-disturb?}])]

        [view {:style (:setting-item styles)}
         [text {:style {:font-size 14}}
          "Don't invite me"]
         (cond
           (ui/android?)
           [ui/md-switch {:trackSize 13
                          :trackLength 32
                          :onColor (:teal100 colors)
                          :thumbOnColor (:teal300 colors)
                          :thumbRadius 10
                          :checked @hidden-no-invite?
                          :onCheckedChange #(let [v (aget % "checked")]
                                              (reset! hidden-no-invite? v)
                                              (js/setTimeout (fn [] (dispatch [:set-no-dm v])) 50))}]

           :else
           [switch {:on-value-change #(do
                                       (reset! hidden-no-invite? %)
                                       (js/setTimeout (fn [] (dispatch [:set-no-dm %])) 50))
                   :on-tint-color "#65BC54"
                   :value @hidden-no-invite?}])]

        [seperator-cp 10]

        [touchable-highlight {:on-press #(dispatch [:nav/push {:key :set-native-language
                                                               :title "What's your native language?"}])}
         [view {:style (:setting-item styles)}
          [text "Native language"]
          [text (:language @me)]]]

        [seperator-cp 10]

        [touchable-highlight
         {:on-press #(open-url "itms://itunes.apple.com/app/id1134985541")}
         [view (:setting-icon-item styles)
          [material-icon {:name "star-border"
                          :size 20
                          :color "#65BC54"}]
          [text {:style {:padding-left 20}}
           "Write a review"]]]

        (when (ui/ios?)
          [touchable-highlight
           {:on-press #(dispatch [:jump-in-lym])}
           [view (:setting-icon-item styles)
            [material-icon {:name "help-outline"
                            :size 20
                            :color "rgba(0,0,0,0.6)"}]
            [text {:style {:padding-left 20}}
             "Help"]]])

        [seperator-cp 10]

        [touchable-highlight
         {:on-press #(open-url "https://s3.amazonaws.com/lymchat/policy.html")}
         [view (:setting-icon-item styles)
          [material-icon {:name "security"
                          :size 20
                          :color "rgba(0,0,0,0.6)"}]
          [text {:style {:padding-left 20}}
           "Privacy"]]]

        [view {:style (:setting-icon-item styles)}
         [material-icon {:name "code"
                         :size 20
                         :color "rgba(0,0,0,0.6)"}]
         [text {:style {:padding-left 20}}
          "v1.0.2"]]]])))
