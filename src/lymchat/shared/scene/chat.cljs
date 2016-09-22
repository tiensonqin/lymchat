(ns lymchat.shared.scene.chat
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch]]
            [lymchat.styles :refer [styles pl-style]]
            [lymchat.shared.ui :refer [text view touchable-highlight list-view button icon image progress moment touchable-opacity colors icon-button dimensions alert
                                       SwipeableListView swipeable-list-view
                                       input modalbox modal gradient
                                       gifted-chat clipboard
                                       material-icon-button parsed-text open-url activity-indicator prompt] :as ui]
            [lymchat.realm :as realm]
            [lymchat.util :as util]
            [cljs-time.core :as t]
            [cljs-time.coerce :as tc]
            [lymchat.ws :as ws]
            [clojure.string :as str]
            [taoensso.sente :as sente]
            [lymchat.photo :as photo]))

(def default-avatar (js/require "./images/default.png"))

(defn seperator-cp
  []
  [view {:style {:border-width 0.5
                 :border-color "#ccc"}}])

(defn row-cp
  [row]
  (let [{:keys [id user_id is_channel to name username avatar last_message last_message_at is_read] :as c} (js->clj row :keywordize-keys true)
        channel (if is_channel (realm/get-by-id "Channel" to))]
    (when (or (not is_channel)
              (and is_channel channel))
      [touchable-highlight {:style {:flex 1
                                    :padding 10}
                            :on-press (fn []
                                        (if is_channel
                                          (do
                                            (dispatch [:jump-in-channel-conversation channel]))
                                          (do
                                            (dispatch [:load-conversation-messages to])
                                            (dispatch [:nav/push {:key :conversation
                                                                  :title name}])))
                                        (dispatch [:mark-conversation-as-read id]))
                            :underlay-color "rgba(0,0,0,0.2)"}

       [view {:style {:flex-direction "row"}}
        (if avatar
          [photo/offline-avatar-cp user_id avatar
           {:width 40
            :height 40
            :resizeMode "cover"
            :border-radius 4}]
          [image {:source default-avatar
                  :style {:width 40
                          :height 40
                          :resizeMode "cover"
                          :border-radius 4}}])
        [view {:flex 1
               :margin-left 10}
         [view {:style {:flex-direction "row"
                        :justify-content "space-between"
                        :padding-bottom 5}}
          [text {:style {:font-size 15
                         :font-weight "500"
                         :color (if (ui/ios?)
                                  "rgba(0,0,0,0.8)"
                                  "rgba(0,0,0,0.5)")}}
           (cond (and is_channel (aget channel "name"))
                 (str "#" (util/underscore-channel-name (aget channel "name")))

                 is_channel
                 (str "#")

                 :else
                 name)]
          (if last_message_at
            [text {:style {:color "rgba(0,0,0,0.6)"}}
             (.fromNow (new moment last_message_at))])]

         [text {:style {:color (if is_read
                                 "rgba(0,0,0,0.6)"
                                 "#487f1c")}}
          (if last_message
            (let [msg (util/safe-conversation-msg (util/limit-msg last_message))]
              (if is_channel
                (str username ": " msg)
                msg)))]
         ]]])))

(defn build-ds
  [conversations]
  (let [ds (.getNewDataSource SwipeableListView)

        ds (.cloneWithRowsAndSections ds
                                      (clj->js [(reverse (sort-by :last_message_at conversations))])
                                      (clj->js ["0"])
                                      (clj->js [(range (count conversations))]))]
    ds))

