(ns api.tasks
  (:require [api.flake.core :as flake]
            [api.services.twilio :as twilio]
            [api.db.stats :as stats]
            [api.db.channel :as channel]
            [clojure.java.jdbc :as j]
            [api.db.util :as util]))

(defn run
  []
  (prn "Flake Id initial!")
  (flake/init!)
  (prn "Load channels to memory!")
  (j/with-db-connection [db util/default-db]
   (channel/load-in-memory db))
  (prn "Periodically update Twilio ice servers.")
  (twilio/run)
  (prn "Periodically sync stats to db.")
  (stats/run))
