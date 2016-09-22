(ns lymchat.realm
  (:refer-clojure :exclude [update])
  (:require [cljs-time.core :as t]
            [cljs-time.coerce :as tc]
            [reagent.core :as r]
            [re-frame.core :refer [dispatch]]
            [lymchat.shared.ui :as ui]
            [cljs.tools.reader.edn :as edn]
            [schema.core :as s]
            [clojure.string :as str]
            [lymchat.util :as util]
            [goog.object :as go]))

(def kv-schema {:name "KV"
                :primaryKey "id"
                :properties {:id "int"
                             :value "string"}})

(def string-schema {:name "StringObject"
                    :properties {:value "string"}})

(def user-schema {:name "User"
                  :primaryKey "id"
                  :properties {:id "string"
                               :flake_id "int"
                               :username "string"
                               :name "string"
                               :avatar "string"
                               :oauth_type "string"
                               :oauth_id "string"
                               :language "string"
                               :status {:type "string"
                                        :optional true}
                               :no_invite "bool"
                               :block {:type "bool"
                                       :default false}
                               :timezone {:type "int"
                                          :optional true}
                               :channels {:type "list"
                                          :objectType "Channel"}
                               :created_at {:type "date"}
                               :last_seen_at {:type "date"}}})

(def channel-schema {:name "Channel"
                     :primaryKey "id"
                     :properties {:id "string"
                                  :user_id "string"
                                  :picture {:type "string"
                                            :optional true}
                                  :need_invite {:type "bool"
                                                :optional false}
                                  :block {:type "bool"
                                          :optional false}
                                  :is_private {:type "bool"
                                               :optional false}
                                  :purpose {:type "string"
                                            :optional true}
                                  :name "string"
                                  :type {:type "string"
                                         :optional true}
                                  :members_count "int"
                                  :created_at {:type "date"}}})

(def user-bare (select-keys (:properties user-schema)
                            [:id :username :name :avatar :language :timezone]))

(def contact-schema {:name "Contact"
                     :primaryKey "id"
                     :properties user-bare})

(def offline-pic-schema {:name "Offlinepic"
                         :primaryKey "uri"
                         :properties {:uri "string"
                                      :data "data"
                                      :last_refresh_at {:type "date"}}})

(def invite-schema {:name "Invite"
                    :primaryKey "id"
                    :properties (assoc user-bare
                                       :created_at {:type "date"})})

(def conversation-schema {:name "Conversation"
                          :primaryKey "id"
                          :properties {:id "int"
                                       :is_channel {:type "bool"
                                                    :default false}
                                       :to {:type "string"
                                            :optional true}
                                       :message_id {:type "int"
                                                    :optional true}
                                       :name {:type "string"
                                              :optional true}
                                       :user_id {:type "string"
                                                 :optional true}
                                       :username {:type "string"
                                                  :optional true}
                                       :avatar {:type "string"
                                                :optional true}
                                       :last_message {:type "string"
                                                      :optional true}
                                       :last_message_at {:type "date"
                                                         :optional true}
                                       :is_read {:type "bool"
                                                 :default false}}})

(def message-schema {:name "Message"
                     :primaryKey "id"
                     :properties {:id "int"
                                  :conversation_id "int"
                                  :user_id "string"
                                  :to_id "string"
                                  :body "string"
                                  :is_delivered {:type "bool"
                                                 :default true}
                                  :created_at "date"}})

(def group-message-schema {:name "GroupMessage"
                           :primaryKey "id"
                           :properties {:id "int"
                                        :timezone {:type "int"
                                                   :optional true}
                                        :name "string"
                                        :username "string"
                                        :language "string"
                                        :avatar "string"
                                        :channel_id "string"
                                        :user_id "string"

                                        :body "string"
                                        :is_delivered {:type "bool"
                                                       :default true}

                                        :created_at "date"}})


(def schema (clj->js {:schema [kv-schema
                               string-schema
                               user-schema
                               channel-schema
                               contact-schema
                               conversation-schema
                               message-schema
                               group-message-schema
                               invite-schema
                               offline-pic-schema]
                      :schemaVersion 1
                      }))

(def realm (new ui/Realm schema))

(defn jsx->clj
  [x]
  (if (map? x)
    x
    (into {} (for [k (.keys js/Object x)]
               [(keyword k)
                (let [v (aget x k)]
                  (if (instance? ui/Realm.List v)
                    (map jsx->clj (array-seq v))
                    v))]))))

(defn get-by-id
  [table id]
  (when (and table id)
    (-> realm
        (.objects table)
        (.filtered "id = $0" id)
        (aget 0))))

(defn get-channel-members-count
  [id]
  (some-> (get-by-id "Channel" id)
          (aget "members_count")))

(defn create
  [table record]
  (when (and table record)
    (.write realm (fn [] (.create realm table (clj->js record) true)))))

(defn update
  [table record]
  (when (and table record)
    (.write realm (fn [] (.create realm table (clj->js record) true)))))

