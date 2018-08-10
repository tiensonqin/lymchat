(ns api.db.report
  (:require [clojure.java.jdbc :as j]
            [api.db.util :refer [with-now]]))

(defonce ^:private table "reports")

(defn create
  [db m]
  (-> (j/insert! db table (-> m
                              (with-now [:created_at])))
      first))

(defn get-reports
  [db limit]
  (j/query db ["select r.id, r.user_id, r.type, r.type_id, r.title, r.picture, r.description, r.created_at, r.block, users.name, users.avatar from reports as r
                left join users on users.id = r.user_id
                order by r.created_at desc
                limit ?" limit]))

(defn block
  [db type type-id]
  (j/update! db table {:block true}
             ["type = ? and type_id = ?" (name type) type-id]))

(defn unblock
  [db type type-id]
  (j/update! db table {:block false}
             ["type = ? and type_id = ?" (name type) type-id]))
