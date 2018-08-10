(ns api.db.invite
  (:require [clojure.java.jdbc :as j]
            [api.db.util :refer [with-now]]
            [api.db.user :as user]))

(defonce ^:private table "invites")

(defn create
  "user-id want to be friend with invite-id."
  [db user-id invite-id]
  (try (j/insert! db table (with-now {:user_id user-id
                                      :invite_id invite-id}
                             [:created_at]))
       (catch Exception e
         nil)))

(defn delete
  [db user-id invite-id]
  (j/delete! db table ["user_id = ? and invite_id = ?" user-id invite-id]))

(defn accept
  "invite-id accept user-id's invitation."
  [db invite-id user-id]
  (delete db user-id invite-id)
  (user/add-contact db invite-id user-id)
  (user/add-contact db user-id invite-id))

(defn reject
  "invite-id reject user-id's invitation."
  [db invite-id user-id]
  (delete db user-id invite-id))

(defn get-my-invites
  [db user-id]
  (j/query db
    ["select u.id, u.username, u.name, u.avatar, u.language, u.timezone, i.created_at from users as u
               left join invites as i on u.id = i.user_id
               where i.invite_id = ? order by i.created_at desc" user-id]))


(comment
  (let [users (:users seeds.db/seeds)]
    (def db api.db.util/default-db)
    (def id1 (:id (nth users 0)))
    (def id2 (:id (nth users 1)))
    (def id3 (:id (nth users 2)))
    (def id4 (:id (nth users 3)))
    (create db id1 id2)
    (create db id1 id3)
    (create db id4 id1)
    (accept db id2 id1)
    ))
