(ns lymchat.api
  (:require [lymchat.config :refer [api-host] :as config]
            [lymchat.realm :as realm]
            [cljs-time.core :as t]
            [cljs-time.coerce :as tc]
            [re-frame.core :refer [dispatch dispatch-sync]]
            [lymchat.shared.ui :as ui]
            [lymchat.util :as util]
            [lymchat.locales :refer [locales]]
            [lymchat.photo :as photo]
            [clojure.string :as str]
            [reagent.core :as r]
            [goog.string :as gs]))

(defonce token (atom nil))

(defn get-token
  []
  (if @token
    @token
    (realm/kv-get :token)))

(defn api-post
  [url token body success-handler error-handler]
  (-> (js/fetch url (clj->js (cond->
                               {:method "POST"
                                :headers (cond->
                                           {"Accept" "application/json"
                                            "Content-Type" "application/json"}
                                           (some? token)
                                           (assoc "Authorization" (str "Bearer " token)))}
                               (some? body)
                               (assoc :body (js/JSON.stringify (clj->js body))))))
      (.then (fn [resp]
               (if (not (nil? resp))
                 (let [ok (.-ok resp)
                       handle-fn (fn [data]
                                   (if ok
                                     (success-handler data)
                                     (error-handler data)))]
                   (-> (.json resp)
                       (.then handle-fn))))))
      (.catch (fn [error]
                (prn error)
                (error-handler error)))))

(defn api-patch
  [url token body success-handler error-handler]
  (-> (js/fetch url (clj->js {:method "PATCH"
                              :headers {"Accept" "application/json"
                                        "Content-Type" "application/json"
                                        "Authorization" (str "Bearer " token)}
                              :body (js/JSON.stringify (clj->js body))}))
      (.then (fn [resp]
               (if (not (nil? resp))
                 (let [ok (.-ok resp)
                       handle-fn (fn [data]
                                   (if ok
                                     (success-handler data)
                                     (error-handler data)))]
                   (-> (.json resp)
                       (.then handle-fn))))))
      (.catch (fn [error]
                (prn error)
                (error-handler error)))))

(defn api-delete
  [url token success-handler error-handler]
  (-> (js/fetch url (clj->js {:method "DELETE"
                              :headers {"Accept" "application/json"
                                        "Content-Type" "application/json"
                                        "Authorization" (str "Bearer " token)}}))
      (.then (fn [resp]
               (if (not (nil? resp))
                 (let [ok (.-ok resp)
                       handle-fn (fn [data]
                                   (if ok
                                     (success-handler data)
                                     (error-handler data)))]
                   (-> (.json resp)
                       (.then handle-fn))))))
      (.catch (fn [error]
                (prn error)
                (error-handler error)))))

(defn api-get
  [url token success-handler error-handler]
  (-> (js/fetch url (clj->js {:method "GET"
                              :headers {"Content-Type" "application/json"
                                        "Authorization" (str "Bearer " token)}}))
      (.then (fn [resp]
               (if (not (nil? resp))
                 (let [ok (.-ok resp)
                       handle-fn (fn [data]
                                   (if ok
                                     (success-handler data)
                                     (error-handler data)))]
                   (-> (.json resp)
                       (.then handle-fn))))))
      (.catch (fn [error]
                (error-handler error)))))


(defn social->user
  [type info]
  (let [user (js->clj info :keywordize-keys true)]
    (case type
      :facebook
      {:name (:name user)
       :avatar (str "http://graph.facebook.com/" (:id user) "/picture?type=large")
       :oauth_type "facebook"
       :oauth_id (:id user)
       :language (get locales (keyword (:locale user)) "English")
       :timezone (:timezone user)}

      :google
      {:name (:name user)
       :avatar (:photo user)
       :oauth_type "google"
       :oauth_id (:id user)
       :language (get user :language "English")
       :timezone nil}

      :wechat
      {:name (:nickname user)
       :avatar (:headimgurl user)
       :oauth_type "wechat"
       :oauth_id (:openid user)
       :language "Chinese"
       :timezone 8})))

(defn ->date
  [user]
  (-> user
      (update :created_at tc/to-date)
      (update :last_seen_at tc/to-date)))