(defn conversation-delete-cp
  [conversation open-row-id]
  (let [conversation (js->clj conversation :keywordize-keys true)]
    [view {:style (:delete-container styles)}
     [icon-button {:name "trash"
                   :background-color "transparent"
                   :color (if (= (:id conversation) open-row-id)
                            "#65BC54"
                            (:white800 colors))
                   :on-press #(dispatch [:delete-conversation (:id conversation)])}]]))

(defn chats
  []
  (let [net-state (subscribe [:net-state])
        conversations (subscribe [:conversations])]
    (dispatch [:delete-channel-old-messages])
    [view {:style {:flex 1
                   :background-color (:white800 colors)}}
     [view {:style (pl-style :header-container)}
      (when (false? @net-state)
        [view {:style {:flex-direction "row"
                       :background-color "orange"
                       :height 40
                       :justify-content "center"
                       :align-items "center"}}

         [icon {:name "warning"
                :background-color "transparent"
                :size 18
                :color "#ffffff"}]
         [text {:style {:padding-left 10
                        :color "#ffffff"
                        :font-size 15}}
          "Network is unavailable!"]])
      (when-not (empty? @conversations)
        (let [ds (build-ds @conversations)]
          [swipeable-list-view {:automaticallyAdjustContentInsets false
                                :maxSwipeDistance 50
                                :scrollsToTop true
                                :enableEmptySections true
                                :dataSource ds
                                :style {:margin-bottom 49}
                                :renderRow (fn [row section-id row-id highlightRow]
                                             (r/as-element (row-cp row)))
                                :renderQuickActions (fn [row section-id row-id]
                                                      (r/as-element (conversation-delete-cp row (aget ds "_openRowID"))))
                                :renderSeparator (fn [section-id row-id]
                                                   (r/as-element
                                                    [view {:key (str section-id "-" row-id)
                                                           :style {:height 1
                                                                   :background-color "#ddd"}}]))}]))

      (when (ui/android?)
        (let [component (ui/floating-action-button
                         (fn []
                           (dispatch [:nav/push {:key :contacts
                                                 :title "Contacts"}])))]
          [component
           [text {:style {:font-size 24
                          :font-weight "400"
                          :color "#FFF"}}
            "+"]]))]]))

(defn send-photo-cp
  ([me-id]
   (send-photo-cp me-id nil))
  ([me-id channel-id]
   [touchable-opacity {:style {:background-color "transparent"}}
    [view {:style {:flex 1
                   :flex-direction "row"}}
     [material-icon-button {:name "camera"
                            :on-press (fn [] (photo/upload me-id :message channel-id))
                            :size 20
                            :background-color "transparent"
                            :margin-right -10
                            :padding-top 13
                            :padding-left 12
                            :padding-right 12
                            :padding-bottom 12
                            :color "rgba(0,0,0,0.85)"}]
     [view {:style {:margin-left -8}}]]]))

(defn photo-cp
  [id url photo-modal?]
  (let [{:keys [width height]} (js->clj (.get dimensions "window") :keywordize-keys true)]
    [modal {:animationType "slide"
            :transparent false
            :visible true}
     [view {:flex 1
            :background-color "rgba(0,0,0,0.1)"}
      [touchable-opacity {:activeOpacity 0.8
                          :on-press #(dispatch [:set-photo-modal? id false])}
       [image {:source {:uri url}
               :style {:width width
                       :height height
                       :resize-mode "contain"}}]]
      [touchable-opacity {:style {:flex-direction "row"
                                  :justify-content "center"
                                  :position "absolute"
                                  :top 10
                                  :right 10}}
       [button {:style {:padding 10
                        :height 35
                        :border-width 0
                        :border-radius 6}
                :text-style {:font-size 24
                             :font-weight "bold"
                             :color "rgba(0,0,0,0.85)"}
                :on-press #(dispatch [:set-photo-modal? id false])}
        "x"]]]]))

(defn triangle-cp
  [props]
  [view {:style (merge
                 (:triangle-corner styles)
                 (if (= "right" (aget props "position"))
                   (:triangle-right styles)
                   (:triangle-left styles)))}])

(defn show-photo-actions
  ([props]
   (show-photo-actions props nil))
  ([props channel-id]
   (if-let [message-text (aget props "currentMessage" "image")]
     (let [message (aget props "currentMessage")
           message-id (aget message "_id")
           buttons ["Delete"
                    "Report"
                    "Cancel"]
           options (cond
                     (ui/ios?)
                     {:options buttons
                      :destructiveButtonIndex 0
                      :cancelButtonIndex 2}

                     (ui/android?)
                     buttons

                     :else
                     nil)
           handler (fn [i]
                     (case i
                       0 (if channel-id
                           (dispatch [:delete-channel-message channel-id message-id])
                           (dispatch [:delete-message message-id]))

                       1 (prompt "I want to report this picture."
                                 nil
                                 (fn [title]
                                   (when title
                                     (dispatch [:report {:type "user"
                                                         :type_id (aget message "user" "_id")
                                                         :title title
                                                         :picture (aget message "image")
                                                         :data message}]))))

                       ;; cancel
                       nil))]
       (ui/actions options handler)))))

(defn message-photo-cp
  ([props]
   (message-photo-cp props nil))
  ([props channel-id]
   (let [id (aget props "currentMessage" "_id")
         photo-modal? (subscribe [:photo-modal? id])
         body (aget props "currentMessage" "image")]
     (if @photo-modal?
       [photo-cp id body photo-modal?]
       [touchable-opacity {:on-press (fn []
                                       (dispatch [:set-photo-modal? id true]))
                           :on-long-press (fn []
                                            (show-photo-actions props channel-id))}
        [view {:style (if channel-id
                        {:padding-top 10}
                        {:padding 10})}
         [image {:source {:uri body}
                 :style {:width 120
                         :height 100
                         :resizeMode "cover"
                         :border-radius 4}
                 :indicator (.-Pie progress)}]]]))))

(defn modal-cp
  []
  (let [current-callee (subscribe [:current-callee])]
    (fn []
      [view {:style {:flex 1}}
       [modalbox {:isOpen true
                  :swipeToClose false
                  :backdropPressToClose false
                  :style {:justifyContent "center"}}
        [gradient {:style (:gradient styles)
                   :colors #js ["#134E5E" "#71B280"]}]

        [view {:flex-direction "row"
               :padding 30
               :justify-content "space-between"}
         [button {:style {:border-width 0
                          :border-radius 10
                          :padding 20
                          :height 50
                          :background-color "#65BC54"}
                  :text-style {:color "#ffffff"
                               :font-size 20}
                  :on-press #(let [from (js->clj (realm/get-by-id "Contact" @current-callee)
                                                 :keywordize-keys true)]
                               (dispatch [:set-open-video-call-modal? false])
                               (dispatch [:accept-call from]))}
          "Accept"]

         [button {:style {:border-width 0
                          :border-radius 10
                          :padding 20
                          :height 50
                          :background-color "#EA384D"}
                  :text-style {:color "#ffffff"
                               :font-size 20}
                  :on-press #(do
                               (dispatch [:set-open-video-call-modal? false])
                               (dispatch [:reject-call @current-callee]))}
          "Reject"]]]])))

(defn show-actions
  ([props]
   (show-actions props nil))
  ([props channel-id]
   (if-let [message-text (aget props "currentMessage" "text")]
     (let [message (aget props "currentMessage")
           message-id (aget message "_id")
           buttons ["Copy"
                    "Delete"
                    "Report"
                    "Cancel"]
           options (cond
                     (ui/ios?)
                     {:options buttons
                      :destructiveButtonIndex 1
                      :cancelButtonIndex 3}

                     (ui/android?)
                     buttons

                     :else
                     nil)
           handler (fn [i]
                     (case i
                       0 (.setString clipboard message-text)
                       1 (if channel-id
                           (dispatch [:delete-channel-message channel-id message-id])
                           (dispatch [:delete-message message-id]))
                       2 (prompt "I want to report this message."
                                 nil
                                 (fn [title]
                                   (when title
                                     (dispatch [:report {:type "user"
                                                         :type_id (aget message "user" "_id")
                                                         :picture nil
                                                         :title title
                                                         :data message}]))))

                       ;; cancel
                       nil))]
       (ui/actions options handler)))))

(defn conversation-cp
  []
  (let [messages (subscribe [:current-messages])
        current-user (subscribe [:current-user])
        modal? (subscribe [:open-video-call-modal?])]
    (fn []
      (when (> (count @messages) 0))
      (if @modal?
        [modal-cp]
        [gifted-chat {:messages (clj->js (take 100 (reverse (distinct (sort-by :createdAt @messages)))))
                      :containerStyles (assoc (pl-style :header-container)
                                              :background-color "#d0d3d4")
                      :on-send (fn [message]
                                 (dispatch [:send-message (aget message 0)]))
                      :user (clj->js {:_id (:id @current-user)})
                      :onEndReached (fn []
                                      (dispatch [:load-earlier-messages (atom false)]))
                      :renderActions (fn [props]
                                       (r/as-element
                                        (send-photo-cp (:id @current-user))))
                      :renderMessageImage (fn [props]
                                            (r/as-element [message-photo-cp props]))
                      :onMessageLongPress (fn [props]
                                            (show-actions props))

                      :placeholder "Type a message..."

                      :renderCustomView (fn [props]
                                          (r/as-element [triangle-cp props]))
                      :on-error-button-press (fn [msg]
                                               (dispatch [:resend-message msg]))}]))))

(defn parse-text
  [text]
  [parsed-text {:parse [{:type "url"
                         :style {:color "#0485A9"}
                         :onPress open-url}
                        {:pattern util/mention-pattern
                         :style {:font-weight "600"
                                 :color "#0485A9"}
                         :onPress (fn [username]
                                    (let [username (str/replace username "@" "")]
                                      (when-not (str/blank? username)
                                        (ws/get-user-by-username username))))}
                        {:pattern #"`[^`]+`"
                         :style {:font-weight "400"
                                 :color "#ff5a5f"
                                 :backgroundColor "#FFF"}
                         :renderText (fn [s matches]
                                       (let [pattern #"`[^`]+`"]
                                         (-> (re-find pattern s)
                                             (str/replace "`" " "))))}]}
   text])

(defn channel-message-cp
  [current-user props channel-id]
  (let [message (-> props
                    (aget "currentMessage")
                    (js->clj :keywordize-keys true))
        user (:user message)
        id (:_id message)
        self? (= (:id current-user) (:_id user))
        body (:text message)
        image-body (:image message)
        clj-user (realm/->user user)
        resending? (r/atom false)]
    (fn []
      [view {:key id
             :style (cond->
                      {:flex 1
                       :padding-top 10
                       :padding-right 10
                       :padding-bottom 10
                       :flex-direction "row"}
                      self?
                      (assoc :padding-left 10))}
       [touchable-opacity {:on-press (fn []
                                       (dispatch [:nav/push {:key :channel-profile
                                                             :title (:name clj-user)
                                                             :user clj-user}]))}

        [image {:source {:uri (:_avatar user)}
                :style {:width 40
                        :height 40
                        :resizeMode "cover"
                        :border-radius 4}}]]
       [view {:style {:flex 1
                      :flex-direction "column"
                      :padding-left 10}}

        [view {:style {:flex-direction "row"
                       :justify-content "space-between"}}
         [view {:style {:flex-direction "row"}}
          [touchable-opacity {:on-press (fn []
                                          (dispatch [:nav/push {:key :channel-profile
                                                                :title ""
                                                                :user clj-user}]))}
           [text {:style {:font-weight "700"
                          :color "rgba(0,0,0,0.85)"}}
            (:_username user)]]

          [text {:style {:color "grey"
                         :margin-left 7}}
           (.format (new moment (:createdAt message)) "h:mm A")]]


         (when (= false (:is_delivered message))
           [touchable-opacity {:on-press (fn []
                                           (reset! resending? true)
                                           (dispatch [:resend-channel-message channel-id (aget props "currentMessage")]))}
            (if @resending?
              [activity-indicator {:animating true}]

              [text {:style {:padding-left 20
                             :font-size 22
                             :margin-top -8
                             :color "#ff5a5f"}}
               "↻"])])]

        (if image-body
          (message-photo-cp props channel-id)
          [touchable-opacity {:on-long-press (fn [] (show-actions props channel-id))}
           (cond
             (or (= body "joined, welcome!")
                 (= body "left"))
             [text {:style {:font-size 16
                            :font-style "italic"
                            :color "rgba(0,0,0,0.4)"
                            :margin-top 5}}
              (parse-text body)]

             :else
             [text {:style {:font-size 16
                            :color "rgba(0,0,0,0.8)"
                            :margin-top 5}}
              (parse-text body)])])]])))

(defn members-modal-cp
  [current-input]
  (let [members (subscribe [:search-members-result])]
    (fn []
      (let [component [modalbox {:isOpen true
                                 :style {:max-height 200}
                                 :swipeToClose false
                                 :backdropPressToClose false}
                       [view {:style {:background-color "#FFF"
                                      :width 1000}}
                        (for [{:keys [id name username avatar] :as member} @members]
                          ^{:key id}
                          [touchable-opacity {:on-press (fn []
                                                          (swap! current-input
                                                                 (fn [v]
                                                                   (str (subs v 0 (str/last-index-of v \@)) "@" username ": ")))
                                                          (dispatch [:set-search-members-result nil]))
                                              :style {:flex-direction "column"}}
                           [view {:style {:flex-direction "row"
                                          :padding-left 10
                                          :padding-right 10
                                          :padding-bottom 10
                                          :padding-top 10
                                          :border-width 0.5
                                          :border-color "#ccc"}}
                            [photo/offline-avatar-cp id avatar
                             {:width 24
                              :height 24
                              :resizeMode "cover"
                              :border-radius 4}]
                            [text {:style {:margin-left 10
                                           :align-self "center"
                                           :font-weight "500"
                                           :color "rgba(0,0,0,0.8)"}}
                             username]]])]]]
        (cond
          (ui/ios?)
          [view {:style {:position "absolute"
                         :top 64}}
           component]

          :else
          component)))))

(defonce channel-current-input (r/atom nil))

(defn channel-conversation-cp
  [channel]
  (let [channel (js->clj channel :keywordize-keys true)
        channel-id (str (:id channel))
        messages (subscribe [:channel-messages channel-id])
        current-user (subscribe [:current-user])
        search-members-result (subscribe [:search-members-result])
        in-at? (r/atom false)
        at (r/atom nil)
        last-index (r/atom nil)
        auto-focus (subscribe [:channel-auto-focus])]
    (r/create-class
     {:component-will-mount (fn []
                              (util/show-header))
      :reagent-render
      (fn []
        [view {:style {:flex 1}}
         [gifted-chat {:messages (clj->js @messages)
                       :containerStyles (assoc (pl-style :header-container)
                                               :background-color (:white800 colors))
                       :on-send (fn [message]
                                  (when-not (str/blank? @channel-current-input)
                                    (let [msg (->
                                               (aget message 0)
                                               (js->clj :keywordize-keys true)
                                               (assoc :text @channel-current-input)
                                               (clj->js))]
                                      (dispatch [:send-channel-message channel-id (:name channel) msg])))
                                  (reset! channel-current-input ""))
                       :user (clj->js {:_id (:id @current-user)})
                       :onEndReached (fn []
                                       (ws/request-channel-latest-messages channel-id {:before-id (:_id (first (sort-by :_id @messages)))}))
                       :renderActions (fn [props]
                                        (r/as-element
                                         (send-photo-cp (:id @current-user) channel-id)))

                       :renderBubble (fn [props]
                                       (r/as-element
                                        [channel-message-cp @current-user props channel-id]))

                       :on-error-button-press (fn [msg]
                                                (dispatch [:resend-channel-message channel-id msg]))
                       :placeholder "Type a message..."
                       :textInputProps {:keyboardType "twitter"
                                        :maxLength 1024
                                        :auto-correct false
                                        :auto-focus @auto-focus
                                        :value @channel-current-input
                                        :onChangeText (fn [value]
                                                        (let [new-last-index (str/last-index-of value \@)]
                                                          (cond
                                                            (= \@ (last value))
                                                            (do
                                                              (reset! in-at? true)
                                                              (reset! last-index new-last-index))

                                                            (= \space (last value))
                                                            (reset! in-at? false)

                                                            (and @in-at? (not= @last-index new-last-index))
                                                            (reset! in-at? false)

                                                            @in-at?
                                                            (do
                                                              (reset! at
                                                                      (let [v (subs value (inc new-last-index))]
                                                                        (if (str/blank? v) nil v)))
                                                              (when-not (str/blank? @at)
                                                                (dispatch [:channel-search-members channel-id @at]))))

                                                          (reset! channel-current-input value)

                                                          (r/flush)))}}]
         (when (and (not-empty @search-members-result) @in-at?)
           [members-modal-cp channel-current-input])])})))
