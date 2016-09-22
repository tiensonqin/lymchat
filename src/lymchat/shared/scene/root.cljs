(ns lymchat.shared.scene.root
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch]]
            [lymchat.styles :refer [styles]]
            [lymchat.shared.ui :refer [text view image touchable-highlight card-stack icon-button colors status-bar push-notification gradient image-prefetch code-push activity-indicator] :as ui]
            [lymchat.shared.scene.chat :as chat]
            [lymchat.shared.scene.group :as group]
            [lymchat.shared.scene.call :as call]
            [lymchat.shared.scene.me :as me]
            [lymchat.shared.scene.profile :as profile]
            [lymchat.shared.scene.contact :as contact]
            [lymchat.shared.scene.guide :as guide]
            [lymchat.shared.scene.mention :as mention]
            [lymchat.shared.scene.member :as member]
            [lymchat.shared.scene.intro :as intro]
            [lymchat.shared.scene.invite :as invite]
            [lymchat.shared.component.navigation :as nav]
            [lymchat.shared.component.language :refer [language-cp]]
            [lymchat.realm :as realm]
            [lymchat.notification :as notification]
            [lymchat.ws :as ws]
            [lymchat.util :as util]))

(aset js/console "disableYellowBox" true)

;; ios part
(def tabs (r/adapt-react-class (.-TabBarIOS ui/react-native)))
(def tabs-item (r/adapt-react-class (.-TabBarIOS.Item ui/react-native)))

(def icon-tab-ios (r/adapt-react-class (.-TabBarItemIOS ui/font-awesome)))
(def material-icon-tab-ios (r/adapt-react-class (.-TabBarItemIOS ui/material-icons)))

(defn build-tabs-item
  ([current-tab title icon-type icon-name badge]
   (build-tabs-item current-tab title icon-type icon-name badge 26))
  ([current-tab title icon-type icon-name badge icon-size]
   [(if (= icon-type :material)
      material-icon-tab-ios
      icon-tab-ios) (cond->
                      {:icon-name icon-name
                       :icon-size icon-size
                       :selected (= title current-tab)
                       :on-press (fn []
                                   (if (= "Mentions" title)
                                     (dispatch [:set-header? false])
                                     (dispatch [:set-header? true]))
                                   (dispatch [:reset-tab title]))}
                      badge (assoc :badge badge))
    (case title
      "Lymchat" [chat/chats]
      "Mentions" [mention/mentions-cp]
      "Groups" [group/groups-cp]
      "Me" [me/me-cp])]))

(defn home-cp
  [current-tab]
  (let [invites (subscribe [:invites])
        unread-mentions-count (subscribe [:unread-mentions-count])]
    (fn [current-tab]
      [tabs
       {:tint-color "#65bc54"
        :bar-tint-color "#ffffff"
        :translucent true}
       [build-tabs-item @current-tab "Lymchat" :material "chat-bubble-outline" nil 24]
       [build-tabs-item @current-tab "Mentions" :material "notifications-none" (if @unread-mentions-count @unread-mentions-count)]
       [build-tabs-item @current-tab "Groups" :material "group-work" nil]
       [build-tabs-item @current-tab "Me" :material "person-outline" (if (> (count @invites) 0) (count @invites))]])))

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
      [home-cp current-tab])))

(defn root-cp
  [nav current-user current-tab header? device-token]
  (r/create-class {:component-did-mount (fn []
                                          (util/set-statusbar-background 255 255 255 0.8)
                                          (util/show-statusbar)
                                          (when (ui/android?)
                                            (.setBackgroundColor ui/StatusBar (:teal400 colors))))
                   :reagent-render
                   (fn []
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
                                   (assoc :renderHeader #(r/as-element (nav/header current-tab %))))])}))

(let [device-token (atom nil)]
  (defn app-root []
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
          (do
            (util/remove-background-color)
            [intro/intro-cp])

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
