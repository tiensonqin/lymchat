(ns api.db.ws
  (:require [clojure.java.jdbc :as j]
            [api.db.user :as user]
            [api.db.channel :as channel]
            [api.db.message :as message]
            [api.db.invite :as invite]
            [environ-plus.core :refer [env]]
            [taoensso.timbre :as t]))

(defn string->uuid
  [s]
  (when (string? s)
    (java.util.UUID/fromString s)))

(defn sync-all
  [db user-id contacts-ids]
  (try
    (let [user-id (string->uuid user-id)
          contacts-ids (doall (map string->uuid contacts-ids))]
      (j/with-db-connection [conn db]
        (let [channels-ids (:channels (user/get conn user-id))]
          {:new-contacts (user/diff-contacts conn user-id contacts-ids)
           :new-invites (invite/get-my-invites conn user-id)
           :channels (channel/get-channels-members-count conn channels-ids)
           :channels-messages (message/batch-get-channels-latest-messages (:redis env) channels-ids 10)})))
    (catch Exception e
      (t/error e))))
