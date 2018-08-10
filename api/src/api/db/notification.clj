(ns api.db.notification
  (:require [taoensso.carmine :as car]
            [taoensso.timbre :as t]
            [api.util :refer [wcar*]]
            ;; [api.services.onesignal :as os]
            [api.services.exponent :as exp]
            [environ-plus.core :refer [env]]))

(defonce ^:private redis-key "notifications")

;; migrate to exponent
(defn add-device
  [db user-id token]
  (when (and user-id token)
    (let [tokens (wcar* db (car/hget redis-key (str user-id)))]
      (wcar* db (car/hset redis-key (str user-id) (set (conj tokens token)))))))

;; (defn add-device
;;   [db user-id device-token]
;;   (when (and user-id device-token)
;;     (if-let [player-id (os/add-device device-token)]
;;       (wcar* db
;;              (car/hset redis-key (str user-id) player-id))
;;       (t/error "Add device token failed: " {:user-id user-id
;;                                             :device-token device-token}))))

(defn send-notification
  [db user-id message data]
  (let [tokens (wcar* db (car/hget redis-key (str user-id)))]
    (when (set? tokens)
        (doseq [token tokens]
          (when token
            (exp/send-notification token message data))))))

;; (defn reset-badge
;;   [db user-id]
;;   (if-let [player-id (wcar* db (car/hget redis-key (str user-id)))]
;;     (os/reset-badge player-id)
;;     (t/error "Notification Error: can't find player-id of " user-id)))

(comment
  (send-notification (:redis env)
                      "bdc69d56-689f-428b-b5e8-7a4a30d9861b"
                      "Hi, test"
                      {:type "bingo"
                       :name "tienson"})

  (send-notification (:redis env)
                      "10000000-3c59-4887-995b-cf275db86343"
                      "Tim Duncan: Hi tienson"
                      {:type "new-message"
                       :message {:id (api.util/flake-id)
                                 :user_id "20000000-81c1-4f1a-aa22-eeb57d2eea98"
                                 :to_id "10000000-3c59-4887-995b-cf275db86343"
                                 :body "Hi tienson"
                                 :created_at (clj-time.coerce/to-date (clj-time.core/now))}}))
