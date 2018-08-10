(ns api.services.twilio
  (:require [aleph.http :as http]
            [manifold.deferred :as d]
            [byte-streams :as bs]
            [cheshire.core :refer [generate-string parse-string]]
            [environ-plus.core :refer [env]]
            [clojure.string :as s]
            [api.util :refer [production? base64-encode]]
            [taoensso.timbre :as t]
            [manifold.time :as mf]))

(defn base-url []
  (format "https://api.twilio.com/2010-04-01/Accounts/%s/"
          (get-in env [:twilio :sid])))

(defn fetch-token []
  (try
    @(d/chain
      (http/post (str (base-url) "Tokens.json")
                 {:headers {"authorization" (str "Basic "
                                                 (base64-encode
                                                  (str
                                                   (get-in env [:twilio :sid])
                                                   ":"
                                                   (get-in env [:twilio :auth-token]))))}})
      :body
      bs/to-string
      parse-string)
    (catch clojure.lang.ExceptionInfo e
      (t/error  (bs/to-string (:body (ex-data e)))))))

(defonce token (atom nil))

(defn get-ice-servers []
  (get @token "ice_servers"))

(defn replace-token []
  (future
    (let [new-token (fetch-token)]
     (reset! token new-token))))

(defn run []
  (replace-token)
  (mf/every (* 1000 60 30) #'replace-token))
