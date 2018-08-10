(ns api.services.slack
  (:require [aleph.http :as http]
            [cheshire.core :refer [generate-string]]
            [api.util :refer [prod-or-stage?]]
            [clojure.string :as str]
            [taoensso.timbre :as t]
            [environ-plus.core :refer [env]]))

(defn slack-escape [message]
  "Escape message according to slack formatting spec."
  (str/escape message {\< "&lt;" \> "&gt;" \& "&amp;"}))

(defn send-msg
  ([hook msg]
   (send-msg hook msg nil))
  ([hook msg {:keys [specific-user]}]
   (when (prod-or-stage?)
     (let [body {"text" (slack-escape msg)}
           body (if specific-user
                  (assoc body "channel" (str "@" specific-user))
                  body)]
       (http/post hook
                  {:headers {"content-type" "application/json"
                             "accpet" "application/json"}
                   :body (generate-string body)})))))

(def direct-rules
  {:ios     ["tienson"]
   :android ["tienson"]
   :web     ["tienson"]
   })

(def rules {:api-exception {:webhook ""
                            :notifiers ["tienson"]}
            :api-latency {:webhook ""
                          :notifiers ["tienson"]}})

(defn at-prefix
  [notifiers msg]
  (let [prefix (->> notifiers
                    (map (partial str "@"))
                    (str/join " "))]
    (str prefix "\n" msg)))

(defn notify
  [channel msg]
  (let [msg (at-prefix (get-in rules [channel :notifiers]) msg)]
    (send-msg (get-in rules [channel :webhook]) msg)))

(defn new-api-exception
  [msg]
  (notify :api-exception msg))

(defn notify-latency
  [msg]
  (notify :api-latency msg))

(defn notify-exception
  [platform msg]
  (when-let [notifiers (get direct-rules platform)]
    (doseq [notifier notifiers]
      (send-msg (get-in rules [:api-exception :webhook]) msg {:specific-user notifier}))))

(defn to-string
  [& messages]
  (let [messages (cons (format "Environment: %s" (name (:environment env))) messages)]
    (->> (map
           #(if (isa? (class %) Exception)
              (str % "\n\n"
                   (apply str (interpose "\n" (.getStackTrace %))))
              (str %))
           messages)
         (interpose "\n")
         (apply str))))

(defmacro error
  "Log errors, then push to slack,
  first argument could be throwable."
  [& messages]
  `(do
     (t/error ~@messages)
     (new-api-exception (to-string ~@messages))))

(defmacro notify-platform
  "Notify errors."
  [platform & messages]
  `(notify-exception ~platform (to-string ~@messages)))

(defmacro debug
  [& messages]
  `(t/debug ~@messages))

(defmacro info
  [& messages]
  `(t/info ~@messages))
