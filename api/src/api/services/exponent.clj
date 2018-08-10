(ns api.services.exponent
  (:require [aleph.http :as http]
            [manifold.deferred :as d]
            [byte-streams :as bs]
            [cheshire.core :refer [generate-string parse-string]]
            [environ-plus.core :refer [env]]
            [clojure.string :as s]
            [api.util :refer [production?]]
            [taoensso.timbre :as t]
            [ring.util.codec :refer [url-encode]]))

(defonce api-host "https://exp.host/--/api/notify/")

(defn post
  [url body]
  (http/post url
             (cond->
               {:headers {"content-type" "application/json"}}
               body
               (assoc :body (generate-string body)))))

(defn build-params
  [opts]
  (-> [opts]
      (generate-string)
      (url-encode "UTF-8")))

(defn add-device
  "If success, return the player id."
  [device-token]
  (let [params (build-params {:exponentPushToken device-token})]
    (try
      @(d/chain
        (post (str api-host params) nil)
        :body
        bs/to-string
        parse-string
        (fn [result]
          (prn {:result result})))
      (catch clojure.lang.ExceptionInfo e
        (t/error e (bs/to-string (:body (ex-data e))))))))

(defn send-notification
  [token message data]
  (let [m       {:exponentPushToken token
                 :message message
                 :data data}
        params (build-params m)]
    (try
      (d/chain
       (post (str api-host params) data)
       :body
       bs/to-string
       (fn [res]
         (parse-string res true)))
      (catch clojure.lang.ExceptionInfo e
        (t/error e (bs/to-string (:body (ex-data e))))))))