(defn batch-create
  [table records]
  (when (and table records)
    (.write realm (fn []
                    (doseq [record records]
                      (.create realm table record true))))))

(defn query
  [table]
  (some->> (.objects realm table)
           array-seq
           (mapv jsx->clj)))

(defn row-exists?
  [table]
  (some-> (.objects realm table)
          (aget 0)))

(defn get-largest-conversation-id
  []
  (let [item (-> realm
                 (.objects "Conversation")
                 (.sorted "id" true)
                 (.slice 0 1)
                 )]
    (if (zero? (count item))
      0
      (aget item 0 "id"))))

(defn me
  []
  (-> (query "User")
      first))

(defn jscol->clj
  [col]
  (some->> col
           array-seq
           (map jsx->clj)))

(defn get-count
  [table]
  (-> realm
      (.objects table)
      (.-length)))

(defn delete
  [table id]
  (when table
    (when-let [obj (get-by-id table id)]
      (.write realm (fn [] (.delete realm obj))))))

(defn list-push
  [table id key item]
  (let [o (get-by-id table id)]
    (.write realm (fn []
                    (.push (aget o key) item)))))

;; Key-value
(defn get-kv
  []
  (-> (query "KV")
      first
      :value
      edn/read-string))

(defn kv-set
  [key value]
  (update "KV" #js {:id 0
                    :value (pr-str (assoc (get-kv) key value))}))

(defn kv-get
  [key]
  (get (get-kv) key))

(defn kv-remove
  [key]
  (update "KV" #js {:id 0
                    :value (pr-str (dissoc (get-kv) key))}))

(let [k "offline-pics"]
  (defn get-offline-pics
    []
    (kv-get k))

  (defn offline-pics-set
    [key value]
    (let [o (get-offline-pics)]
      (kv-set k (assoc o key value))))

  (defn pic-offline?
    [key]
    (let [o (get-offline-pics)]
      (true? (get o key)))))

(defn get-settings
  []
  (select-keys (get-kv) [:no-disturb? :no_invite]))

(defn set-latest-message-id
  [id]
  (kv-set "latest-message-id" id))

(defn get-latest-message-id
  []
  (kv-get "latest-message-id"))

(defn get-conversations
  []
  (some->>
   (-> (.objects realm "Conversation")
       (.sorted "last_message_at" true))
   array-seq
   (map jsx->clj)))

