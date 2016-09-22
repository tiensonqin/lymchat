(ns lymchat.shared.component.navigation
  (:require [reagent.core :as r]
            [re-frame.core :refer [dispatch dispatch-sync subscribe]]
            [lymchat.styles :refer [styles pl-style]]
            [lymchat.shared.ui :refer [header-title navigation-header icon-button material-icon-button view touchable-opacity touchable-highlight image text icon colors alert prompt input] :as ui]
            [lymchat.realm :as realm]
            [lymchat.util :as util]
            [lymchat.photo :refer [offline-avatar-cp] :as photo]
            [clojure.string :as str]))

(defn nav-title [props]
  (let [title (aget props "scene" "route" "title")
        style (if (= "Lymchat" title)
                {:color "#65BC54"
                 :font-size 24
                 :fontFamily "Bodoni Ornaments"}
                (pl-style :header-text))
        title (cond
                (= "Lymchat" title)
                (if (ui/ios?)
                  "∞"
                  "")
                :else
                title)]
    (cond
      (= "Contacts" title)
      [input {:style (:header-search-text-input styles)
              :auto-correct false
              :autoCapitalize true
              :clear-button-mode "always"
              :underlineColorAndroid "transparent"
              :on-change-text (fn [value]
                                (when-not (str/blank? value)
                                  (dispatch [:reset-contact-search-input value])))
              :placeholder "Search Contacts"
              :textAlignVertical "center"
              :placeholderTextColor "rgba(255,255,255,0.7)"
              :tintColor "#FFF"}]

      (and (ui/android?) (= "Groups" title))
      [input {:style (:header-search-text-input styles)
              :auto-correct false
              :auto-focus true
              :autoCapitalize true
              :clear-button-mode "always"
              :underlineColorAndroid "transparent"
              :on-change-text (fn [value]
                                (dispatch [:reset-channels-search-input value])
                                (dispatch [:load-channels-search-result value]))
              :placeholder "Search Groups"
              :textAlignVertical "center"
              :placeholderTextColor "rgba(255,255,255,0.7)"
              :tintColor "#FFF"}]

      :else
      [header-title {:children title
                     :style (pl-style :header-title)
                     :text-style style}])
    ))

(defn nav-left [props]
  (let [nav (subscribe [:nav/state])
        index (aget props "scene" "index")
        current-tab (subscribe [:current-tab])
        new-message? (subscribe [:new-message?])
        key (aget props "scene" "route" "key")
        root? (zero? index)]
    (cond
      (and root? (ui/ios?))
      nil

      (and root? (ui/android?))
      [view {:style {:flex-direction "row"}}
       [ui/md-button {:maskColor "transparent"
                      :on-press #(dispatch [:drawer/open])}
        [ui/material-icon {:name "menu"
                           :size 23
                           :color "#FFF"
                           :style {:margin-left 16
                                   :margin-right 16
                                   :margin-top 18
                                   :margin-bottom 18}}]]
       [text {:style {:font-size 20
                      :color "#FFF"
                      :font-weight "500"
                      :align-self "center"
                      :padding-left 14}}
        "Lymchat"]]

      (ui/android?)
      [ui/md-button {:maskColor "transparent"
                     :on-press (fn []
                                 (dispatch [:nav/pop])
                                 (when (or (= key "conversation") (= key "channel-conversation"))
                                   (dispatch [:delete-current-callee]))

                                 (dispatch [:set-channel-auto-focus false])
                                 (dispatch [:restore-search])
                                 (dispatch [:set-new-message? false]))}
       [ui/material-icon {:name "arrow-back"
                          :size 30
                          :color "#FFF"
                          :style {:margin-left 12
                                  :margin-top 15
                                  :margin-bottom 15
                                  :margin-right 12}
                          }]]

      :else
      [view {:style {:margin-top -20}}
       (let [ks (map :key (:routes @nav))
             handler-key (if (and (= 2 (:index @nav))
                                  (or (= ks [:lymchat :contacts :conversation])
                                      (= ks [:lymchat :invitations :conversation])))
                           :nav/home
                           :nav/pop)]
         [touchable-opacity {:style {:padding 10
                                     :margin-top -12
                                     :background-color "transparent"}
                             :on-press #(do
                                          (dispatch [handler-key])
                                          (when (and (= "Mentions" @current-tab) (= :channel-conversation (last ks)))
                                            (util/hide-header))

                                          (when (or (= key "conversation") (= key "channel-conversation"))
                                            (dispatch [:delete-current-callee]))

                                          (dispatch [:set-channel-auto-focus false])
                                          (dispatch [:restore-search])
                                          (dispatch [:set-new-message? false])
                                          )}
          [text {:style (cond-> (:back-button styles)
                          @new-message?
                          (assoc :color "#65BC54"))} "‹"]])])))

(defn show-channel-conversation-action-sheet
  [channel]
  (let [{:keys [id]} (js->clj channel :keywordize-keys true)
        buttons ["Leave"
                 "Cancel"]
        options (cond
                  (ui/ios?)
                  {:options buttons
                   :destructiveButtonIndex 0
                   :cancelButtonIndex 1}

                  (ui/android?)
                  buttons

                  :else
                  nil)
        handler (fn [i] (case i
                         0 (dispatch [:leave-channel-then-back id])

                         ;; cancel
                         nil))]
    (ui/actions options handler)))

