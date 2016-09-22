(ns lymchat.handlers
  (:require
   [reagent.core :as r]
   [re-frame.core :refer [register-handler after dispatch]]
   [schema.core :as s :include-macros true]
   [lymchat.db :refer [app-db schema]]
   [lymchat.shared.login :as login]
   [lymchat.ws :refer [pc] :as ws]
   [lymchat.realm :as realm]
   [lymchat.api :as api]
   [cljs-time.core :as t]
   [cljs-time.coerce :as tc]
   [taoensso.sente :as sente]
   [lymchat.shared.ui :as ui]
   [lymchat.util :as util]
   [lymchat.photo :as photo]
   [clojure.string :as str]
   [goog.string :as gs]))

;; -- Helpers
;; ------------------------------------------------------------

(defn dec-to-zero
  "Same as dec if not zero"
  [arg]
  (if (< 0 arg)
    (dec arg)
    arg))

;; -- Middleware ------------------------------------------------------------
;;
;; See https://github.com/Day8/re-frame/wiki/Using-Handler-Middleware
;;
(defn check-and-throw
  "throw an exception if db doesn't match the schema."
  [a-schema db]
  (when-let [problems (s/check a-schema db)]
    (throw (js/Error. (str "schema check failed: " problems)))))

(def validate-schema-mw
  (if goog.DEBUG
    (after (partial check-and-throw schema))
    []))

;; -- Handlers --------------------------------------------------------------

(register-handler
 :initialize-db
 ;; validate-schema-mw
 (fn [_ _]
   app-db))

(register-handler
 :logged
 (fn [db [_ social-type social-info]]
   (api/auth social-type social-info)
   db))

(register-handler
 :reset-tab
 (fn [db [_ value]]
   (-> db
       (assoc :current-tab value)
       (update-in [:nav :routes 0 :title] (fn [_] (if (= "lym" value)
                                                   "lym"
                                                   value))))))

(register-handler
 :android-reset-tab
 (fn [db [_ value]]
   (-> db
       (assoc :current-tab value))))

(register-handler
 :set-google-access?
 (fn [db [_ value]]
   (assoc db :google-access? value)))

(register-handler
 :set-photo-modal?
 (fn [db [_ id value]]
   (update-in db [:photo-modal? id] (fn [old-value] value))))

(register-handler
 :set-channel-auto-focus
 (fn [db [_ value]]
   (assoc db :channel-auto-focus value)))

(register-handler
 :conj-mentions
 (fn [db [_ mentions]]
   (-> db
       (update :mentions (fn [old-mentions]
                           (concat mentions old-mentions)))
       (assoc :loading? false))))

(register-handler
 :load-mentions
 (fn [db _]
   (api/get-mentions {:after-id (:id (first (:mentions db)))
                      :limit 20})
   (assoc db :loading? true)))

(register-handler
 :refresh-mentions
 (fn [db [_ refreshing?]]
   (api/refresh-mentions {:after-id (:id (first (:mentions db)))}
                         #(reset! refreshing? false)
                         nil)
   db))

(register-handler
 :reset-mention-latest-id
 (fn [db _]
   (when-let [latest-id (:id (first (:mentions db)))]
     (realm/kv-set :mention-latest-id latest-id))
   db))

(register-handler
 :set-username-input
 (fn [db [_ value]]
   (assoc db :username-input value)))

(register-handler
 :reset-contact-search-input
 (fn [db [_ value]]
   (assoc db :contact-search-input value)))

(register-handler
 :reset-channels-search-input
 (fn [db [_ value]]
   (assoc db :channels-search-input value)))

(register-handler
 :set-guide-step
 (fn [db [_ value]]
   (realm/kv-set :guide-step value)
   (assoc db :guide-step value)))

(register-handler
 :restore-search
 (fn [db _]
   (-> db
       (assoc :contact-search-input nil
              ))))

(register-handler
 :offline-sync-contacts-avatars
 (fn [db [_]]
   (photo/offline-sync-contacts-avatars)
   db))

(register-handler
 :set-scroll-to-top?
 (fn [db [_ value]]
   (assoc db :scroll-to-top? value)))

