(ns api.handler.ws
  (:require [taoensso.sente :as sente]
            [taoensso.sente.server-adapters.aleph :refer (get-sch-adapter)]
            [aleph.http :as http]
            [api.db.message :as message]
            [environ-plus.core :refer [env]]
            [api.util :refer [flake-id]]
            [api.db.notification :as notification]
            [clj-time.core :as t]
            [clj-time.coerce :as tc]
            [taoensso.timbre :as timbre]
            [api.services.twilio :as twilio]
            [api.db.user :as user]
            [api.db.util :as dbutil]
            [api.db.stats :as stats]
            [api.db.mention :as mention]
            [api.db.ws :as ws]
            [clojure.java.jdbc :as j]
            [api.db.channel :as channel]))

(let [packer :edn
      chsk-server (sente/make-channel-socket-server!
                   (get-sch-adapter)
                   {:packer packer
                    :user-id-fn (fn [req]
                                  (get-in req [:custom :user-id]))
                    ;; hack to disable CSRF security warning
                    :csrf-token-fn (fn [req]
                                     "mock csrf")})

      {:keys [ch-recv send-fn connected-uids
              ajax-post-fn ajax-get-or-ws-handshake-fn]} chsk-server]

  ;; (def ring-ajax-post                ajax-post-fn)
  (def ring-ajax-get-or-ws-handshake ajax-get-or-ws-handshake-fn)
  (def ch-chsk                       ch-recv) ; ChannelSocket's receive channel
  (def chsk-send!                    send-fn) ; ChannelSocket's send API fn
  (def connected-uids                connected-uids) ; Watchable, read-only atom
  )

;; msg handler

(defn send-message
  [{:keys [user_id to_id body] :as message}]
  (chsk-send! to_id [:chat/new-message
                     (assoc message
                            :id (flake-id)
                            :created_at (tc/to-date (t/now)))]))

(defn send-channel-message
  [{:keys [channel_id body] :as message}]
  (doseq [to-id (channel/get-online-channel-users (:any @connected-uids) channel_id)]
    (let [msg (if (:id message) message (assoc message :id (flake-id)))
          msg (dbutil/with-now msg [:created_at])]
      (chsk-send! to-id
                 [:chat/new-channel-message msg]))))

(defn debug-channel-send
  [body]
  (let [msg {:channel_id "10000000-3c59-4887-995b-cf275db86343"
             :body body
             :name "Tim Duncan"
             :username "tim"
             :avatar "http://static3.businessinsider.com/image/54d11789ecad04b16d8f9527-480/tim-duncan.jpg"
             :user_id "20000000-81c1-4f1a-aa22-eeb57d2eea98"
             :language "English"
             :timezone -7}]
    (send-channel-message msg)))

(defn debug-send
  [body]
  (let [msg {:body body
             :to_id "6c0c4d91-7ed2-4fd3-af63-7ef2d394fd81"
             :avatar "http://static3.businessinsider.com/image/54d11789ecad04b16d8f9527-480/tim-duncan.jpg"
             :user_id "20000000-81c1-4f1a-aa22-eeb57d2eea98"}]
    (send-message msg)))

(defn send-invitation
  [to issue]
  (chsk-send! to [:chat/new-invitation issue]))

(defmulti msg-handler :id)

(defmethod msg-handler :rtc/exchange [{:keys [uid ?data] :as event}]
  (prn "Received event: " event)
  (chsk-send! (:to ?data) [:rtc/exchange
                           (-> ?data
                               (dissoc :to)
                               (assoc :from uid))]))

