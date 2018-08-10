(ns seeds.db
  (:require [api.pg.core :refer [point]]
            [api.db.user :as user]
            [api.db.util :refer [default-db]]
            [api.util :refer [flake-id]]
            [api.pg.core :as pg]
            [clojure.java.jdbc :as j]))

(def seeds
  {:users (read-string (slurp "resources/seeds/users.edn"))
   :channels (read-string (slurp "resources/seeds/channels.edn"))
   })

(defn truncate!
  []
  (j/execute! default-db ["truncate table users;
                                                      truncate table invites;"]))

(defn import!
  []
  (let [{:keys [users]} seeds]
    (prn "---------- Import users ----------")
    (dorun (map #(user/create default-db (assoc % :flake_id (flake-id))) users))))

(defn init!
  []
  (prn "---------- Truncate table users, topics ----------")
  (truncate!)

  (import!)

  (prn "---------- Import is over! ----------"))