(register-handler
 :delete-contact
 (fn [db [_ user-id]]
   (api/contact-delete user-id)
   (-> db
       (update :conversations (fn [col] (filter #(not= user-id (:to %)) col))))))

(register-handler
 :delete-conversation
 (fn [db [_ conversation-id]]
   (realm/delete-conversation conversation-id)
   (-> db
       (update :conversations (fn [col] (filter #(not= conversation-id (:id %)) col))))))

(register-handler
 :send-invite
 (fn [db [_ id invite?]]
   (api/invite-send id invite?)
   db))

(register-handler
 :invite-reply
 (fn [db [_ id reply]]
   (api/invite-reply id reply)
   db))

(register-handler
 :new-invite
 (fn [db [_ user]]
   (let [user (util/wrap-created-at user)]
     (when-not (realm/invite-exists? user)
       (ui/vibrate))

     (try
       (realm/create "Invite" (clj->js user))
       (catch js/Error e
         (prn e)))

     (update db :invites
             (fn [invites]
               (if (seq (filter #(= (:id user) (:id %)) invites))
                 invites
                 (cons user (seq invites))))))))

(register-handler
 :delete-invite
 (fn [db [_ id]]
   (try (realm/delete "Invite" id)
        (catch js/Error e
          (prn e)))
   (update db :invites (fn [col] (filter #(not= id (:id %)) col)))))

(register-handler
 :skip-invite
 (fn [db [_ id]]
   (try (realm/delete "Invite" id)
        (catch js/Error e
          (prn e)))
   (when (= (count (:invites db)) 1)
     (util/restore-header)
     (dispatch [:nav/pop]))
   (update db :invites (fn [col] (filter #(not= id (:id %)) col)))))

(register-handler
 :call-initial
 (fn [db [_ callee]]
   ;; play sound
   (when-not (:in-call? db)
     (ui/ring))

   ;; send call notification
   (ws/chsk-send! [:chat/new-call {:from-name (get-in db [:current-user :name])
                                   :to-id (:id callee)}])
   (ws/initial! callee)
   db))

(register-handler
 :new-call-accept
 (fn [db [_ to-id]]
   (ui/stop-ring)
   (ws/new-pc true to-id (:local-stream db))
   db))

(register-handler
 :new-call
 (fn [db [_ from-id]]
   (if (:in-call? db)
     ;; todo create message, "Calls you", send busy status to callee,
     nil

     (when-let [from (js->clj (realm/get-by-id "Contact" from-id)
                              :keywordize-keys true)]
       (ui/ring)

       (when-not (= (:current-callee db) (:id from))
         (dispatch [:jump-in-conversation from]))

       (dispatch [:set-open-video-call-modal? true])))

   db))

(register-handler
 :set-open-video-call-modal?
 (fn [db [_ value]]
   (assoc db :open-video-call-modal? value)))

(register-handler
 :accept-call
 (fn [db [_ from]]
   (ui/stop-ring)
   (ws/initial-accept! false from)
   (js/setTimeout (fn []
                    (ws/chsk-send! [:chat/new-call-accept {:from-id (:id from)}])) 2000)

   (assoc db :in-call? true)))

(register-handler
 :reject-call
 (fn [db [_ from]]
   (ui/stop-ring)
   (ws/chsk-send! [:chat/reject-call {:to-id from}])
   (when @pc
     (try
       (do
         ;; remove local stream
         (when-let [local-stream (:local-stream db)]
           (.removeStream @pc local-stream)
           (.release local-stream))

         ;; ;; remove remote stream
         (when-let [remote-stream (:remote-stream db)]
           (.removeStream @pc remote-stream)
           (.release remote-stream))

         ;; close pc
         (.close @pc))

       (catch js/Error e
         (prn e))))
   (assoc db
          :in-call? false
          :local-stream nil
          :remote-stream nil)))

(register-handler
 :set-local-stream
 (fn [db [_ value]]
   (assoc db :local-stream value)))

(register-handler
 :set-remote-stream
 (fn [db [_ value]]
   (js/setTimeout ui/force-speaker-on 1000)
   (assoc db
          :remote-stream value
          :in-call? true)))

(register-handler
 :hangup
 (fn [db [_]]
   (when (:in-call? db)
     (ws/chsk-send! [:chat/cancel-call {:to-id (:current-callee db)}]))
   (ui/stop-ring)

   (dispatch [:nav/pop])

   (util/restore-header)
   (when @pc
     (try
       (do
         ;; remove local stream
         (when-let [local-stream (:local-stream db)]
           (.removeStream @pc local-stream)
           (.release local-stream))

         ;; remove remote stream
         (when-let [remote-stream (:remote-stream db)]
           (.removeStream @pc remote-stream)
           (.release remote-stream))

         ;; close pc
         (.close @pc))

       (catch js/Error e
         (prn e))))

   (assoc db
          :in-call? false
          :local-stream nil
          :remote-stream nil)))

(register-handler
 :cancel
 (fn [db [_]]
   (dispatch [:nav/pop])

   (util/restore-header)

   (when @pc
     (try
       (do
         ;; remove local stream
         (when-let [local-stream (:local-stream db)]
           (.removeStream @pc local-stream)
           (.release local-stream))

         ;; ;; remove remote stream
         (when-let [remote-stream (:remote-stream db)]
           (.removeStream @pc remote-stream)
           (.release remote-stream))

         ;; close pc
         (.close @pc))

       (catch js/Error e
         (prn e))))

   (assoc db
          :in-call? false
          :local-stream nil
          :remote-stream nil)))

(register-handler
 :reject
 (fn [db [_]]
   (ui/stop-ring)
   (dispatch [:nav/pop])

   (util/restore-header)

   (when @pc
     (try
       (do
         ;; remove local stream
         (when-let [local-stream (:local-stream db)]
           (.removeStream @pc local-stream)
           (.release local-stream))

         ;; ;; remove remote stream
         (when-let [remote-stream (:remote-stream db)]
           (.removeStream @pc remote-stream)
           (.release remote-stream))

         ;; close pc
         (.close @pc))

       (catch js/Error e
         (prn e))))

   (assoc db
          :in-call? false
          :local-stream nil
          :remote-stream nil)))

(register-handler
 :set-current-user
 (fn [db [_ value]]
   (assoc db :current-user value)))

(register-handler
 :set-net-state
 (fn [db [_ value]]
   (assoc db :net-state value)))

(register-handler
 :set-header?
 (fn [db [_ value]]
   (assoc db :header? value)))

(register-handler
 :set-uploading?
 (fn [db [_ value]]
   (assoc db :uploading? value)))

(register-handler
 :set-no-disturb?
 (fn [db [_ value]]
   (realm/kv-set "no-disturb?" value)
   (assoc db :no-disturb? value)))

(register-handler
 :set-no-dm
 (fn [db [_ value]]
   (api/patch-me {:no_invite value})
   (assoc-in db [:current-user :no_invite] value)))

(register-handler
 :set-username
 (fn [db [_ value]]
   (let [value (str/replace value "@" "")]
     (api/patch-me {:username value}
                   (fn [res]
                     (dispatch [:set-username-success value]))
                   (fn [error]
                     (ui/alert (gs/format "Sorry, %s already exists." value)))))
   db))

(register-handler
 :set-username-set?
 (fn [db [_ value]]
   (realm/kv-set :username-set? value)
   (assoc db :username-set? value)))

(register-handler
 :set-username-success
 (fn [db [_ value]]
   (realm/kv-set :username-set? true)
   (-> db
       (assoc-in [:current-user :username] value)
       (assoc :username-set? true))))

(register-handler
 :add-channel
 (fn [db [_ channel]]
   (try
     (realm/list-push "User" (get-in db [:current-user :id]) "channels" (clj->js (util/uuid->str channel)))
     (catch js/Error e
       nil))
   (update-in db [:current-user :channels] conj channel)))

(register-handler
 :join-channel
 (fn [db [_ row]]
   (api/channel-join (str (aget row "id"))
                     #(do
                        (dispatch [:add-channel (js->clj row :keywordize-keys true)])
                        (dispatch [:jump-in-channel-conversation row]))
                     nil)
   db))

(register-handler
 :delete-channel-conversation
 (fn [db [_ channel-id]]
   (-> db
       (update :conversations
               (fn [col] (filter #(not (and (:is_channel %) (= (str channel-id) (str (:to %))))) col)))
       (update-in [:current-user :channels]
                  (fn [col] (filter #(not= (str channel-id) (str (:id %))) col))))))

(register-handler
 :leave-channel
 (fn [db [_ id]]
   (api/channel-leave (str id) nil nil)
   db))

(register-handler
 :leave-channel-then-back
 (fn [db [_ id]]
   (api/channel-leave (str id) (fn [] (dispatch [:nav/pop])) nil)
   db))

(register-handler
 :set-native-lang
 (fn [db [_ value]]
   (api/patch-me {:language value})
   (dispatch [:nav/pop])
   (assoc-in db [:current-user :language] value)))

(register-handler
 :set-temp-avatar
 (fn [db [_ value]]
   (assoc-in db [:current-user :avatar] value)))

(register-handler
 :set-avatar
 (fn [db [_ value]]
   (api/patch-me {:avatar value})
   db))

(register-handler
 :set-name
 (fn [db [_ first-name last-name]]
   (let [name (str (str/capitalize (str/trim first-name)) " " (str/capitalize (str/trim last-name)))]
     (api/patch-me {:name name})
     (dispatch [:nav/pop])
     (-> db
         (assoc-in [:current-user :name] name)))))

(register-handler
 :delete-current-callee
 (fn [db _]
   (assoc db
          :current-callee nil
          :current-channel nil)))

(register-handler
 :set-new-message?
 (fn [db [_ value]]
   (assoc db :new-message? value)))

(register-handler
 :load-channels-search-result
 (fn [db [_ q]]
   (if (str/blank? q)
     (assoc db :channels-search-result nil)
     (do
       (api/channels-search q)
       db))))

(register-handler
 :set-channels-search-result
 (fn [db [_ value]]
   (assoc db :channels-search-result value)))

(register-handler
 :set-recommend-channels
 (fn [db [_ value]]
   (assoc db :recommend-channels value)))

(register-handler
 :channel-search-members
 (fn [db [_ channel-id q]]
   (ws/search-members channel-id q)
   db))

(register-handler
 :set-search-members-result
 (fn [db [_ value]]
   (assoc db :search-members-result value)))

(register-handler
 :set-channel-members
 (fn [db [_ channel-id value]]
   (assoc-in db [:channel-members channel-id] value)))

(register-handler
 :set-channels-messages
 (fn [db [_ messages]]
   (if (empty? messages)
     db
     (-> db
         (assoc :channel-messages messages)
         (update :conversations (fn [col]
                                  (for [con col]
                                    (if (:is_channel con)
                                      (let [message (first (get messages (:to con)))]
                                        (if (or (and (:id message) (nil? (:message_id con)))
                                                (> (:id message) (:message_id con)))
                                          (let [m {:message_id (:id message)
                                                   :last_message (:body message)
                                                   :last_message_at (:created_at message)
                                                   :name (:name message)
                                                   :user_id (:user_id message)
                                                   :username (:username message)
                                                   :avatar (:avatar message)
                                                   :is_read false}]
                                            (let [new-con (merge con m)]
                                              (realm/update "Conversation" new-con)
                                              new-con))
                                          con))
                                      con))))))))

(register-handler
 :set-channel-messages
 (fn [db [_ channel-id messages]]
   (if (empty? messages)
     db
     (let [messages (map #(update % :created_at tc/to-date) messages)]
       (assoc-in db [:channel-messages channel-id] messages)))))

(register-handler
 :conj-channel-messages
 (fn [db [_ channel-id messages]]
   (if (empty? messages)
     db
     (update-in db [:channel-messages channel-id] concat messages))))

(register-handler
 :load-conversation-messages
 (fn [db [_ current-callee]]
   (assoc db
          :current-callee current-callee
          :current-messages (realm/get-conversation-messages (get-in db [:current-user :id]) current-callee 20))))

(register-handler
 :load-channel-messages
 (fn [db [_ channel-id]]
   ;; todo request messages
   (assoc db
          :current-channel channel-id)))

(register-handler
 :load-earlier-messages
 (fn [db [_ refreshing?]]
   (let [db (update db :current-messages
                    (fn [messages]
                      (concat
                       (realm/load-earlier-messages
                        (get-in db [:current-user :id])
                        (:current-callee db)
                        (:_id (first (:current-messages db)))
                        5)
                       messages)))]
     ;; (swap! refreshing? not)
     db)))

(register-handler
 :new-conversation
 (fn [db [_ conversation]]
   (update db :conversations conj conversation)))

(register-handler
 :new-message-pushed-notification
 (fn [db [_ message]]
   (let [message (realm/wrap-conversation-id message)
         user-id (:user_id message)
         name (aget (realm/get-by-id "Contact" user-id) "name")]
     (dispatch [:load-conversation-messages user-id])
     (dispatch [:nav/push {:key :conversation
                           :title name}])
     (dispatch [:mark-conversation-as-read (:conversation_id message)]))
   db))

(register-handler
 :new-channel-message-pushed-notification
 (fn [db [_ message]]
   (let [channel (realm/get-by-id "Channel" (:channel_id message))]
     (dispatch [:jump-in-channel-conversation channel]))
   db))

(register-handler
 :resend-message
 (fn [db [_ message]]
   (let [current-user   (:current-user db)
         current-callee (:current-callee db)
         msg-temp-id (aget message "_id")
         bare-msg {:to_id current-callee
                   :body (aget message "text")
                   :created_at (aget message "createdAt")}
         message (-> bare-msg
                     (assoc :id msg-temp-id
                            :user_id (:id current-user)
                            :is_delivered true)
                     (realm/wrap-conversation-id :to_id))]
     (ws/send-message (assoc bare-msg
                             :from-name (:name current-user))
                      5000
                      (fn [reply]
                        (if (sente/cb-success? reply)
                          (let [new-id (:new-message-id reply)]
                            (realm/delete "Message" msg-temp-id)
                            (realm/create "Message" (assoc message :id new-id))
                            (dispatch [:mark-message-as-success msg-temp-id]))

                          nil))))
   db))

(register-handler
 :resend-channel-message
 (fn [db [_ channel-id message]]
   (let [current-user   (:current-user db)
         msg-temp-id (aget message "_id")
         bare-msg {:channel_id channel-id
                   :body (aget message "text")
                   :name (:name current-user)
                   :avatar (:avatar current-user)
                   :created_at (aget message "createdAt")}
         msg (-> bare-msg
                 (assoc :id msg-temp-id
                        :user_id (:id current-user)
                        :is_delivered true))]
     (ws/send-message bare-msg
                      5000
                      (fn [reply]
                        (if (sente/cb-success? reply)
                          (let [new-id (:new-message-id reply)]
                            (realm/delete "GroupMessage" msg-temp-id)
                            (realm/create "GroupMessage" (assoc msg :id new-id))
                            (dispatch [:update-new-msg-id channel-id msg-temp-id new-id])
                            (dispatch [:mark-channel-message-as-success channel-id msg-temp-id]))
                          nil))))
   db))

(register-handler
 :send-message
 (fn [db [_ message]]
   (let [current-user   (:current-user db)
         current-callee (:current-callee db)

         msg-temp-id (long (str (tc/to-long (t/now)) (rand-int 100)))
         bare-msg {:to_id current-callee
                   :body (aget message "text")
                   :created_at (aget message "createdAt")}
         msg (-> bare-msg
                 (assoc :id msg-temp-id
                        :user_id (:id current-user)
                        :is_delivered true)
                 (realm/wrap-conversation-id :to_id))]

     (dispatch [:conj-message msg :to_id])

     (ws/send-message (assoc bare-msg
                             :from-name (:name current-user))
                      5000
                      (fn [reply]
                        (if (sente/cb-success? reply)
                          (let [new-id (:new-message-id reply)]
                            (realm/delete "Message" msg-temp-id)
                            (realm/create "Message" (assoc msg :id new-id)))

                          (dispatch [:mark-message-as-failed msg-temp-id])))))

   db))

(register-handler
 :update-new-msg-id
 (fn [db [_ channel-id msg-temp-id new-id]]
   (update-in db [:channel-messages channel-id]
              (fn [messages]
                (map (fn [msg] (if (= msg-temp-id (:id msg))
                                (assoc msg :id new-id)
                                msg)) messages)))))

(register-handler
 :delete-channel-old-messages
 (fn [db _]
   (let [col (:channel-messages db)
         limit 1]
     (doseq [[channel-id messages] col]
       (when (> (count messages) limit)
         (let [message-id (:id (first (take-last limit (sort-by :created_at messages))))]
           (realm/delete-channel-old-messages channel-id message-id)))))
   db))

(register-handler
 :send-channel-message
 (fn [db [_ channel-id channel-name message]]
   (let [current-user (:current-user db)
         msg-temp-id (long (str (tc/to-long (t/now)) (rand-int 100)))
         bare-msg {:channel_id channel-id
                   :channel_name channel-name
                   :body (aget message "text")
                   :name (:name current-user)
                   :username (:username current-user)
                   :timezone (:timezone current-user)
                   :language (:language current-user)
                   :avatar (:avatar current-user)
                   :created_at (aget message "createdAt")}
         msg (-> bare-msg
                 (assoc :id msg-temp-id
                        :user_id (:id current-user)
                        :is_delivered true))]
     (dispatch [:conj-channel-message channel-id msg])

     (ws/send-channel-message bare-msg
                              5000
                              (fn [reply]
                                (if (sente/cb-success? reply)
                                  (let [new-id (:new-message-id reply)]
                                    (realm/delete "GroupMessage" msg-temp-id)
                                    (realm/create "GroupMessage" (-> msg
                                                                     (dissoc :channel_name)
                                                                     (assoc :id new-id)))
                                    (dispatch [:update-new-msg-id channel-id msg-temp-id new-id]))

                                  (dispatch [:mark-channel-message-as-failed channel-id msg-temp-id])))))

   db))

(register-handler
 :send-photo-message
 (fn [db [_ temp-url]]
   (let [current-user   (:current-user db)
         current-callee (:current-callee db)

         msg-temp-id (long (str (tc/to-long (t/now)) (rand-int 100)))
         bare-msg {:to_id current-callee
                   :body (util/body->photo temp-url)
                   :created_at (tc/to-date (t/now))}
         msg (-> bare-msg
                 (assoc :id msg-temp-id
                        :user_id (:id current-user)
                        :is_delivered true)
                 (realm/wrap-conversation-id :to_id))]

     (dispatch [:conj-message msg :to_id])

     (photo/s3-upload temp-url
                      (photo/new-photo-name (:id current-user))
                      (fn [url]
                        (let [body (util/body->photo url)]
                          (ws/send-message (assoc bare-msg
                                                  :body body
                                                  :from-name (:name current-user))
                                           5000
                                           (fn [reply]
                                             (if (sente/cb-success? reply)
                                               (let [new-id (:new-message-id reply)]
                                                 (realm/delete "Message" msg-temp-id)
                                                 (realm/create "Message" (assoc msg
                                                                                :id new-id
                                                                                :body body)))

                                               (dispatch [:mark-message-as-failed msg-temp-id]))))))))

   db))

(register-handler
 :send-channel-photo-message
 (fn [db [_ channel-id temp-url]]
   (let [current-user (:current-user db)
         msg-temp-id (long (str (tc/to-long (t/now)) (rand-int 100)))
         bare-msg {:channel_id channel-id
                   :body (util/body->photo temp-url)
                   :name (:name current-user)
                   :username (:username current-user)
                   :avatar (:avatar current-user)
                   :created_at (tc/to-date (t/now))}

         msg (-> bare-msg
                 (assoc :id msg-temp-id
                        :user_id (:id current-user)
                        :is_delivered true)
                 (realm/wrap-conversation-id :to_id))]

     (dispatch [:conj-channel-message channel-id msg])

     (photo/s3-upload temp-url
                      (photo/new-photo-name (:id current-user))
                      (fn [url]
                        (let [body (util/body->photo url)]
                          (ws/send-channel-message (assoc bare-msg
                                                          :body body)
                                                   5000
                                                   (fn [reply]
                                                     (if (sente/cb-success? reply)
                                                       (let [new-id (:new-message-id reply)]
                                                         (realm/delete "GroupMessage" msg-temp-id)
                                                         (realm/create "GroupMessage" (assoc msg :id new-id))
                                                         (dispatch [:update-new-msg-id channel-id msg-temp-id new-id])
                                                         (dispatch [:mark-channel-message-as-success channel-id msg-temp-id]))
                                                       (dispatch [:mark-channel-message-as-failed channel-id msg-temp-id]))))))))

   db))

(register-handler
 :reload-conversations
 (fn [db [_]]
   (assoc db :conversations (realm/get-conversations))))

(register-handler
 :sync-is-over
 (fn [db [_]]
   (assoc db :sync? true)))

(register-handler
 :set-signing?
 (fn [db [_ value]]
   (assoc db :signing? value)))

(register-handler
 :report
 (fn [db [_ report]]
   (api/report-create report)
   db))

(register-handler
 :jump-in-conversation
 (fn [db [_ user]]
   (when-let [cid (realm/get-conversation-id-by-to
                   (:id user))]
     (dispatch [:mark-conversation-as-read cid]))

   (dispatch [:load-conversation-messages (:id user)])
   (dispatch [:nav/push {:key :conversation
                         :title (:name user)}])
   db))

(register-handler
 :pop-jump-in-conversation
 (fn [db [_ user]]
   (when-let [cid (realm/get-conversation-id-by-to
                   (:id user))]
     (dispatch [:mark-conversation-as-read cid]))

   (dispatch [:load-conversation-messages (:id user)])
   (dispatch [:nav/home])
   (util/show-header)
   (dispatch [:nav/push {:key :conversation
                         :title (:name user)}])
   db))

(register-handler
 :load-channel-latest-messages
 (fn [db [_ channel-id]]
   (ws/request-channel-latest-messages channel-id {:limit 10})
   db))

(register-handler
 :jump-in-channel-conversation
 (fn [db [_ channel]]
   (let [channel-id (str (aget channel "id"))]
     ;; if channel conversation not exists, create the conversation
     (realm/create-channel-conversation channel-id nil)
     (dispatch [:nav/push {:key :channel-conversation
                           :title (str "#" (util/underscore-channel-name (aget channel "name")))
                           :channel channel}])
     (-> db
         (assoc :current-channel channel-id)
         (update-in [:channel-messages channel-id]
                    (fn [messages]
                      (->> (sort-by :created_at messages)
                           (take-last 8))))
         ))))

(register-handler
 :jump-in-lym
 (fn [db _]
   (dispatch [:jump-in-channel-conversation (clj->js realm/lym-channel)])
   db))

(register-handler
 :mark-conversation-as-read
 (fn [db [_ id]]
   (realm/update "Conversation" {:id id
                                 :is_read true})
   (update db :conversations (fn [col]
                               (doall (map (fn [c]
                                             (if (= id (:id c))
                                               (assoc c :is_read true)
                                               c)) col))))))

(register-handler
 :mark-message-as-failed
 (fn [db [_ msg-temp-id]]
   (realm/update "Message" {:id msg-temp-id
                            :is_delivered false})
   (update db :current-messages (fn [col] (doall (map (fn [msg]
                                                       (if (= msg-temp-id (:_id msg))
                                                         (assoc msg :is_delivered false)
                                                         msg)) col))))))

(register-handler
 :mark-message-as-success
 (fn [db [_ msg-temp-id]]
   (update db :current-messages (fn [col] (doall (map (fn [msg]
                                                       (if (= msg-temp-id (:_id msg))
                                                         (assoc msg :is_delivered true)
                                                         msg)) col))))))

(register-handler
 :mark-channel-message-as-failed
 (fn [db [_ channel-id msg-temp-id]]
   (update-in db [:channel-messages channel-id]
              (fn [col] (doall (map (fn [msg]
                                     (if (= msg-temp-id (:id msg))
                                       (assoc msg :is_delivered false)
                                       msg)) col))))))

(register-handler
 :mark-channel-message-as-success
 (fn [db [_ channel-id msg-temp-id]]
   (update-in db [:channel-messages channel-id]
              (fn [col] (doall (map (fn [msg]
                                     (if (= msg-temp-id (:id msg))
                                       (assoc msg :is_delivered true)
                                       msg)) col))))))


(register-handler
 :delete-message
 (fn [db [_ id]]
   ;; delete from disk
   (realm/delete "Message" id)
   (update db :current-messages (fn [col] (filter #(not= id (:_id %)) col)))))

(register-handler
 :delete-channel-message
 (fn [db [_ channel-id message-id]]
   (realm/delete "GroupMessage" message-id)
   (update-in db
              [:channel-messages channel-id]
              (fn [col] (filter #(not= message-id (:id %)) col)))))

(register-handler
 :conj-message
 (fn [db [_ message k]]
   (if (= :invite-accept (get-in message [:data :type]))
     ;; create contact
     (try (realm/create "Contact" (get-in message [:data :user]))
          (catch js/Error e
            nil)))

   (let [message (assoc message :is_delivered true)
         message (if (:conversation_id message)
                   message
                   (realm/wrap-conversation-id message k))
         me-id (get-in db [:current-user :id])
         conversation-is-read (if (or
                                   (= (:current-callee db)
                                      (:user_id message))
                                   (= k :to_id))
                                true
                                false)
         last-message (:body message)]
     (realm/create "Message" message)

     (realm/update "Conversation" {:id (:conversation_id message)
                                   :last_message last-message
                                   :last_message_at (:created_at message)
                                   :is_read conversation-is-read})

     (-> (if (or (= (:current-callee db) (:user_id message))
                 (= (:current-callee db) (:to_id message)))
           (update db :current-messages (fn [messages]
                                          (if (seq (filter #(= (:id message) (:_id %)) messages))
                                            messages
                                            (conj messages (realm/msg-convert me-id message)))))
           db)
         (update :conversations (fn [col]
                                  (doall
                                   (map (fn [c]
                                          (if (= (:conversation_id message) (:id c))
                                            (assoc c
                                                   :last_message last-message
                                                   :last_message_at (:created_at message)
                                                   :is_read conversation-is-read)
                                            c))
                                     col))))))))

(register-handler
 :conj-mention
 (fn [db [_ message]]
   (let [channel-id (:current-channel db)
         msg-channel-id (:channel_id message)]
     (when (not= channel-id msg-channel-id)
       (ui/vibrate)))
   (update db :mentions conj message)))

(register-handler
 :conj-channel-message
 (fn [db [_ channel-id message]]
   (let [is-read (if (or
                      (= (get-in db [:current-user :id]) (:user_id message))
                      (= (:current-channel db)
                         (:channel_id message)))
                   true
                   false)
         m {:last_message (:body message)
            :last_message_at (:created_at message)
            :message_id (:id message)
            :name (:name message)
            :user_id (:user_id message)
            :username (:username message)
            :avatar (:avatar message)
            :is_read is-read}]
     (-> db
         (update-in [:channel-messages channel-id] conj message)
         (update :conversations (fn [col]
                                  (doall
                                   (map (fn [c]
                                          (if (and (:is_channel c) (= (:channel_id message) (:to c)))
                                            (do
                                              (realm/create "GroupMessage" message)
                                              (realm/update "Conversation" (assoc m :id (:id c)))
                                              (merge c m))
                                            c))
                                     col))))))))

(register-handler
 :nav/push
 validate-schema-mw
 (fn [db [_ value]]
   (if (contains? (->> (get-in db [:nav :routes])
                       (map :key)
                       (set)) (:key value))
     db
     (-> db
         (update-in [:nav :index] inc)
         (update-in [:nav :routes] #(vec (distinct (conj % value))))))))

(register-handler
 :nav/pop
 validate-schema-mw
 (fn [db [_ _]]
   (-> db
       (update-in [:nav :index] dec-to-zero)
       (update-in [:nav :routes]
                  (fn [routes]
                    (if (> (count routes) 1)
                      (pop routes)
                      routes))))))

(register-handler
 :nav/home
 validate-schema-mw
 (fn [db [_ _]]
   (-> db
       (assoc-in [:nav :index] 0)
       (assoc-in [:nav :routes] (vector (get-in db [:nav :routes 0]))))))

;; drawer
(register-handler
 :drawer/set
 (fn [db [_ ref]]
   (assoc-in db [:drawer :ref] ref)))

(register-handler
 :drawer/open
 (fn [db _]
   (.openDrawer (get-in db [:drawer :ref]))
   (assoc-in db [:drawer :open?] true)))

(register-handler
 :drawer/close
 (fn [db _]
   (.closeDrawer (get-in db [:drawer :ref]))
   (assoc-in db [:drawer :open?] false)))
