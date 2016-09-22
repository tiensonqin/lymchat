(ns lymchat.shared.scene.profile
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch dispatch-sync]]
            [lymchat.styles :refer [styles pl-style]]
            [lymchat.shared.ui :refer [text view image touchable-highlight touchable-opacity button icon icon-button material-icon-button colors gradient scroll alert input dimensions run-after-interactions]]
            [lymchat.realm :as realm]
            [lymchat.util :as util]))

(defn seperator-cp
  []
  [view {:style {:border-width 0.5
                 :border-color "#ccc"
                 :margin-top 10
                 :margin-bottom 10}}])

(defn buttons-cp
  [user]
  (let [invite? (r/atom false)]
    (fn []
      [view {:style {:flex-direction "row"
                     :justify-content "space-between"
                     :margin-bottom 15}}
       (if (realm/friend? (:id user))
         [button {:style {:border-width 1.5
                          :border-color "#rgba(0,0,0,0.3)"
                          :border-radius 4
                          :width 120
                          :height 40
                          :background-color "transparent"}
                  :text-style {:font-size 20
                               :font-weight "500"
                               :color "#rgba(0,0,0,0.6)"}
                  :on-press #(do
                               (dispatch [:pop-jump-in-conversation user]))}
          "Message"]
         [button {:style {:border-width 1.5
                          :border-color (if @invite? "#65BC54" "#rgba(0,0,0,0.3)")
                          :border-radius 4
                          :width 120
                          :height 40
                          :background-color "transparent"}
                  :text-style {:font-size 20
                               :font-weight "500"
                               :color (if @invite? "#65BC54" "#rgba(0,0,0,0.6)")}
                  :on-press #(dispatch [:send-invite (:id user) invite?])}
          (if @invite? "Sent" "Invite")])])))

(defn profile-cp
  ([user]
   (profile-cp user false))
  ([user show-buttons?]
   (if user
     (let [current-user (subscribe [:current-user])
          in-channel? show-buttons?
          self? (= (str (:id @current-user)) (str (aget user "id")))]
       (let [user (js->clj user :keywordize-keys true)
            {:keys [id name username avatar language timezone]} user
            {:keys [width height]} (js->clj (.get dimensions "window") :keywordize-keys true)]
         [view {:style (pl-style :header-container)}
         [image {:style {:width width
                         :height 250
                         :resizeMode "cover"}
                 :source {:uri (util/get-avatar avatar :large)}}]
          [view {:style {:position "absolute"
                        :left 10
                        :top 215}}
          [text {:style {:font-size 16
                         :font-weight "bold"
                         :color "#FFFFFF"}}
           (str "@" username)]]

         [view {:style {:background-color "#FFF"
                        :flex 1
                        :padding-top 15
                        :padding-left 15
                        :padding-right 15}}
          (if (and show-buttons? (not self?))
            [buttons-cp user])

          [text {:style {:color "grey"}}
           "Native language"]
          [text {:style {:margin-top 5
                         :font-size 16}}
           language]

          [seperator-cp]

          (when timezone
            [view
             [text {:style {:color "grey"}}
              "Timezone"]
             [text {:style {:margin-top 5
                            :font-size 16}}
              timezone]

             [seperator-cp]])]]))
     [view {:style (merge
                    (pl-style :header-container)
                    {:justify-content "center"
                     :align-items "center"})}
      [text {:style {:fontFamily "Cochin"
                     :font-size 20}}
       "Username not exists."]])))

(defn change-name-cp
  []
  (let [current-user (subscribe [:current-user])
        first-name (r/atom "")
        last-name (r/atom "")]
    (fn []
      [view {:style (assoc (pl-style :header-container)
                           :padding 20
                           :background-color "#efefef")}
       [input {:style {:padding-left 10
                       :font-size 16
                       :border-width 2
                       :border-color "rgba(0,0,0,0.4)"
                       :border-radius 6}
               :height 40
               :auto-correct true
               :maxLength 32
               :clear-button-mode "always"
               :value @first-name
               :placeholder "First name"
               :on-change-text (fn [value]
                                 (reset! first-name value)
                                 (r/flush))}]

       [input {:style {:margin-top 30
                       :padding-left 10
                       :font-size 16
                       :border-width 2
                       :border-color "rgba(0,0,0,0.4)"
                       :border-radius 6}
               :height 40
               :auto-correct true
               :maxLength 32
               :clear-button-mode "always"
               :value @last-name
               :placeholder "Last name"
               :returnKeyType "go"
               :onSubmitEditing (fn []
                                  ;; validate
                                  (if (or (nil? (re-find util/name-pattern @first-name))
                                          (nil? (re-find util/name-pattern @last-name)))
                                    (alert "Sorry, please input valid name!")
                                    (dispatch [:set-name @first-name @last-name])))
               :on-change-text (fn [value]
                                 (reset! last-name value)
                                 (r/flush))}]])))
