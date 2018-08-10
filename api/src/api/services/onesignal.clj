(ns api.services.onesignal
  (:require [aleph.http :as http]
            [manifold.deferred :as d]
            [byte-streams :as bs]
            [cheshire.core :refer [generate-string parse-string]]
            [environ-plus.core :refer [env]]
            [clojure.string :as s]
            [api.util :refer [production?]]
            [taoensso.timbre :as t]))

(defonce api-host "https://onesignal.com/api/v1/")

(defn post
  [url body]
  (http/post url
             {:headers {"content-type" "application/json"
                        "accpet" "application/json"}
              :body (generate-string body)}))

(defn put
  [url body]
  (http/put url
             {:headers {"content-type" "application/json"
                        "accpet" "application/json"}
              :body (generate-string body)}))

(defn add-device
  "If success, return the player id."
  [device-token]
  (let [device (cond-> {:app_id (get-in env [:onesignal :app-id])
                        :identifier (s/replace device-token #"[^a-zA-Z0-9]" "")
                        :device_type 0}
                 (not (production?))
                 (assoc :test_type 1))]
    (try
      @(d/chain
        (post (str api-host "players") device)
        :body
        bs/to-string
        parse-string
        (fn [result]
          (get result "id")))
      (catch clojure.lang.ExceptionInfo e
        (t/error e (bs/to-string (:body (ex-data e))))))))

(defn send-notification
  [player-id message data]
  (let [notification (cond-> {:app_id (get-in env [:onesignal :app-id])
                              :contents {:en message}
                              ;; :buttons []
                              :isIos true
                              :include_player_ids [player-id]
                              :ios_badgeType "Increase"
                              :ios_badgeCount 1}
                       (some? data)
                       (assoc :data data))]
    (try
      (d/chain
       (post (str api-host "notifications") notification)
       :body
       bs/to-string
       (fn [res]
         (parse-string res true)))
      (catch clojure.lang.ExceptionInfo e
        (t/error e (bs/to-string (:body (ex-data e))))))))

(defn reset-badge
  [player-id]
  (try
    (put (str api-host "players/" player-id) {:badge_count 0})
    (catch clojure.lang.ExceptionInfo e
      (t/error e (bs/to-string (:body (ex-data e)))))))