(defonce lym-channel
  {:need_invite false,
   :block false,
   :is_private false,
   :locale "english",
   :purpose nil,
   :name "Lymchat",
   :type "lymchat",
   :members_count 0,
   :id "10000000-3c59-4887-995b-cf275db86343",
   :picture nil,
   :user_id "10000000-3c59-4887-995b-cf275db86343",
   :created_at #inst "2016-08-17T13:59:52.604000000-00:00"})

(defn delete-conversation
  [conversation-id]
  ;; delete messages
  (.write realm
          (fn []
            (->> (-> (.objects realm "Message")
                     (.filtered "conversation_id = $0" conversation-id))
                 (.delete realm))))
  (delete "Conversation" conversation-id))

(defn get-invites
  []
  (query "Invite"))

(defn invite-exists?
  [user]
  (some? (get-by-id "Invite" (:id user))))

(defn get-contacts
  []
  (query "Contact"))

(defn get-contacts-count
  []
  (get-count "Contact"))

(defn get-contacts-ids
  []
  (map :id (query "Contact")))

(defn friend?
  [id]
  (contains? (set (get-contacts-ids)) id))

(defn get-user-by-id
  [id]
  (if id
    (let [me (me)]
      (if (= id (:id me))
        me
        (js->clj (get-by-id "Contact" id) :keywordize-keys true)))))

(defn conversation-exists?
  [id]
  (-> realm
      (.objects "Conversation")
      (.filtered "to = $0 and is_channel = false" id)
      (aget 0)))

(defn channel-conversation-exists?
  [id]
  (-> realm
      (.objects "Conversation")
      (.filtered "to = $0 and is_channel = true" id)
      (aget 0)))

(defn create-conversation
  [to msg msg-created-at]
  (when-not (conversation-exists? to)
    (let [largest-id (get-largest-conversation-id)]
      (when-let [contact (some-> (get-by-id "Contact" to)
                                 (jsx->clj))]
        (let [new-id (inc largest-id)
              conversation {:id new-id
                            :to to
                            :user_id (:id contact)
                            :name (:name contact)
                            :avatar (:avatar contact)
                            :last_message msg
                            :last_message_at msg-created-at}]
          (create "Conversation" conversation)
          (dispatch [:new-conversation conversation])
          new-id)))))

(defn get-conversation-id-by-to
  [to]
  (if-let [conversation (-> realm
                            (.objects "Conversation")
                            (.filtered "to = $0" to)
                            (aget 0))]
    (aget conversation "id")))

(defn safe-get-conversation-id
  [to body created_at]
  (if-let [id (get-conversation-id-by-to to)]
    id
    (create-conversation to body created_at)))

(defn msg-convert
  [me-id msg]
  (when msg
    (when-let [msg (jsx->clj msg)]
      (let [body (:body msg)
            ret {:_id (:id msg)
                 :createdAt (:created_at msg)
                 :user {:_id (:user_id msg)
                        :_username (:username msg)
                        :_avatar (:avatar msg)
                        :_timezone (:timezone msg)
                        :_language (:language msg)
                        :_name (:name msg)}
                 :is_delivered (:is_delivered msg)}]
        (if (util/photo-message? body)
          (assoc ret :image (util/real-photo-url body))
          (assoc ret :text body))))))

(defn ->user
  [msg]
  {:id (:_id msg)
   :username (:_username msg)
   :avatar (:_avatar msg)
   :timezone (:_timezone msg)
   :language (:_language msg)
   :name (:_name msg)})

(defn wrap-conversation-id
  ([msg]
   (wrap-conversation-id msg :user_id))
  ([{:keys [body created_at] :as msg} k]
   (let [cid (get-conversation-id-by-to (get msg k))
         cid (if cid cid (create-conversation (get msg k) body created_at))]
     (assoc msg :conversation_id cid))))

(defn get-conversation-messages
  [current-user-id current-callee n]
  (if-let [conversation-id (get-conversation-id-by-to current-callee)]
    (->>
     (-> realm
         (.objects "Message")
         (.filtered "conversation_id = $0" conversation-id)
         (.sorted "created_at" "reverse")
         (.slice 0 n)
         (reverse))
     (mapv (partial msg-convert current-user-id)))
    []))

(defn get-groups-messages
  []
  (some->> (query "GroupMessage")
           (group-by :channel_id)))

(defn delete-channel-old-messages
  [channel-id message-id]
  (.write realm
          (fn []
            (->>
             (->
              (.objects realm "GroupMessage")
              (.filtered "channel_id = $0 and id < $1" channel-id message-id))
             (.delete realm)))))

(defn load-earlier-messages
  [current-user-id current-callee last-msg-id n]
  (if-let [conversation-id (get-conversation-id-by-to current-callee)]
    (->>
     (-> realm
         (.objects "Message")
         (.filtered "conversation_id = $0 and id < $1" conversation-id last-msg-id)
         (.sorted "created_at" "reverse")
         (.slice 0 n)
         (reverse))
     (mapv (partial msg-convert current-user-id)))
    []))

(defn batch-insert-messages
  [messages]
  (when-let [messages (doall (map #(wrap-conversation-id % :user_id) messages))]
    (let [conversations (group-by :conversation_id messages)]
      (doseq [[id msgs] conversations]
        (let [message (last msgs)]
          (update "Conversation" {:id id
                                  :last_message (:body message)
                                  :last_message_at (:created_at message)}))))
    ;; update conversation
    (batch-create "Message" (clj->js messages))))

(defn create-channel-conversation
  [channel-id message]
  (when-not (channel-conversation-exists? channel-id)
    (let [channel (get-by-id "Channel" channel-id)
          {:keys [user_id name username avatar body created_at]} message
          largest-id (get-largest-conversation-id)
          new-conversation {:id (inc largest-id)
                            :is_channel true
                            :message_id (:id message)
                            :to channel-id
                            :user_id user_id
                            :name name
                            :username name
                            :avatar avatar
                            :last_message body
                            :last_message_at (if created_at (tc/to-date created_at))
                            :is_read true}]
      (create "Conversation" new-conversation)
      (dispatch [:new-conversation new-conversation]))))

(defn delete-channel-conversation
  [channel-id]
  ;; delete messages
  (.write realm
          (fn []
            (->> (-> (.objects realm "Conversation")
                     (.filtered "to = $0 and is_channel = true" channel-id))
                 (.delete realm)))))

(defn leave-channel
  [channel-id]
  (let [current-user (me)]
    (update "User" {:id (:id current-user)
                    :channels (remove #(= (str channel-id) (str (:id %))) (:channels current-user))}))
  (delete-channel-conversation channel-id))

(comment
  (.clearTestState ui/Realm)
  (.write realm (fn [] (.deleteAll realm)))
  (.write realm (fn [] (.delete realm (.objects realm "Match"))))
  (.write realm (fn [] (.delete realm (.objects realm "Contact"))))
  (.write realm (fn [] (.delete realm (.objects realm "Conversation"))))
  (.write realm (fn [] (.delete realm (.objects realm "Invite"))))
  (.write realm (fn [] (.delete realm (.objects realm "Message"))))
  (.write realm (fn [] (.delete realm (.objects realm "GroupMessage"))))
  (.write realm (fn [] (.delete realm (.objects realm "Post"))))
  (.write realm (fn [] (.delete realm (.objects realm "Comment"))))
  (.write realm (fn [] (.delete realm (.objects realm "Channel"))))
  (kv-remove "archive_matches")
  )