(defn auth
  [social-type user-info]
  (api-post (str (api-host) "/v1/auth") nil (assoc (social->user social-type user-info)
                                                   :app-key (.-app_key ui/RCTConfig)
                                                   :app-secret (.-app_secret ui/RCTConfig))
            (fn [res]
              (let [res (js->clj res :keywordize-keys true)]
                (if (:new res)
                  (dispatch [:set-username-set? false])
                  (dispatch [:set-username-set? true]))
                (let [user (-> (:user res)
                               (->date)
                               (update :channels (fn [channels]
                                                   (map #(update % :created_at tc/to-date) channels))))
                      token-str (:token res)]
                  (reset! token token-str)
                  (dispatch-sync [:set-current-user user])
                  (dispatch [:set-signing? false])
                  (realm/create "User" user)
                  ;; download avatar
                  (photo/download-avatar (:id user) (util/get-avatar (:avatar user) :large) true)

                  (realm/batch-create "Contact" (clj->js (:contacts user)))
                  (realm/kv-set :contact-last-update-at (tc/to-long (t/now)))
                  (realm/kv-set :token token-str))))
            (fn [error]
              ;; todo error handler
              (prn error))))

(defn uri-query-params
  [uri params]
  (str uri "?"
       (clojure.string/join "&" (map (fn [[k v]] (str (name k) "=" v)) params))))

(defn patch-me
  ([body]
   (patch-me body nil nil))
  ([body success-cb error-cb]
   (api-patch (str (api-host) "/v1/me") (get-token) body
              (fn [res]
                (realm/update "User" (merge {:id (:id (realm/me))}
                                            body))
                (if success-cb
                  (success-cb res)))
              (fn [data]
                (if error-cb (error-cb data))))))

(defn invite-send
  [invite-id invite?]
  (api-post (str (api-host) "/v1/invites") (get-token) {:invite_id (str invite-id)}
            (fn [res]
              (reset! invite? true))
            (fn [error]
              ;; todo error handler
              (prn (.-error error)))))

(defn invite-reply
  [user reply]
  (api-post (str (api-host) "/v1/invites/reply") (get-token) {:issue_id (:id user)
                                                              :reply reply}
            (fn [res]
              ;; save contact
              (let [invites-count (realm/get-count "Invite")]
                (if reply
                  (do
                    (try (realm/create "Contact" (clj->js user))
                         (catch js/Error e
                           nil))

                    (dispatch [:conj-message {:id (long (str (tc/to-long (t/now)) (rand-int 100)))
                                              :user_id (:id (realm/me))
                                              :to_id (:id user)
                                              :body "Hi, I accept your invitation."
                                              :created_at (tc/to-date (t/now))}
                               :to_id])

                    (if (> invites-count 1)
                      ;; do nothing
                      nil
                      (do
                        (util/restore-header)
                        (dispatch [:jump-in-conversation user]))))

                  (if (> invites-count 1)
                    ;; do nothing
                    nil
                    (do
                      (util/show-header)
                      (dispatch [:nav/pop])))))

              (dispatch [:delete-invite (:id user)]))

            (fn [error]
              ;; todo error handler
              (prn error))))

(defn contact-delete
  [user-id]
  (api-delete (str (api-host) "/v1/me/contacts/" user-id) (get-token)
              (fn [res]
                (dispatch [:nav/home])
                (util/restore-header)
                (js/setTimeout
                 (fn []
                   (realm/delete "Conversation" (realm/get-conversation-id-by-to user-id))
                   (realm/delete "Contact" user-id))
                 500))
              (fn [error]
                ;; todo error handler
                (prn error))))

;; reports
(defn report-create
  [report]
  (api-post (str (api-host) "/v1/reports") (get-token) report
            (fn [res]
              (prn {:res res}))
            (fn [error]
              ;; todo error handler
              (prn error))))


(defn channels-search
  [q]
  (when-not (str/blank? q)
    (api-get (str (api-host) "/v1/me/channels/search?q=" q)
             (get-token)
             (fn [res]
               (let [res (js->clj res :keywordize-keys true)]
                 (when-not (empty? res)
                   (dispatch [:set-channels-search-result (:channels res)]))))
             (fn [error]
               ;; todo error handler
               (prn error)))))

(defn channel-join
  [id success-handler error-handler]
  (api-get (str (api-host) (gs/format "/v1/channels/%s/join" (str id)))
           (get-token)
           (fn [res]
             (let [res (js->clj res :keywordize-keys true)]
               (realm/create-channel-conversation id (first (:messages res)))
               (dispatch [:set-channel-messages id (:messages res)])
               (if success-handler (success-handler))))
           (fn [error]
             (if error-handler (error-handler)))))


(defn channel-leave
  [id success-handler error-handler]
  (api-get (str (api-host) (gs/format "/v1/channels/%s/leave" (str id)))
           (get-token)
           (fn [res]
             (realm/leave-channel id)
             (dispatch [:delete-channel-conversation id])
             (if success-handler (success-handler)))
           (fn [error]
             (prn {:error error})
             (prn "Leave failed!")
             (if error-handler (error-handler)))))

(defn get-mentions
  [{:keys [after-id before-id limit]
    :or {limit 10}
    :as opts}]
  (let [uri (util/uri-query-params (str (api-host) "/v1/me/mentions") opts)]
    (api-get uri
            (get-token)
            (fn [res]
              (let [res (js->clj res :keywordize-keys true)]
                (when-not (empty? res)
                  (dispatch [:conj-mentions (:mentions res)]))))
            (fn [error]
              ;; todo error handler
              (prn error)))))

(defn refresh-mentions
  [{:keys [after-id before-id limit]
    :or {limit 100}
    :as opts}
   success-handler
   error-handler]
  (let [uri (util/uri-query-params (str (api-host) "/v1/me/mentions") opts)]
    (api-get uri
             (get-token)
             (fn [res]
               (let [res (js->clj res :keywordize-keys true)]
                 (when-not (empty? res)
                   (dispatch [:conj-mentions (:mentions res)]))
                 (when success-handler
                   (success-handler res))))
             (fn [error]
               (when error-handler
                 (error-handler error))))))