(defn show-profile-action-sheet
  [user in-channel?]
  (let [{:keys [id name avatar]} (js->clj user :keywordize-keys true)
        buttons (if in-channel?
                  ["Report"
                   "Cancel"]
                  ["Report"
                   "Delete"
                   "Cancel"])
        options (cond
                  (ui/ios?)
                  (if in-channel?
                    {:options buttons
                     :cancelButtonIndex 1}
                    {:options buttons
                     :destructiveButtonIndex 1
                     :cancelButtonIndex 2})

                  (ui/android?)
                  buttons

                  :else
                  nil)
        handler (fn [i] (if in-channel?
                         (case i
                           0 (prompt (str "I want to report " name ".")
                                     nil
                                     (fn [title]
                                       (when title
                                         (dispatch [:report {:type "user"
                                                             :type_id id
                                                             :title title
                                                             :picture avatar}]))))
                           ;; cancel
                           nil)
                         (case i
                           0 (prompt (str "I want to report " name ".")
                                     nil
                                     (fn [title]
                                       (when title
                                         (dispatch [:report {:type "user"
                                                             :type_id id
                                                             :title title
                                                             :picture avatar}]))))

                           1 (alert (str "Do you want to delete contact " name "?")
                                    ""
                                    [{:text "Yes"
                                      :onPress #(do
                                                  (dispatch [:delete-contact id]))}
                                     {:text "Cancel"
                                      :style "cancel"}])

                           ;; cancel
                           nil)))]
    (ui/actions options handler)))

(defn nav-right [current-tab props]
  (let [current-user (subscribe [:current-user])
        current-channel-members-count (subscribe [:current-channel-members-count])]
    (let [key (aget props "scene" "route" "key")
          channel (aget props "scene" "route" "channel")
          user (aget props "scene" "route" "user")]
      [view {:style {:margin-top -23}}
       (cond (= key "conversation")
             (let [current-callee @(subscribe [:current-callee])]
               (when-let [callee (cond
                                   (some? current-callee)
                                   (some-> (realm/get-by-id "Contact" current-callee)
                                           (realm/jsx->clj))

                                   :else
                                   nil)]
                 [view {:flex-direction "row"
                        :padding-right 6}
                  [touchable-opacity
                   [material-icon-button (merge
                                          {:name "videocam"
                                           :on-press (fn []
                                                       (dispatch [:call-initial callee]))}
                                          (pl-style :video-call-icon))]]

                  [touchable-opacity {:on-press #(dispatch [:nav/push {:key :profile
                                                                       :title (:name callee)
                                                                       :user callee}])}
                   [image {:source {:uri (:avatar callee)}
                           :style (merge
                                   {:width 30
                                    :height 30
                                    :border-radius 15}
                                   (pl-style :avatar-icon))}]]]))

             (= key "channel-conversation")
             [view {:flex-direction "row"
                    :padding-right 10
                    :align-items "center"}
              [touchable-opacity {:on-press #(dispatch [:nav/push {:key :channel-members
                                                                   :title (str "#" (aget channel "name") " members")
                                                                   :channel channel}])}
               [text {:style (pl-style :channel-members-count)}
                @current-channel-members-count]]

              [touchable-opacity {:on-press #(show-channel-conversation-action-sheet channel)}
               [text {:style (pl-style :right-menu)}
                "..."]]]

             (= key "channel-members")
             nil

             (= key "contacts")
             nil

             (= key "show-avatar")
             [touchable-opacity {:style {:background-color "transparent"}}
              [material-icon-button (merge
                                     {:name "camera-alt"
                                      :on-press (fn [] (photo/upload (:id @current-user) :avatar))}
                                     (pl-style :photo-upload-icon))]]

             (= key "profile")
             [touchable-opacity {:on-press #(show-profile-action-sheet user false)}
              [text {:style (assoc (pl-style :right-menu)
                                   :margin-right 10)}
               "..."]]


             (= key "channel-profile")
             [touchable-opacity {:on-press #(show-profile-action-sheet user true)}
              [text {:style (assoc (pl-style :right-menu)
                                   :margin-right 10)}
               "..."]]

             (= key "invite-request")
             nil

             (= "Lymchat" @current-tab)
             (when (ui/ios?)
               [touchable-opacity {:style {:padding-left 30
                                           :padding-right 6
                                           :padding-top 10
                                           :padding-bottom 6}
                                   :on-press #(do (dispatch [:set-header? false])
                                                  (util/hide-statusbar)
                                                  (dispatch [:reset-contact-search-input nil])
                                                  (dispatch [:nav/push {:key :contacts
                                                                        :title ""}]))}
                [text {:style (:plus-button styles)} "＋"]])

             (and (ui/ios?) (= "Groups" @current-tab))
             [touchable-opacity {:style {:background-color "transparent"}}
              [material-icon-button (merge
                                     {:name "search"
                                      :on-press (fn []
                                                  (dispatch [:nav/push {:key :search-groups
                                                                        :title ""}])
                                                  (util/hide-header)
                                                  (util/hide-statusbar))}
                                     (pl-style :search-icon))]]

             (= "Me" @current-tab)
             nil

             :else
             nil)])))

(defn header
  [current-tab props]
  [navigation-header
   (assoc
    (js->clj props)
    :render-title-component #(r/as-element (nav-title %))
    :render-right-component #(r/as-element (nav-right current-tab %))
    :render-left-component #(r/as-element (nav-left %))
    :style (pl-style :header))])
