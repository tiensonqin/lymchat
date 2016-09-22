(ns lymchat.notification
  (:require [lymchat.shared.ui :refer [push-notification alert]]
            [lymchat.realm :as realm]
            [lymchat.util :refer [vibrate]]
            [re-frame.core :refer [dispatch]]
            [re-frame.db :refer [app-db]]
            [lymchat.util :as util]))

;; Example

;; {:foreground true,
;;  :message "Your newly configured platform settings check out! Click here to finish configuring your app.",
;;  :data {:custom {:i "19641e10-8438-4f95-b2dd-47d6c8679480"}, :remote true},
;;  :badge nil,
;;  :alert "Your newly configured platform settings check out! Click here to finish configuring your app.",
;;  :sound "default"}

;; notifications
;; [
;;  new message, open conversation
;;  {:type new-messge}

;;  {:type invite-accept}]

;;  {:type friend-invite}
;;  alert

;;  {:type new-call}

(defn handler
  [{:keys [foreground message data badge alert sound] :as message}]
  (let [data (get-in data [:custom :a])]
    (cond
      ;; new-message
      (and
       (= "new-message" (:type data))
       (true? foreground))

      (let [callee (:current-callee @app-db)
            from (get-in data [:message :user_id])]
        (cond

          (and callee (= callee from))
          nil

          :else
          (do
            (vibrate)
            (when (and callee (not= callee from))
              (dispatch [:set-new-message? true])))))

      (and
       (= "new-message" (:type data))
       (false? foreground))

      ;; open corresponding conversation
      (when (:sync? @app-db)
        (dispatch [:new-message-pushed-notification (:message data)]))

      ;; new-channel-message
      (and
       (= "new-channel-message" (:type data))
       (true? foreground))

      (let [channel-id (:current-channel @app-db)
            msg-channel-id (get-in data [:message :channel_id])]
        (cond

          (and channel-id (= channel-id msg-channel-id))
          nil

          :else
          (do
            (vibrate)
            (when (and channel-id (not= channel-id msg-channel-id))
              (dispatch [:set-new-message? true])))))

      ;; open corresponding channel
      (and
       (= "new-channel-message" (:type data))
       (false? foreground))

      (when (:sync? @app-db)
        (dispatch [:new-channel-message-pushed-notification (:message data)]))

      ;; new-mention

      ;; jump to mentions
      (and
       (= "new-mention" (:type data))
       (false? foreground))
      (dispatch [:reset-tab "mentions"])

      ;; invite-accept
      (and
       (= "invite-accept" (:type data))
       (false? foreground))

      (when (:sync? @app-db)
        (dispatch [:jump-in-conversation (:user data)]))

      ;; invite-request
      (and
       (= "invite-request" (:type data))
       (false? foreground))

      (do
        (dispatch [:new-invite (:user data)])
        (dispatch [:nav/push {:key :invitations
                              :title "Friend request"}]))

      (and
       (= "invite-request" (:type data))
       (true? foreground))
      (dispatch [:new-invite (:user data)])

      :else nil)))
