(ns api.scripts.channel
  (:require [api.db.channel :as c]
            [api.db.util :refer [default-db]]))

(def seeds (read-string (slurp "resources/seeds/channels.edn")))

(defn init!
  []
  (let [user-id #uuid "10000000-3c59-4887-995b-cf275db86343"
        {:keys [lym languages programming places chinese-places nba-teams football-teams countries others chinese-others colleges chinese-colleges]} seeds]
    ;; lym
    (prn "lym")
    (c/create default-db lym)

    ;; languages
    (prn "languages")
    (doseq [i languages]
      (c/create default-db {:name i
                            :user_id user-id
                            :type "language"}))

    ;; places
    (prn "places")
    (doseq [city places]
      (c/create default-db (-> city
                              (update :picture (fn [src]
                                                 (str "https://nomadlist.com" src)))
                              (merge
                               {:user_id user-id
                                :type "place"}))))

    (prn "chinese places")
    (doseq [city chinese-places]
      (c/create default-db {:user_id user-id
                            :name city
                            :type "place"
                            :locale "chinese"}))

    ;; nba-teams
    (prn "nba teams")
    (doseq [[name pic] nba-teams]
      (c/create default-db {:name name
                            :picture pic
                            :user_id user-id
                            :type "nba"}))

    (doseq [[name pic] football-teams]
      (c/create default-db {:name name
                            :picture pic
                            :user_id user-id
                            :type "football"}))

    (doseq [[name pic] countries]
      (c/create default-db {:name name
                            :picture pic
                            :user_id user-id
                            :type "country"}))

    (doseq [[name pic] colleges]
      (c/create default-db {:name name
                            :picture pic
                            :user_id user-id
                            :type "college"}))

    (doseq [[name pic] chinese-colleges]
      (c/create default-db {:name name
                            :picture pic
                            :user_id user-id
                            :type "chinese-college"}))

    (prn "others")
    (doseq [i others]
      (c/create default-db {:name i
                            :user_id user-id}))

    (prn "chinese others")
    (doseq [i chinese-others]
      (c/create default-db {:name i
                            :user_id user-id
                            :locale "chinese"}))))
