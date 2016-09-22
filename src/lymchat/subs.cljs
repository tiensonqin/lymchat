(ns lymchat.subs
  (:require-macros [reagent.ratom :refer [reaction]])
  (:require [re-frame.core :refer [register-sub subscribe]]
            [lymchat.shared.ui :refer [moment]]
            [lymchat.realm :as realm]
            [lymchat.util :as util]))

(register-sub
 :nav/index
 (fn [db _]
   (reaction
    (get-in @db [:nav :index]))))

(register-sub
 :nav/state
 (fn [db _]
   (reaction
    (get @db :nav))))

(register-sub
 :nav/current
 (fn [db _]
   (let [index (subscribe [:nav/index])]
     (reaction
      (get-in @db [:nav
                   :routes
                   @index])))))

(register-sub
 :current-user
 (fn [db _]
   (reaction
    (get @db :current-user))))

(register-sub
 :current-tab
 (fn [db _]
   (reaction
    (get @db :current-tab))))

(register-sub
 :contact-search-input
 (fn [db _]
   (reaction
    (get @db :contact-search-input))))

(register-sub
 :channels-search-input
 (fn [db _]
   (reaction
    (get @db :channels-search-input))))

(register-sub
 :hidden-input
 (fn [db _]
   (reaction
    (get @db :hidden-input))))

(register-sub
 :guide-step
 (fn [db _]
   (reaction
    (get @db :guide-step))))

(register-sub
 :current-callee
 (fn [db _]
   (reaction
    (get @db :current-callee))))

(register-sub
 :current-messages
 (fn [db _]
   (reaction
    (distinct (get @db :current-messages)))))

(register-sub
 :local-stream
 (fn [db _]
   (reaction
    (get @db :local-stream))))

(register-sub
 :remote-stream
 (fn [db _]
   (reaction
    (get @db :remote-stream))))

(register-sub
 :header?
 (fn [db _]
   (reaction
    (get @db :header?))))

(register-sub
 :loading?
 (fn [db _]
   (reaction
    (get @db :loading?))))

(register-sub
 :uploading?
 (fn [db _]
   (reaction
    (get @db :uploading?))))

(register-sub
 :conversations
 (fn [db _]
   (reaction
    (distinct (get @db :conversations)))))

(register-sub
 :first-invite
 (fn [db _]
   (reaction
    (first (reverse (sort-by :created_at (distinct (get @db :invites))))))))

(register-sub
 :invites
 (fn [db _]
   (reaction
    (reverse (sort-by :created_at (distinct (get @db :invites)))))))

(register-sub
 :new-message?
 (fn [db _]
   (reaction
    (get @db :new-message?))))

(register-sub
 :no-disturb?
 (fn [db _]
   (reaction
    (get @db :no-disturb?))))

(register-sub
 :google-access?
 (fn [db _]
   (reaction
    (get @db :google-access?))))

(register-sub
 :open-video-call-modal?
 (fn [db _]
   (reaction
    (get @db :open-video-call-modal?))))

(register-sub
 :signing?
 (fn [db _]
   (reaction
    (get @db :signing?))))

(register-sub
 :net-state
 (fn [db _]
   (reaction
    (get @db :net-state))))

(register-sub
 :scroll-to-top?
 (fn [db [_ k]]
   (reaction
    (get @db :scroll-to-top?))))

(register-sub
 :temp-avatar
 (fn [db [_ _ post-id]]
   (reaction
    (get @db :temp-avatar))))

(register-sub
 :channels-search-result
 (fn [db _]
   (reaction
    (get @db :channels-search-result))))

(register-sub
 :search-members-result
 (fn [db _]
   (reaction
    (util/uuid->str (get @db :search-members-result)))))

(register-sub
 :username-input
 (fn [db _]
   (reaction
    (get @db :username-input))))

(register-sub
 :username-set?
 (fn [db _]
   (reaction
    (get @db :username-set?))))

(register-sub
 :channel-messages
 (fn [db [_ channel-id]]
   (reaction
    (util/collify
     (some->> (get-in @db [:channel-messages channel-id])
              (mapv (partial realm/msg-convert (:id (:current-user db))))
              (sort-by :createdAt)
              (reverse)
              (distinct))))))

(register-sub
 :channel-members
 (fn [db [_ channel-id]]
   (reaction
    (util/collify
     (some->> (get-in @db [:channel-members channel-id])
              (distinct))))))

(register-sub
 :channel-auto-focus
 (fn [db _]
   (reaction
    (get @db :channel-auto-focus))))

(defn- format-date
  [message]
  (if (and message (:created_at message))
    (let [created-at (new moment (:created_at message))
          day (cond
                (util/today? created-at)
                "Today"
                (util/yesterday? created-at)
                "Yesterday"
                :else
                (.format created-at "MMM DD, YYYY"))]
      (assoc message :day day))
    message))

(register-sub
 :mentions
 (fn [db _]
   (reaction
    (some->> (get @db :mentions)
             (distinct)
             (sort-by :id)
             (reverse)
             (map format-date)
             (group-by :day)))))

(register-sub
 :unread-mentions-count
 (fn [db _]
   (reaction
    (let [mention-latest-id (realm/kv-get :mention-latest-id)
          mention-latest-id (if mention-latest-id mention-latest-id 0)]
      (let [result (some->> (get @db :mentions)
                            (distinct)
                            (filter #(> (:id %) mention-latest-id))
                            (count))]
        (if (zero? result)
          nil
          result))))))

(register-sub
 :current-channel-members-count
 (fn [db _]
   (reaction
    (let [channel-id (get @db :current-channel)
          c (realm/get-channel-members-count channel-id)]
      (if (zero? c)
        1
        c)))))

(register-sub
 :photo-modal?
 (fn [db [_ id]]
   (reaction
    (get-in @db [:photo-modal? id]))))

(register-sub
 :recommend-channels
 (fn [db _]
   (reaction
    (get @db :recommend-channels))))

(register-sub
 :contacts
 (fn [db _]
   (reaction
    (get @db :contacts))))
