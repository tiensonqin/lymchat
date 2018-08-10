(ns api.db.channel
  (:refer-clojure :exclude [get update])
  (:require [clojure.java.jdbc :as j]
            [api.db.util :refer [with-now in-placeholders] :as util]
            [api.util :refer [flake-id]]
            [api.db.user :as user]
            [taoensso.carmine :as car]
            [api.util :refer [wcar*]]
            [environ-plus.core :refer [env]]))

(defonce ^:private table "channels")
(defonce ^:private members-table "channels_members")
(defonce channels-cache (atom []))
;; zset
(defonce redis-members-key "channels_members:")

(defn exists?
  [db name]
  (util/exists? db table {:name name}))

(defn member-exists?
  [db channel-id user-id]
  (util/exists? db members-table {:channel_id channel-id
                                  :user_id user-id}))

(defn cache-get
  [id]
  (first (filter #(= (str id) (str (:id %))) @channels-cache)))

(defn get
  [db id]
  (if-let [result (cache-get id)]
    result
    (when-let [result (-> (j/query db ["select * from channels where id = ?" id])
                          first)]
      (swap! channels-cache conj result)
      result)))

(defn create
  [db m]
  (when-let [channel (-> (j/insert! db table (-> m
                                                 (with-now [:created_at])))
                         first)]
    (swap! channels-cache conj channel)
    channel))

(defn update
  [db id m]
  (j/update! db table m ["id = ?" id])
  (swap! channels-cache (fn [cache]
                          (remove #(= id (:id %)) cache)))
  (get db id))

(defn delete
  [db id]
  (j/delete! db table ["id = ?" id])
  (swap! channels-cache (fn [cache]
                          (remove #(= id (:id %)) cache))))

(defn inc-members
  [db id]
  (j/execute! db ["update channels set members_count = members_count + 1 where id = ?" id]))

(defn dec-members
  [db id]
  (j/execute! db ["update channels set members_count = members_count - 1 where id = ?" id]))

(defn get-db-members
  [db channel-id]
  (j/query db ["select * from channels_members where channel_id = ?" channel-id]))

(defn get-members
  [id]
  (->>
   (wcar* (:redis env)
          (car/zrange (str redis-members-key id) 0 -1))
   (remove nil?)))

(defn get-channels-members-count
  [db channels-ids]
  (when (seq channels-ids)
    (j/query db (cons (format "select * from channels where id in (%s)" (in-placeholders channels-ids)) channels-ids))))

(defn get-users-by-usernames
  [id usernames]
  (when-not (empty? usernames)
    (when-let [members (seq (get-members id))]
      (filter #(contains? (set usernames) (:username %)) members))))

(defn get-online-channel-users
  [connected-uids channel-id]
  (when-let [members (map (comp (fn [s] (if s (str s) s)) :id) (get-members channel-id))]
    (clojure.set/intersection (set members) connected-uids)))

(defn join
  [db channel-id user-id]
  (when-let [r (try (j/insert! db members-table (with-now {:channel_id channel-id
                                                           :user_id user-id}
                                                  [:created_at]))
                    (catch Exception e
                      (prn e)))]
    (when-let [user (user/get db user-id [:id :flake_id :name :username :avatar :language :timezone])]
      (wcar* (:redis env)
             (car/zadd (str redis-members-key channel-id) (:flake_id user) user)))))

(defn leave
  [db channel-id user-id]
  (when (first (j/delete! db members-table ["channel_id = ? and user_id = ?"
                                            channel-id
                                            user-id]))
    (when-let [user (user/get db user-id [:flake_id])]
      (wcar* (:redis env)
             (car/zremrangebyscore (str redis-members-key channel-id) (:flake-id user) (:flake-id user))))))

(defn get-all
  [db]
  (j/query db ["select * from channels
                where block = false
                and is_private = false
                order by created_at desc"]))

(defn load-in-memory
  [db]
  (reset! channels-cache (distinct (get-all db))))

(defn cache-get-all
  []
  @channels-cache)

(defn search-by-name-prefix
  [q limit]
  (some->> @channels-cache
           (filter #(re-find (re-pattern (str "(?i)" q)) (:name %)))
           (sort (fn [t1 t2]
                   (if (clojure.string/starts-with?
                        (clojure.string/lower-case (:name t1))
                        (clojure.string/lower-case q))
                     true
                     false)))
           (take limit)))

(defn search-members
  [user-id id q limit]
  (when q
      (when-let [members (seq (get-members id))]
        (some->> members
              (filter #(and
                        (not= user-id (str (:id %)))
                        (or (re-find (re-pattern (str "(?i)" q)) (:username %))
                            (re-find (re-pattern (str "(?i)" q)) (:name %)))))
              (sort (fn [t1 t2]
                      (if (or
                           (clojure.string/starts-with?
                            (clojure.string/lower-case (:name t1))
                            (clojure.string/lower-case q))
                           (clojure.string/starts-with?
                            (clojure.string/lower-case (:username t1))
                            (clojure.string/lower-case q)))
                        true
                        false)))
              (take limit)))))

(defn get-recommend
  [db]
  (let [countries ["United Kingdom" "United States" "China" "Japan" "Spain" "France" "Germany" "Italy" "Denmark" "Sweden" "Norway" "Australia" "Iceland" "Luxembourg" "Switzerland" "Qatar" "New Zealand" "Netherlands" "Finland" "Ireland" "Canada" "Singapore" "Belgium" "Slovenia" "United Arab Emirates" "South Korea" "Chile" "Portugal"]]
    {:languages (vec (j/query db ["select * from channels where type = 'language' order by created_at asc"]))
     :places (vec (j/query db ["select * from channels where type = 'place' and locale = 'english' order by created_at asc"]))
     :chinese-places (vec (j/query db ["select * from channels where type = 'place' and locale = 'chinese' order by created_at asc limit 20"]))
     :others (vec (j/query db ["select * from channels where type is null and locale = 'english' order by created_at asc limit 20"]))
     :chinese-others (vec (j/query db ["select * from channels where type is null and locale = 'chinese' order by created_at asc limit 20"]))
     :nba (vec (j/query db ["select * from channels where type = 'nba' order by created_at asc"]))
     :football (vec (j/query db ["select * from channels where type = 'football' order by created_at asc"]))
     :countries (let [result (j/query db ["select * from channels where type = 'country' order by created_at asc"])]
                  (->> (for [country countries]
                         (filter #(= country (:name %)) result))
                       (apply concat)
                       (vec)))
     :colleges (vec (j/query db ["select * from channels where type = 'college' order by created_at asc"]))
     :chinese-colleges (vec (j/query db ["select * from channels where type = 'chinese-college' order by created_at asc limit 20"]))}))

(defn get-recommend-others
  [db locale]
  (if (= "Chinese" locale)
    (j/query db ["select * from channels where type is null and locale = 'chinese' order by created_at asc limit 20"])
    (j/query db ["select * from channels where type is null and locale = 'english' order by created_at asc limit 20"])))
