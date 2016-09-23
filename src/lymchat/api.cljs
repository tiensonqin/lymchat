(ns lymchat.api
  (:require-macros [cljs.core.async.macros :refer [go]])
  (:require [lymchat.utils.module :as m]
            [lymchat.utils.async :refer [promise->chan]]
            [cljs.core.async :as async]))

;; Example server, implemented in Rails: https://git.io/vKHKv
(defonce push-endpoint "https://exponent-push-server.herokuapp.com/tokens")

(defn api-post
  ([url token body]
   (api-post url token body prn prn))
  ([url token body success-handler error-handler]
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
                (error-handler error))))))

(defn register-for-push-notifications
  []
  ;; Android remote notification permissions are granted during the app
  ;; install, so this will only ask on iOS

  (go
    (let [status (-> (.askAsync m/Permissions m/Permissions.REMOTE_NOTIFICATIONS)
                     (promise->chan)
                     (async/<!)
                     (aget "status"))]
      (when (= "granted" status)
        (let [token (-> (.getExponentPushTokenAsync m/Notifications)
                        (promise->chan)
                        (async/<!))]
          (api-post push-endpoint nil {:token {:value token}}))))))
