(ns api.middlewares.ring
  "A standard set of commonly used ring middleware"
  (:require [api.middlewares.auth :refer [wrap-jwt-auth wrap-authorization]]
            [api.schema.human :refer [human-explain]]
            [api.services.slack :refer [error]]
            [api.util :refer [doc app-key-exists? get-platform-by-app-key prod-or-stage? stage? development? production?]]
            [environ-plus.core :refer [env]]
            [plumbing.core :refer :all]
            [ring.middleware.json :as json]
            [ring.middleware.params :as params]
            [ring.middleware.reload :refer [wrap-reload]]
            [ring.middleware.cors :as cors]
            [schema.core :as s]
            [taoensso.timbre :as t]
            [manifold.deferred :as d]))

(defn wrap-full-url [f]
  (fn [request]
    (f (assoc-in request [:custom :url]
                 (str
                  (if (production?) "https://" "http://")
                  (get-in request [:headers "host"])
                  (:uri request))))))

(defn custom-wrap-cors [handler]
  (if (production?)
    handler
    (let [access-control (cors/normalize-config [:access-control-allow-origin [#".*"]
                                                 :access-control-allow-methods [:get :put :post :delete :options :patch]
                                                 :access-control-allow-credentials "true"])]
      (fn [request]
        (if (and (cors/preflight? request) (cors/allow-request? request access-control))
          (let [blank-response {:status 200
                                :headers {}
                                :body "preflight complete"}]
            (cors/add-access-control request access-control blank-response))
          (if (cors/origin request)
            (if (cors/allow-request? request access-control)
              (d/let-flow [response (handler request)]
                (cors/add-access-control request access-control response)))
            (handler request)))))))

(defn wrap-user-id-body-if-post-request [f]
  (fn [request]
    (if (and
         (re-find #"^/v[\d]+" (:uri request))
         (not (re-find #"^/v[\d]+/auth" (:uri request)))
         (not (app-key-exists? (get-in request [:custom :user-id])))
         (= :post (:request-method request)))
      (let [user-id (get-in request [:custom :user-id])
            req (if (seq? (:body request))
                  (assoc request :body
                         (map #(assoc % :user_id user-id) (:body request)))
                  (assoc-in request [:body :user_id] user-id))]
        (f req))
      (f request))))

(defn human-errors [m]
  (zipmap
   (keys m)
   (map
     #(if (map? %)
        (human-errors %)
        (if (instance? schema.utils.ValidationError %)
          (human-explain %)
          %))
     (vals m))))

(defn wrap-exception [f]
  (fn [request]
    (try (f request)
         (catch clojure.lang.ExceptionInfo e
           (let [{:keys [type error schema data code]} (ex-data e)]
             (prn {:request request
                   :error e})
             (cond
               (= :coercion-error type)
               (do (error {:code :coercion-exception
                           :data data
                           :schema schema
                           :error error
                           :request request})
                   (cond
                     (and (instance? schema.utils.ValidationError e)
                          (nil? data))
                     {:status 400 :body {:message "Body empty."}}

                     :else
                     (try
                       (let [errors (-> (s/check schema data)
                                        human-errors
                                        (merge (select-keys (:validation doc) (keys error))))]
                         (when (development?)
                           (println "Validation error: ")
                           (clojure.pprint/pprint  {:error error
                                                    :data data
                                                    :errors errors}))
                         {:status 400 :body {:message errors}})
                       (catch Exception e
                         (let [errors (-> (s/check schema data)
                                          (merge (select-keys (:validation doc) (keys error))))]
                           {:status 400 :body {:message errors}})))))
               (= :input-invalid type)
               (let [error-text (get-in doc code)]
                 (if (and code error-text)
                   {:status 400 :body {:message error-text}}
                   {:status 500 :body "input invalid!"}))

               :else (do
                       (error e {:code :validation-exception
                                 :request request})
                       (throw e)))))

         ;; fix schema.utils.ValidationError could not serialize
         (catch com.fasterxml.jackson.core.JsonGenerationException e
           (error e {:code :schema.utils.ValidationError-serialize
                     :request request})
           {:status 400
            :body {:message "input illegal"}})
         (catch Exception e
           (prn {:exception e})
           (t/error e)
           {:status 500
            :body {:message "Exception caught"}}))))

(defn keywordize-middleware [handler]
  (fn [req]
    (handler
     (-> req
         (update-in [:query-params] keywordize-map)
         (update-in [:params] keywordize-map)))))

(defn debug-middleware [f]
  (fn [request]
    (prn "Debug: -------------" request)
    (f request)))

(defn ring-middleware [handler]
  (-> handler
      wrap-reload
      wrap-exception
      json/wrap-json-response
      wrap-user-id-body-if-post-request
      (wrap-authorization (:db env))
      (wrap-jwt-auth (:jwt-secret env))
      wrap-full-url
      (json/wrap-json-body {:keywords? true})
      keywordize-middleware
      (custom-wrap-cors)
      params/wrap-params))