(defmethod msg-handler :rtc/ice-servers [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received ice-servers request event: " event)
  (when ?reply-fn
    (?reply-fn {:iceServers (twilio/get-ice-servers)})))

(let [pkey "ohpiceeb57d2eea98"]

  (defn photo-message?
    [body]
    (clojure.string/starts-with? body pkey)))

(defmethod msg-handler :chat/new-channel-message [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received new message: " event)
  (let [id (flake-id)
        msg (-> ?data
                (assoc :user_id uid
                       :id id))
        redis (:redis env)
        channel-id (:channel_id ?data)
        channel-name (:channel_name ?data)]
    (message/channels-create redis msg)

    (doseq [to-id (remove #{uid} (channel/get-online-channel-users (:any @connected-uids) channel-id))]
      (when to-id
        (prn "Channel publish to: " to-id)
        (chsk-send! to-id
                    [:chat/new-channel-message msg])))

    ;; mentions
    (let [body (:body msg)]
      (when-let [usernames (seq (mention/extract body))]
        (let [users (channel/get-users-by-usernames channel-id usernames)]
          (doseq [user users]
            ;; send notifications
            (notification/send-notification (:redis env)
                                            (:id user)
                                            (str "#" channel-name " - " (:username msg) " mentions you: " body)
                                            {:type "new-mention"
                                             :message msg})

            ;; ws notification
            (chsk-send! (str (:id user))
                        [:chat/new-mention msg])

            ;; save to mentions
            (mention/create (:redis env) (:id user) msg)))))

    (when ?reply-fn
      (?reply-fn {:new-message-id id}))

    (when (photo-message? (:body msg))
      (stats/inc-point redis :photo))))

(defmethod msg-handler :chat/new-message [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received new message: " event)
  (let [id (flake-id)
        from-name (:from-name ?data)
        msg (-> ?data
                (dissoc :from-name)
                (assoc :user_id uid :id id))
        redis (:redis env)
        to-id (:to_id ?data)]
    (message/create redis msg)
    (chsk-send! to-id
                [:chat/new-message msg])
    (when ?reply-fn
      (?reply-fn {:new-message-id id}))

    (let [body (:body msg)
          photo? (photo-message? body)]
      (notification/send-notification redis to-id
                                      (let [body (if photo? "new photo." body)]
                                        (if from-name
                                          (str from-name ": " body)
                                          body))
                                      {:type "new-message"
                                       :message msg})

      (when photo?
        (stats/inc-point redis :photo)))))

(defmethod msg-handler :chat/new-call [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received new call: " event)
  (chsk-send! (:to-id ?data)
              [:chat/new-call {:from-id uid}])

  (notification/send-notification (:redis env) (:to-id ?data)
                                  (str (:from-name ?data)
                                       " invites you to video chat")
                                  {:type "new-call"
                                   :from-id uid}))

(defmethod msg-handler :chat/new-call-accept [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received new call accept: " event)
  (stats/inc-point (:redis env) :video)

  (chsk-send! (:from-id ?data)
              [:chat/new-call-accept {:to-id uid}]))

(defmethod msg-handler :chat/reject-call [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received rejected call: " event)
  (let [redis (:redis env)
        to-id (:to-id ?data)
        msg {:id (flake-id)
             :user_id uid
             :to_id to-id
             :body "Call rejected."
             :created_at (tc/to-date (t/now))}]

    (chsk-send! to-id
                [:chat/reject-call {:from-id uid}])

    (message/create redis msg)

    (chsk-send! to-id
                [:chat/new-message msg])))

(defmethod msg-handler :chat/cancel-call [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received canceled call: " event)
  (let [redis (:redis env)
        to-id (:to-id ?data)
        msg {:id (flake-id)
             :user_id uid
             :to_id to-id
             :body "Call canceled."
             :created_at (tc/to-date (t/now))}]

    (chsk-send! to-id
                [:chat/cancel-call {:from-id uid}])

    (message/create redis msg)

    (chsk-send! to-id
                [:chat/new-message msg])))

(defmethod msg-handler :chat/get-unread-messages [{:keys [uid ?data] :as event}]
  (prn "Received new unread messages request: " event)
  (let [latest-message-id (:latest-message-id ?data)
        latest-message-id (if latest-message-id latest-message-id 0)]
    (chsk-send! uid
                [:chat/reply-unread-messages
                 (message/get-latest-messages (:redis env) uid latest-message-id)])
    (message/delete-delivered-messages (:redis env) uid latest-message-id)))

;; todo security
(defmethod msg-handler :chat/get-xxxxx [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received xxxxx request: " event)
  ;; update last_seen_at
  (j/with-db-connection [db dbutil/default-db]
    (user/update db (java.util.UUID/fromString uid) {:last_seen_at (dbutil/sql-now)}))

  (when ?reply-fn
    (?reply-fn {:xxxxx (:xxxxx env)})))

(defmethod msg-handler :chat/get-recommend-channels [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received recommend channels request: " event)
  (when ?reply-fn
    (?reply-fn {:channels (j/with-db-transaction [db dbutil/default-db]
                            (when-let [user (user/get db (java.util.UUID/fromString uid))]
                              (channel/get-recommend-others db (:language user))))})))

(defmethod msg-handler :chat/get-channel-latest-messages [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received get channel lastest messages request: " event)
  (when ?reply-fn
    (let [{:keys [channel-id opts]} ?data]
      (?reply-fn {:messages
                  (message/get-channel-latest-messages (:redis env) channel-id opts)}))))

(defmethod msg-handler :chat/search-members [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received channel search members request: " event)
  (when ?reply-fn
    (?reply-fn {:members (channel/search-members uid
                                                 (:channel-id ?data)
                                                 (:q ?data)
                                                 (:limit ?data))})))

(defmethod msg-handler :chat/get-members [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received channel get members request: " event)
  (when ?reply-fn
    (?reply-fn {:members (channel/get-members (:channel-id ?data))})))

(defmethod msg-handler :chat/get-user-by-username [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received channel get user by username request: " event)
  (when ?reply-fn
    (?reply-fn {:user (j/with-db-connection [db dbutil/default-db]
                        (user/get-by-username db (:username ?data)))})))

(defmethod msg-handler :chat/sync [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received sync request: " event)
  (let [{:keys [contacts-ids]} ?data]
    (when ?reply-fn
      (?reply-fn (ws/sync-all
                  dbutil/default-db
                  uid
                  contacts-ids)))))

(defmethod msg-handler :chat/request-updated-contacts [{:keys [uid ?data ?reply-fn] :as event}]
  (prn "Received new updated contacts request: " event)
  (when ?reply-fn
    (?reply-fn {:contacts (user/get-contacts dbutil/default-db (java.util.UUID/fromString uid))})))

(defmethod msg-handler :chat/latest-message-delivered [{:keys [uid ?data] :as event}]
  (prn "Received new latest message delivered request: " event)
  (let [latest-message-id (:latest-message-id ?data)]
    (message/delete-delivered-messages (:redis env) uid latest-message-id)))

(defmethod msg-handler :notification/register-device-token [{:keys [uid ?data] :as event}]
  (prn "Received device token register request: " event)
  (notification/add-device (:redis env) uid (:device-token ?data)))

;; (defmethod msg-handler :notification/reset-badge [{:keys [uid] :as event}]
;;   (prn "Received reset badge request: " event)
;;   (notification/reset-badge (:redis env) uid))

(defmethod msg-handler :chsk/ws-ping [event]
  nil)

;; add user to groups
(defmethod msg-handler :chsk/uidport-open [event]
  nil)

(defmethod msg-handler :chsk/uidport-close [event]
  nil)

(defmethod msg-handler :default [event]
  (prn "Unhandled event: %s" event))

(defn wrap-msg-handler
  [event]
  (try
    (msg-handler event)
    (catch Exception e
      (timbre/error e))))

(defonce router_ (atom nil))
(defn stop-router! [] (when-let [stop-fn @router_] (stop-fn)))
(defn start-router! []
  (stop-router!)
  (reset! router_
          (sente/start-server-chsk-router!
           ch-chsk
           wrap-msg-handler)))
