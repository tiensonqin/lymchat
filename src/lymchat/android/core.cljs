(ns lymchat.android.core
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch dispatch-sync]]
            [lymchat.handlers]
            [lymchat.subs]
            [lymchat.styles :refer [styles]]
            [lymchat.shared.ui :refer [text view image touchable-highlight card-stack icon-button colors status-bar push-notification gradient image-prefetch code-push activity-indicator] :as ui]
            [lymchat.shared.scene.chat :as chat]
            [lymchat.shared.scene.group :as group]
            [lymchat.shared.scene.call :as call]
            [lymchat.shared.scene.me :as me]
            [lymchat.shared.scene.profile :as profile]
            [lymchat.shared.scene.contact :as contact]

            [lymchat.shared.scene.mention :as mention]
            [lymchat.shared.scene.member :as member]
            [lymchat.shared.scene.invite :as invite]

            [lymchat.shared.scene.intro :as intro]
            [lymchat.shared.scene.guide :as guide]
            [lymchat.shared.component.navigation :as nav]
            [lymchat.shared.component.language :refer [language-cp]]
            [lymchat.photo :refer [offline-avatar-cp]]
            [lymchat.realm :as realm]
            [lymchat.notification :as notification]
            [lymchat.ws :as ws]
            [lymchat.util :as util]
            [clojure.string :as str]))

(aset js/console "disableYellowBox" true)

(def drawer (.-DrawerLayoutAndroid ui/react-native))

(def drawer-cp (r/adapt-react-class drawer))

(defn button-cp
  ([title icon-type icon-name icon-size]
   (button-cp title icon-type icon-name icon-size nil))
  ([title icon-type icon-name icon-size badge]
   (let [badge (if (or (nil? badge) (zero? badge))
                 nil
                 badge)
         c (if (= icon-type :material)
             ui/material-icon-button
             ui/icon-button)]
     [view {:style {:padding-left 20
                    :padding-top 5
                    :padding-bottom 5}}
      [c {:name icon-name
          :size icon-size
          :background-color "transparent"
          :color (if badge
                   (:teal400 colors)
                   "#rgba(0,0,0,0.8)")
          :on-press (fn []
                      (dispatch [:drawer/close])
                      (cond
                        (= "Help" title)
                        (dispatch [:jump-in-lym])

                        :else
                        (do
                          (dispatch [:android-reset-tab (str/lower-case title)])
                          (dispatch [:nav/push {:key (keyword (str/lower-case title))
                                                :title title}]))))}
       [text {:style {:color (if badge
                               (:teal400 colors)
                               "#rgba(0,0,0,0.7)")
                      :font-size 16
                      :padding-left (cond
                                      (= icon-name "at")
                                      25

                                      (= icon-name "hashtag")
                                      22

                                      :else
                                      20)}}
        title]

       (if badge
         [text {:style {:color (:teal400 colors)
                        :font-size 16
                        :font-weight "bold"
                        :padding-left 110}}
          badge])]])))

(defn seperator-cp
  []
  [view {:style {:border-width 0.5
                 :border-color "#ccc"
                 :margin-top 10
                 :margin-bottom 10}}])

