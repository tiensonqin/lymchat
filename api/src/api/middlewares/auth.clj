(ns api.middlewares.auth
  (:require [api.schemas :refer [unauthorized]]
            [api.util :refer [uuid ->long app-key-exists? app-auth?]]
            [clj-jwt.core :refer [jwt to-str sign verify str->jwt]]
            [clj-time.coerce :refer [from-long]]
            [clj-time.core :refer [now plus days hours before? after?]]
            [clojure.string :as str]
            [environ-plus.core :refer [env]]))

;; TODO let cache handle this for scale
(def wrong-auth (atom nil))

;; jwt auth
(defn claim
  [user-id {:keys [expires app-key scope]}]
  (let [now (now)
        expires (plus now expires)]
    {:exp expires
     :iat now
     :iss user-id
     :sub (uuid)
     :nbf now
     :jti (uuid)
     :app-key app-key
     :scope scope}))

(defn jwt-token
  "Given a user id, secret, expires, scope, return a jwt token."
  [user-id secret {:keys [expires app-key scope] :as opts}]
  (-> (claim user-id opts)
      jwt
      (sign :HS256 secret)
      to-str))

(defn build-token
  "Jwt token build helper."
  ([user-id]
   (build-token user-id nil))
  ([user-id {:keys [expires app-key scope]
             :or {expires (hours 2)}
             :as opts}]
   (jwt-token user-id (:jwt-secret env) {:expires expires
                                         :app-key app-key
                                         :scope scope})))

(defn jwt-decode-token
  "Decode jwt token."
  [token]
  (try (some-> token
               str->jwt)
       (catch Exception e
         nil)))

(defn- token-valid? [decoded-token secret]
  (try (let [exp (from-long (* 1000 (get-in decoded-token [:claims :exp])))
             nbf (from-long (* 1000 (get-in decoded-token [:claims :nbf])))
             current-time (now)]
         (and (verify decoded-token secret)
              (not (before? exp current-time))
              (not (after? nbf current-time))
              (get decoded-token :claims)))
       (catch Exception e
         nil)))

(defn verify-token
  "If token is not expired, return the current user id."
  [token secret]
  (when-let [token (jwt-decode-token token)]
    (token-valid? token secret)))

(defn get-current-claim
  "Get current claim."
  [req secret]
  (when-let [token (get-in req [:headers "authorization"] "")]
    (let [token (str/replace token "Bearer " "")]
      (verify-token token secret))))

(defn get-ws-claim
  "Get ws claim."
  [req secret]
  (when-let [token (get-in req [:params :authorization] "")]
    (let [token (str/replace token "Bearer " "")]
      (verify-token token secret))))

(defn wrap-jwt-auth
  "Ring middleware for jwt authenticate."
  [app secret]
  (fn [req]
    (cond
      ;; admin
      (re-find #"^/admin" (:uri req))
      (if-let [claim (get-current-claim req secret)]
        (let [{:keys [iss]} claim]
          (if (= iss "10000000-3c59-4887-995b-cf275db86343")
            (app req)
            (unauthorized)))
        (unauthorized))

      ;; auth
      (re-find #"^/v[\d]+/auth" (:uri req))
      (let [{:keys [app-key app-secret]} (:body req)]
        (if (app-auth? app-key app-secret)
          (app (-> req
                   (assoc-in [:custom :app-key] app-key)))
          (unauthorized "app-key or app-secret not matched")))

      (re-find #"^/v[\d]+" (:uri req))
      (if-let [claim (get-current-claim req secret)]
        (let [{:keys [iss app-key]} claim]
          (if iss
            (app (-> req
                     (assoc-in [:custom :user-id] iss)
                     (assoc-in [:custom :app-key] app-key)))
            (app (-> req
                     (assoc-in [:custom :app-key] app-key)))))
        (unauthorized "access denied (jwt token is absent or invalid)"))

      (re-find #"^/ws" (:uri req))
      (if-let [claim (get-ws-claim req secret)]
        (let [{:keys [iss app-key]} claim]
          (if iss
            (app (-> req
                     (assoc-in [:custom :user-id] iss)
                     (assoc-in [:custom :app-key] app-key)))
            (app (-> req
                     (assoc-in [:custom :app-key] app-key)))))
        (unauthorized "websocket access denied (jwt token is absent or invalid)"))

      :else
      (app req))))

(defn wrap-authorization
  "Ring middleware for authorization."
  [app db]
  (fn [{:keys [uri] :as req}]
    (cond
      (and (re-find #"^/v[\d]+" uri)
           (contains? #{:patch :delete} (:request-method req))
           (nil? (get-in req [:custom :user-id])))
      (unauthorized)

      ;; app authenticate, notifications
      :else (app req))))
