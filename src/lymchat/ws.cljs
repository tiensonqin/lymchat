(ns lymchat.ws
  (:require-macros [cljs.core.async.macros :refer [go go-loop]])
  (:require [re-frame.core :refer [dispatch dispatch-sync]]
            [re-frame.db :refer [app-db]]
            [clojure.string :as str]
            [taoensso.sente :as sente]
            [taoensso.encore :as encore]
            [taoensso.timbre :as t]
            [lymchat.shared.ui :refer [webrtc] :as ui]
            [cljs-time.core :as tc]
            [cljs-time.coerce :as tcc]
            [lymchat.realm :as realm]
            [lymchat.api :refer [get-token] :as api]
            [lymchat.config :as config]
            [lymchat.util :as util]
            [cljs.core.async :refer [chan put! <!]]))

(defn start-client! []
  (let [client (sente/make-channel-socket!
                "/ws"
                {:host (clojure.string/replace (config/api-host) #"http[s]*://" "")
                 :protocol (if (util/development?) :http :https)
                 :packer :edn
                 :params {:authorization (get-token)}})]

    (def chsk       (:chsk client))
    (def ch-chsk    (:ch-recv client))
    (def chsk-send! (:send-fn client))
    (def chsk-state (:state client))))

(def config {:iceServers [{:url "stun:stun.l.google.com:19302"}
                          {:url "stun:global.stun.twilio.com:3478?transport=udp"}]})

(def rtc-peer-connection (.-RTCPeerConnection webrtc))
(def rtc-media-stream (.-RTCMediaStream webrtc))
(def rtc-ice-candidate (.-RTCIceCandidate webrtc))
(def rtc-session-description (.-RTCSessionDescription webrtc))
(def media-stream-track (.-MediaStreamTrack webrtc))
(def get-user-media (.-getUserMedia webrtc))

(def pc (atom nil))
(defn handle-icecandidate
  [to event]
  (chsk-send! [:rtc/exchange {:to to
                              :candidate (js/JSON.stringify (.-candidate event))}]))

(defn error-handler
  [error]
  (t/error error))

(defn get-local-stream
  [front? cb]
  (let [{:keys [width height]} (js->clj (.get ui/dimensions "window") :keywordize-keys true)]
    (.getSources media-stream-track
                 (fn [source-infos]
                   (let [video-source-id (some->> source-infos
                                                  (filter (fn [info]
                                                            (and (= "video" (.-kind info))
                                                                 (= (if front? "front" "back") (.-facing info)))))
                                                  first
                                                  (.-id))]
                     (get-user-media
                      (if (ui/ios?)
                        (clj->js {"audio" true
                                  "video" {"optional" [{"sourceId" video-source-id}]}})
                        (clj->js {"audio" true
                                  "video" {"optional" [{"sourceId" video-source-id}]
                                           "mandatory" {:maxHeight height
                                                        :maxWidth width}
                                           "facingMode" "user"}}))

                      (fn [stream]
                        (cb stream))
                      error-handler))))))

(defn create-offer
  [pc to]
  (.createOffer pc (fn [desc]
                     (.setLocalDescription pc desc
                                           (fn []
                                             (chsk-send! [:rtc/exchange {:to to
                                                                         :sdp (js/JSON.stringify (.-localDescription pc))}]))
                                           error-handler))
                error-handler))

(defn handle-negotiationneeded
  [pc caller? to]
  (when caller? (create-offer pc to)))

;; (defn handle-iceconnectionstatechange
;;   [event]
;;   (prn "oniceconnectionstatechange" (-> event .-target .-iceConnectionState))
;;   (let [state (-> event .-target .-iceConnectionState)]
;;     (case state
;;       "completed"
;;       "connected")))

(defn handle-addstream
  [event]
  (dispatch [:set-remote-stream (.-stream event)]))

(defn handle-removestream
  [event]
  (prn "onremovestream" (.-stream event)))

(defn new-pc-internal
  [ice-servers caller? to local-stream]
  (let [pc' (new rtc-peer-connection (clj->js ice-servers))]
    (.addEventListener pc' "icecandidate" #(handle-icecandidate to %))
    (.addEventListener pc' "negotiationneeded" #(handle-negotiationneeded pc' caller? to))
    ;; (.addEventListener pc' "iceconnectionstatechange" #(handle-connection pc' id ))
    (.addEventListener pc' "signalingstatechange" #(prn %))
    (.addEventListener pc' "addstream" handle-addstream)
    (.addEventListener pc' "removestream" handle-removestream)
    (.addStream pc' local-stream)
    (reset! pc pc')))

(defn new-pc
  [caller? to local-stream]
  (chsk-send! [:rtc/ice-servers]
              5000
              (fn [reply]
                (if (sente/cb-success? reply)
                  (do
                    (new-pc-internal reply caller? to local-stream))
                  (do
                    (t/error "can't get ice-servers")
                    (new-pc-internal config caller? to local-stream))))))

(defn initial!
  [callee]
  (get-local-stream true (fn [stream]
                           (dispatch [:set-local-stream stream])
                           (dispatch [:nav/push {:key :video-call
                                                 :title "Video Call"
                                                 :user callee}]))))

(defn initial-accept!
  [caller? callee]
  (get-local-stream true (fn [stream]
                           (dispatch [:set-local-stream stream])
                           (dispatch [:nav/push {:key :video-call
                                                 :title "Video Call"
                                                 :user callee}])
                           (new-pc caller? (:id callee) stream))))

;; chat
(defn request-unread-messages
  [latest-message-id]
  (chsk-send! [:chat/get-unread-messages {:latest-message-id latest-message-id}]))

(defn request-updated-contacts
  []
  (let [last (realm/kv-get :contact-last-update-at)
        now (tc/now)]
    (when (and
           last
           (tc/after? now
                      (tc/plus (tcc/to-date-time last) (tc/days 2))))
      (chsk-send! [:chat/request-updated-contacts]
                  5000
                  (fn [reply]
                    (if (sente/cb-success? reply)
                      (when-let [contacts (:updated-contacts reply)]
                        (realm/batch-create "Contact" (clj->js contacts))
                        (realm/kv-set :contact-last-update-at
                                      (tcc/to-date (tc/now))))))))))

(defn request-channel-latest-messages
  [channel-id {:keys [before-id after-id limit]
               :or {limit 20}
               :as opts}]
  (chsk-send! [:chat/get-channel-latest-messages {:channel-id channel-id
                                                  :opts opts}] 5000
              (fn [reply]
                (when (and (sente/cb-success? reply)
                           (not-empty (:messages reply)))
                  (dispatch [:conj-channel-messages channel-id (:messages reply)])))))

(defn request-xxxxx
  []
  (chsk-send! [:chat/get-xxxxx] 5000
              (fn [reply]
                (if (sente/cb-success? reply)
                  (reset! config/xxxxx (:xxxxx reply))))))

(defn request-recommend-channels
  []
  (chsk-send! [:chat/get-recommend-channels] 5000
              (fn [reply]
                (when (sente/cb-success? reply)
                  (dispatch [:set-recommend-channels (:channels reply)])))))

(defn search-members
  [channel-id q]
  (when-not (str/blank? q)
    (chsk-send! [:chat/search-members {:channel-id channel-id
                                       :q q
                                       :limit 3}] 5000
                (fn [reply]
                  (when (sente/cb-success? reply)
                    (dispatch [:set-search-members-result (:members reply)]))))))

(defn get-members
  [channel-id]
  (chsk-send! [:chat/get-members {:channel-id channel-id}] 5000
              (fn [reply]
                (when (sente/cb-success? reply)
                  (dispatch [:set-channel-members channel-id (:members reply)])))))

(defn get-user-by-username
  [username]
  (when-not (str/blank? username)
    (chsk-send! [:chat/get-user-by-username {:username username}] 5000
                (fn [reply]
                  (when (sente/cb-success? reply)
                    (dispatch [:nav/push {:key :channel-profile
                                          :title ""
                                          :user (:user reply)}]))))))

(defn sync
  "Sync contacts[new contact], posts [likes,comments], invites"
  []
  (chsk-send! [:chat/sync {:contacts-ids (realm/get-contacts-ids)}]
              5000
              (fn [reply]
                (when (sente/cb-success? reply)
                  (try
                    (let [{:keys [new-contacts new-invites channels channels-messages]} reply]
                      (realm/batch-create "Contact" (clj->js (util/uuid->str new-contacts)))
                      (realm/batch-create "Invite" (clj->js (util/uuid->str new-invites)))
                      (realm/batch-create "Channel" (clj->js (util/uuid->str channels)))
                      (let [messages (flatten (vals channels-messages))]
                        (realm/batch-create "GroupMessage" (clj->js messages)))

                      (dispatch [:set-channels-messages channels-messages]))
                    (catch js/Error e
                      (t/error e)))))))

;; msg format
;; {:to_id (str (:to msg))
;;  :body body
;;  :created_at (tcc/to-date (tc/now))}
(defn send-message
  ([msg]
   (send-message msg nil nil))
  ([msg timeout cb]
   (when (:to_id msg)
     (if (and timeout cb)
       (chsk-send! [:chat/new-message msg] timeout cb)
       (chsk-send! [:chat/new-message msg])))))

(defn send-channel-message
  ([msg]
   (send-message msg nil nil))
  ([msg timeout cb]
   (when (:channel_id msg)
     (if (and timeout cb)
       (chsk-send! [:chat/new-channel-message msg] timeout cb)
       (chsk-send! [:chat/new-channel-message msg])))))

(defn register-token
  [token]
  (chsk-send! [:notification/register-device-token {:device-token token}]))

(defn reset-badge
  []
  (chsk-send! [:notification/reset-badge]))

(defn ->output! [fmt & args]
  (let [msg (apply encore/format fmt args)]
    (prn msg)))

(defmulti push-msg-handler (fn [[id _]] id))

(defmethod push-msg-handler :default
  [[_ data]]
  (->output! "Unhandled pushed event: %s" data))

;; chat
(defmethod push-msg-handler :chat/new-message
  [[_ {:keys [id user_id to_id body state created_at] :as data}]]
  (->output! "Wsclient-1 new message pushed from server: %s" data)
  ;; conj to current-message
  (dispatch [:conj-message data :user_id]))

(defmethod push-msg-handler :chat/new-mention
  [[_ {:keys [id user_id to_id body state created_at] :as data}]]
  (->output! "Wsclient-1 new mention pushed from server: %s" data)
  ;; conj to current-message
  (dispatch [:conj-mention data]))

;; todo channel message
(defmethod push-msg-handler :chat/new-channel-message
  [[_ {:keys [id channel_id user_id to_id body state created_at] :as data}]]
  (->output! "Wsclient-1 new channel message pushed from server: %s" data)
  ;; conj to current-message
  (dispatch [:conj-channel-message channel_id data]))

(defmethod push-msg-handler :chat/new-invitation
  [[_ data]]
  (->output! "Wsclient-1 new invitation pushed from server: %s" data)
  ;; conj to current-message
  (dispatch [:new-invite data]))

(defmethod push-msg-handler :chat/new-call
  [[_ {:keys [from-id] :as data}]]
  (->output! "Wsclient-1 new call from: %s" from-id)
  (dispatch [:new-call from-id]))

(defmethod push-msg-handler :chat/new-call-accept
  [[_ {:keys [to-id] :as data}]]
  (->output! "Wsclient-1 new call accept from: %s" to-id)
  ;; log for analysis
  (dispatch [:new-call-accept to-id]))

(defmethod push-msg-handler :chat/reject-call
  [[_ {:keys [from-id] :as data}]]
  (->output! "Wsclient-1 recieved reject call from: %s" from-id)
  (dispatch [:reject]))

(defmethod push-msg-handler :chat/cancel-call
  [[_ {:keys [from-id] :as data}]]
  (->output! "Wsclient-1 recieved cancel call from: %s" from-id)
  (dispatch [:cancel]))

(defmethod push-msg-handler :chat/reply-unread-messages
  [[_ data]]
  (->output! "Wsclient-1 unread messages pushed from server: %s" data)
  (realm/batch-insert-messages data)

  (dispatch [:sync-is-over])

  ;; send to server latest received message id
  (when-let [latest-message-id (:id (last data))]
    (chsk-send! [:chat/latest-message-delivered {:latest-message-id latest-message-id}])
    (realm/set-latest-message-id latest-message-id))

  (dispatch [:reload-conversations]))

(defn sdp-cand-handler
  [pc {:keys [from candidate sdp] :as data}]

  (if sdp
    ;; sdp
    (let [sdp (js/JSON.parse sdp)
          remote-desc (new rtc-session-description sdp)]
      (.setRemoteDescription
       pc remote-desc
       (fn []
         (if (= "offer" (.-type sdp))
           (do
             (.createAnswer pc
                            (fn [desc]
                              (.setLocalDescription
                               pc desc
                               (fn []
                                 (chsk-send! [:rtc/exchange {:to from
                                                             :sdp (js/JSON.stringify (.-localDescription pc))}]))
                               (fn [error]
                                 (prn error))))
                            (fn [error]
                              (prn error))))
           (prn "Successfully set remote description")))
       (fn [error]
         (prn "Can't set remote description: " error))))

    ;; candidate
    (when-not (= "null" candidate)
      (.addIceCandidate pc (new rtc-ice-candidate (js/JSON.parse candidate))))))

;; rpc
(defmethod push-msg-handler :rtc/exchange
  [[_ {:keys [from candidate sdp] :as data}]]
  (if @pc
    (sdp-cand-handler @pc data)
    (t/error "Pc not initialized!")))

(defmulti -event-msg-handler :id)

(defn event-msg-handler
  "Wraps `-event-msg-handler` with logging, error catching, etc."
  [{:as ev-msg :keys [id ?data event]}]
  (-event-msg-handler ev-msg))

(defmethod -event-msg-handler
  :default ; Default/fallback case (no other matching handler)
  [{:as ev-msg :keys [event]}]
  (->output! "Unhandled event: %s" event))

(defmethod -event-msg-handler :chsk/state
  [{:as ev-msg :keys [?data]}]
  (if (:first-open? ?data)
    (->output! "Channel socket successfully established!: %s" ?data)
    (->output! "Channel socket state change: %s" ?data)))

(defmethod -event-msg-handler :chsk/recv
  [{:as ev-msg :keys [?data]}]
  (push-msg-handler ?data))

;; todo merge to one request
(defmethod -event-msg-handler :chsk/handshake
  [{:as ev-msg :keys [?data]}]
  (let [[?uid ?csrf-token ?handshake-data] ?data]
    (request-xxxxx)

    (request-recommend-channels)

    (when (realm/me)
      (request-unread-messages (realm/get-latest-message-id)))

    (sync)

    (request-updated-contacts)

    (when (not (realm/kv-get :welcome))
      (try
        (realm/kv-set :welcome true)

        (realm/create "Channel" realm/lym-channel)
        (realm/create-channel-conversation (:id realm/lym-channel)
                                           {:user_id "lymchat"
                                            :name "lymchat"
                                            :username "lymchat"
                                            :body "Welcome to lymchat!"
                                            :created_at (tc/now)})
        (catch js/Error e
          (prn "Error: " e))))

    (when (and (not (realm/kv-get :welcome))
               (realm/kv-get :username-set?))
      (realm/kv-set :welcome true)
      (api/channel-join (:id realm/lym-channel) nil nil))

    (->output! "Handshake: %s" ?data)))

(defmethod -event-msg-handler :chsk/ws-error
  [{:as ev-msg :keys [?data]}]
  nil)

(defonce router_ (atom nil))
(defn stop-router! [] (when-let [stop-fn @router_] (stop-fn)))
(defn start-router! []
  (stop-router!)
  (reset! router_
          (sente/start-client-chsk-router!
           ch-chsk event-msg-handler)))

(defonce _start-once (atom nil))

(defn start! []
  (when (nil? @_start-once)
    (start-client!)
    (start-router!)
    (reset! _start-once true)))