(defn card-cp
  []
  (let [current-user (subscribe [:current-user])
        {:keys [id avatar username name]} @current-user]
    [ui/touchable-opacity {:style {:flex 1
                                   :padding-top 20
                                   :margin-bottom 20
                                   :padding-left 32
                                   :max-height 150
                                   :background-color (:teal400 colors)
                                   :justify-content "space-between"}
                           :on-press #(dispatch [:drawer/close])}
     [offline-avatar-cp
      id
      avatar
      {:height 60
       :width 60
       :border-radius 30
       :background-color "transparent"}]

     [view {:style {:padding-bottom 20}}
      [text {:style {:font-size 15
                     :font-weight "600"
                     :color "#FFF"}}
       name]
      [text {:style {:margin-top 3
                     :font-size 13
                     :font-weight "400"
                     :color "rgba(255,255,255,0.8)"}}
       (str "@" username)]]]))

(defn navigation-cp
  []
  (let [invites (subscribe [:invites])
        unread-mentions-count (subscribe [:unread-mentions-count])]
    [view {:style {:flex 1
                   :padding-bottom 10
                   :background-color "#efefef"}}

     [card-cp]

     [button-cp "Mentions" :material "notifications" 24 @unread-mentions-count]

     [seperator-cp]

     [button-cp "Groups" :material "group-work" 24]

     [button-cp "Contacts" :material "person" 24]

     [button-cp "Invitations" :material "drafts" 24 (count @invites)]

     [seperator-cp]

     [button-cp "Settings" :material "settings" 24]
     [button-cp "Help" :material "help" 24]]))

(defn home-cp
  [key]
  [view {:style {:flex 1
                 :background-color "#efefef"}}
   (case key
     "mentions" [mention/mentions-cp]
     "groups" [group/groups-cp]
     "settings" [me/me-cp]
     "contacts" [contact/contacts-cp]
     [chat/chats])])

(defn scene [current-tab props]
  (let [idx (aget props "scene" "index")
        current-key (keyword (aget props "scene" "route" "key"))
        user (aget props "scene" "route" "user")
        channel (aget props "scene" "route" "channel")
        url (aget props "scene" "route" "url")
        next-key (keyword (str idx))]
    (case current-key
      :conversation [chat/conversation-cp]
      :channel-conversation [chat/channel-conversation-cp channel]
      :video-call [call/call-cp user]
      :profile [profile/profile-cp user]
      :channel-profile [profile/profile-cp user true]
      :invitations [invite/invite-request-cp]
      :contacts [contact/contacts-cp]
      :set-native-language [language-cp :set-native-lang]
      :show-avatar [me/avatar-cp]
      :photo [chat/photo-cp url]
      :change-name [profile/change-name-cp]
      :search-groups [group/search-cp]
      :channel-members [member/members-cp channel]
      ;; else
      [home-cp (name current-key)])))

(defn wrap-drawer [component]
  [drawer-cp {:drawerWidth 300
              :drawerPosition (aget drawer "positions" "Left")
              :renderNavigationView (fn [] (r/as-element [navigation-cp]))
              :ref (fn [ref-drawer]
                     (dispatch [:drawer/set ref-drawer]))}
   component])

(defn root-cp
  [nav current-user current-tab header? device-token]
  (r/create-class {:component-did-mount (fn []
                                          (util/set-statusbar-background 255 255 255 0.8)
                                          (util/show-statusbar)
                                          (.setBackgroundColor ui/StatusBar (:teal600 colors)))
                   :reagent-render
                   (fn []
                     (.addEventListener ui/back-android
                                        "hardwareBackPress"
                                        #(do
                                           (dispatch [:nav/pop])
                                           true))
                     (util/remove-background-color)

                     (ws/start!)

                     (dispatch [:offline-sync-contacts-avatars])

                     (util/net-handler
                      (fn [net-state]
                        (if (true? net-state)
                          (dispatch [:set-net-state true])
                          (dispatch [:set-net-state false]))))

                     (.configure push-notification
                                 (clj->js
                                  {:onRegister (fn [token]
                                                 (if (nil? @device-token)
                                                   (let [token (aget token "token")]
                                                     (ws/register-token token)
                                                     (reset! device-token token))))
                                   :onNotification (fn [notification]
                                                     (notification/handler (js->clj notification :keywordize-keys true)))
                                   :permissions {:alert true
                                                 :badge true
                                                 :sound true}
                                   :requestPermissions true}))

                     ;; reset badge number to 0
                     (.getApplicationIconBadgeNumber push-notification
                                                     (fn [number]
                                                       (when-not (zero? number)
                                                         (.setApplicationIconBadgeNumber push-notification 0)
                                                         (ws/reset-badge))))

                     [wrap-drawer
                      [card-stack (cond->
                                    {:on-navigate-back #(dispatch [:nav/pop nil])
                                     :navigation-state @nav
                                     :style            {:flex 1}
                                     :render-scene     #(r/as-element
                                                         [view {:style {:flex 1
                                                                        :background-color "transparent"}}
                                                          [status-bar]
                                                          (scene current-tab %)])}
                                    @header?
                                    (assoc :renderHeader #(r/as-element (nav/header current-tab %))))]])}))

(let [device-token (atom nil)]
  (defn app-root []
    (.setHidden ui/StatusBar true)
    (.sync code-push)

    (util/access-google?)

    (let [nav (subscribe [:nav/state])
          current-tab (subscribe [:current-tab])
          header? (subscribe [:header?])
          current-user (subscribe [:current-user])
          signing? (subscribe [:signing?])
          guide-step (subscribe [:guide-step])]
      (fn []
        (cond
          (nil? @current-user)
          [intro/intro-cp]

          @signing?
          [view {:style {:flex 1
                         :justify-content "center"
                         :align-items "center"
                         :background-color "rgba(0,0,0,0.7)"}}
           [activity-indicator {:animating true
                                :size "large"
                                :color "#FFFFFF"}]]

          (and (or (false? (:username @current-user))
                   (empty? (:channels @current-user)))
               (not= :done @guide-step))
          (do
            (ws/start!)
            [guide/guide-cp])

          :else
          [root-cp nav current-user current-tab header? device-token])))))

(defn init []
  (dispatch-sync [:initialize-db])
  (.registerComponent ui/app-registry "Lymchat" #(r/reactify-component app-root)))
