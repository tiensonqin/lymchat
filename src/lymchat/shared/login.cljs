(ns lymchat.shared.login
  (:require [lymchat.shared.ui :as ui]
            [re-frame.core :refer [dispatch dispatch-sync]]
            [reagent.core :as r]
            [lymchat.config :as config]
            [taoensso.timbre :as t]
            [goog.string :as gs]
            [lymchat.realm :as realm]))

(def graph-request (.-GraphRequest ui/fb-sdk))
(def graph-request-manager (.-GraphRequestManager ui/fb-sdk))

(defn get-fb-user-info
  []
  (let [response-cb (fn [error result]
                      (if error
                        (do
                          (dispatch [:set-signing? false])
                          (ui/alert "Login failed!"))
                        (dispatch [:logged :facebook result])))
        fields ["id" "name" "locale" "timezone"]
        params (clj->js {:parameters {:fields {:string (clojure.string/join "," fields)}}})
        info-request (new graph-request "/me" params response-cb)]
    (-> (new graph-request-manager)
        (.addRequest info-request)
        (.start))))

(defn fb-login
  []
  (dispatch [:set-signing? true])
  (-> ui/fb-sdk.LoginManager
      (.logInWithReadPermissions #js ["public_profile"])
      (.then (fn [result]
               (if (.-isCancelled result)
                 (do
                   (dispatch [:set-signing? false]))
                 (get-fb-user-info)))
             (fn [error]
               (do
                 (dispatch [:set-signing? false])
                 (ui/alert (str "login failed!")))))))

(defn google-login
  []
  (dispatch [:set-signing? true])
  (-> ui/google-signin
      (.signIn)
      (.then (fn [user]
               (dispatch [:logged :google user])))
      (.catch (fn [err]
                (dispatch [:set-signing? false])
                (.log js/console err)
                (t/error err)))))

(defn build-wechat-uri
  [code]
  (gs/format "https://api.wechat.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code"
             (.-wechat_id ui/RCTConfig)
             (.-wechat_secret ui/RCTConfig)
             code))

(defn build-wechat-userinfo-uri
  [access-token open-id]
  (gs/format "https://api.wechat.com/sns/userinfo?access_token=%s&openid=%s"
             access-token
             open-id))

(defn get-wechat-profile-by-token-open-id
  [access-token open-id]
  (-> (js/fetch (build-wechat-userinfo-uri access-token open-id) (clj->js {:method "GET"
                                                  :headers {"Content-Type" "application/json"}}))
      (.then (fn [resp]
               (.json resp)))
      (.then (fn [res]
               (dispatch [:logged :wechat res])))
      (.catch (fn [error]
                (dispatch [:set-signing? false])
                (t/error error)))))

(defn get-wechat-profile
  [code]
  (-> (js/fetch (build-wechat-uri code) (clj->js {:method "GET"
                                                  :headers {"Content-Type" "application/json"}}))
      (.then (fn [resp]
               (.json resp)))
      (.then (fn [res]
               (let [access-token (aget res "access_token")
                     open-id (aget res "openid")]
                 (get-wechat-profile-by-token-open-id access-token open-id))))
      (.catch (fn [error]
                (dispatch [:set-signing? false])
                (t/error error)))))

(defn wechat-login
  []
  (dispatch [:set-signing? true])
  (try (.registerApp ui/wechat (.-wechat_id ui/RCTConfig))
       (catch js/Error e
         (prn e)))
  (-> (.sendAuthRequest ui/wechat "snsapi_userinfo" (.-wechat_state ui/RCTConfig))
      (.then (fn [code]
               (get-wechat-profile code)))
      (.catch (fn [err]
                (prn {:error err})
                (dispatch [:set-signing? false])
                (t/error err)))))
