(ns api.services.token
  (require [taoensso.carmine :as car]
           [environ-plus.core :refer [env]]
           [api.util :refer [uuid wcar*]]
           [api.services.token.crypt :as crypt]
           [clojure.string :as string]))

(defonce refresh-tokens "refresh_tokens")

(defn save-token
  [tokens key token]
  (wcar*
   (:redis env)
   (car/hset tokens key token)))

(defn token-exists?
  [tokens key token]
  (and token (= token (wcar*
                       (:redis env)
                       (car/hget tokens key)))))

(defn get-token
  [tokens key]
  (wcar*
   (:redis env)
   (car/hget tokens key)))

(defn delete-token
  [tokens key]
  (wcar*
   (:redis env)
   (car/hdel tokens key)))

(defn get-refresh-token
  [key secret]
  (if-let [refresh-token (wcar*
                          (:redis env)
                          (car/hget refresh-tokens key))]
    refresh-token
    (let [token (crypt/encrypt secret (str key "," (uuid)))]
      (save-token refresh-tokens key token)
      token)))

(defn extract-app-key
  [secret refresh-token]
  (-> secret
      (crypt/decrypt refresh-token)
      (string/split #",")
      first))
