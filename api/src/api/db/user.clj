(ns api.db.user
  (:refer-clojure :exclude [get update])
  (:require [clojure.java.jdbc :as j]
            [api.db.util :refer [with-now in-placeholders] :as util]
            [api.util :refer [flake-id]]
            [clojure.walk :as walk]))

(defonce ^:private table "users")
(defonce ^:private bare-keys [:id :username :name :avatar :language :timezone])

(defn exists?
  [db id]
  (util/exists? db table id))

(defn get
  ([db id]
   (first (j/query db ["select * from users where id = ?" id])))
  ([db id fields]
   (let [sql (format "select %s from users where id = ?"
                     (clojure.string/join "," (map name fields)))]
     (first (j/query db [sql id])))))

(defn get-bare
  [db id]
  (get db id bare-keys))

(defn create
  [db m]
  (when-let [new-user (-> (j/insert! db table
                                     (-> m
                                         (assoc :flake_id (flake-id))
                                         (with-now [:created_at :last_seen_at])))
                          first)]
    new-user))

(defn update
  [db id m]
  (try
    (let [result (-> (j/update! db table m ["id = ?" id])
                    first)]
      result)
    ;; TODO why not throw DuplicateException
    (catch java.sql.BatchUpdateException e
      [:error :duplicated])))

(defn block
  [db id]
  (let [result (j/update! db table {:block true} ["id = ?" id])]
    result))

(defn unblock
  [db id]
  (let [result (j/update! db table {:block false} ["id = ?" id])]
    result))

(defn delete
  [db id]
  (let [result (j/delete! db table ["id = ?" id])]
    result))

(defn item-exists
  [db id field item-value]
  (-> (j/query db [(format "select %s from users where id = ?" (name field)) id])
      first
      (clojure.core/get (keyword field))
      (set)
      (contains? item-value)))

;; distinct check
(defn- add-item
  [db id field item-value]
  (if (item-exists db id field item-value)
    [:error :duplicate]
    (j/execute! db [(format "update users set %s = array_append(%s, ?) where id = ?" field field) item-value id])))

(defn- remove-item
  [db id field item-value]
  (j/execute! db [(format "update users set %s = array_remove(%s, ?) where id = ?" field field) item-value id]))

(defn add-contact
  [db id item]
  (add-item db id "contacts" item))

(defn remove-contact
  [db id item]
  (remove-item db id "contacts" item))

(defn add-channel
  [db id item]
  (add-item db id "channels" item))

(defn remove-channel
  [db id item]
  (remove-item db id "channels" item))

(defn- collify
  [result]
  (if result result []))

(defn normalize-contacts
  [db contacts]
  (let [contacts-ids contacts
        contacts (if-not (empty? contacts-ids)
                   (j/query db (cons (format "select id, username, name, avatar, language, timezone from users where id in (%s)" (in-placeholders contacts-ids)) contacts-ids))
                   nil)]
    contacts))

(defn normalize-channels
  [db channels-ids]
  (when-not (empty? channels-ids)
    (j/query db (cons (format "select * from channels where id in (%s)" (in-placeholders channels-ids)) channels-ids))))

(defn get-contacts
  [db id]
  (when-let [contacts (:contacts (get db id [:contacts]))]
    (let [contacts-ids contacts
          contacts (if-not (empty? contacts-ids)
                     (j/query db (cons (format "select id, username, name, avatar, language, timezone from users where id in (%s)" (in-placeholders contacts-ids)) contacts-ids))
                     nil)]
      contacts)))

(defn diff-contacts
  [db user-id old-contacts-ids]
  (when-let [new-contacts-ids (:contacts (get db user-id [:contacts]))]
    (let [contacts-ids (clojure.set/difference (set new-contacts-ids)  (set old-contacts-ids))
          contacts (if-not (empty? contacts-ids)
                     (j/query db (cons (format "select id, username, name, avatar, language, timezone from users where id in (%s)" (in-placeholders contacts-ids)) contacts-ids))
                     nil)]
      contacts)))

(defn normalize-get
  [db id]
  (when-let [user (get db id [:id :flake_id :username :name :avatar :oauth_type :oauth_id :language :timezone :status :no_invite :block :contacts :channels :created_at :last_seen_at])]
    (-> user
        (assoc :contacts (normalize-contacts db (:contacts user)))
        (assoc :channels (normalize-channels db (:channels user))))))

;; TODO [oauth_type oauth_id] db index
(defn get-by-oauth
  [db oauth-type oauth-id]
  (when-let [id (-> (j/find-by-keys db table {:oauth_type oauth-type :oauth_id oauth-id})
                    first
                    :id)]
    (normalize-get db id)))

(defn get-by-username
  [db username]
  (-> (j/find-by-keys db table {:username username})
      first))

(defn get-users
  [db limit]
  (j/query db ["select id, username, name, avatar, timezone, language, block, last_seen_at, created_at from users
                order by created_at desc limit ?" limit]))
