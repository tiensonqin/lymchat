;; (ns api.scripts.destinations
;;   (:require [api.scripts.scrape :as s]
;;             [net.cgrand.enlive-html :as html]
;;             [api.scripts.aws :as aws]
;;             [api.db.util :refer [default-db]]
;;             [clojure.java.jdbc :as j]
;;             [api.db.channel :as c]))

;; (def node (s/fetch-url "https://www.tripadvisor.com/TravelersChoice-Destinations-cTop-g1"))

;; ;; world
;; (def node (html/html-resource (java.io.File. "/Users/tienson/Downloads/trip.html")))

;; (defn get-names
;;   []
;;   (->>
;;    (html/select node [:div#WINNERVIEWER :div.mainName :a])
;;    (map html/text)))

;; (defn get-images
;;   []
;;   (s/attrs node [:div.tcInner :li.firstone :img] [:src]))

;; (defn get-descriptions
;;   []
;;   (map html/text (html/select node [:div.descr_lb])))

;; (def names ["London, United Kingdom" "Istanbul, Turkey" "Marrakech, Morocco" "Paris, France" "Siem Reap, Cambodia" "Prague, Czech Republic" "Rome, Italy" "Hanoi, Vietnam" "New York City, United States" "Ubud, Indonesia" "Barcelona, Spain" "Lisbon, Portugal" "Dubai, United Arab Emirates" "Saint Petersburg, Russia" "Bangkok, Thailand" "Amsterdam, The Netherlands" "Buenos Aires, Argentina" "Hong Kong, China" "Playa del Carmen, Mexico" "Cape Town Central, South Africa" "Tokyo, Japan" "Cusco, Peru" "Kathmandu, Nepal" "Sydney, Australia" "Budapest, Hungary"])
;; (def col (mapv vector names (get-images)))

;; (defn ->name
;;   [prefix name]
;;   (-> (str prefix "_" name)
;;       (clojure.string/replace " " "_")
;;       (clojure.string/lower-case)))

;; (defn build
;;   [col]
;;   (let [prefix "place"]
;;     (for [[name uri] col]
;;      (if uri
;;        (let [result (aws/put-image (->name prefix name) uri)]
;;          (prn [name result])
;;          [name result])
;;        [name nil]))))

;; (def places
;;   [["London, United Kingdom" "http://d24ujvixi34248.cloudfront.net/pics/place_london,_united_kingdom.jpg"] ["Istanbul, Turkey" "http://d24ujvixi34248.cloudfront.net/pics/place_istanbul,_turkey.jpg"] ["Marrakech, Morocco" "http://d24ujvixi34248.cloudfront.net/pics/place_marrakech,_morocco.jpg"] ["Paris, France" "http://d24ujvixi34248.cloudfront.net/pics/place_paris,_france.jpg"] ["Siem Reap, Cambodia" "http://d24ujvixi34248.cloudfront.net/pics/place_siem_reap,_cambodia.jpg"] ["Prague, Czech Republic" "http://d24ujvixi34248.cloudfront.net/pics/place_prague,_czech_republic.jpg"] ["Rome, Italy" "http://d24ujvixi34248.cloudfront.net/pics/place_rome,_italy.jpg"] ["Hanoi, Vietnam" "http://d24ujvixi34248.cloudfront.net/pics/place_hanoi,_vietnam.jpg"] ["New York City, United States" "http://d24ujvixi34248.cloudfront.net/pics/place_new_york_city,_united_states.jpg"] ["Ubud, Indonesia" "http://d24ujvixi34248.cloudfront.net/pics/place_ubud,_indonesia.jpg"] ["Barcelona, Spain" "http://d24ujvixi34248.cloudfront.net/pics/place_barcelona,_spain.jpg"] ["Lisbon, Portugal" "http://d24ujvixi34248.cloudfront.net/pics/place_lisbon,_portugal.jpg"] ["Dubai, United Arab Emirates" "http://d24ujvixi34248.cloudfront.net/pics/place_dubai,_united_arab_emirates.jpg"] ["Saint Petersburg, Russia" "http://d24ujvixi34248.cloudfront.net/pics/place_saint_petersburg,_russia.jpg"] ["Bangkok, Thailand" "http://d24ujvixi34248.cloudfront.net/pics/place_bangkok,_thailand.jpg"] ["Amsterdam, The Netherlands" "http://d24ujvixi34248.cloudfront.net/pics/place_amsterdam,_the_netherlands.jpg"] ["Buenos Aires, Argentina" "http://d24ujvixi34248.cloudfront.net/pics/place_buenos_aires,_argentina.jpg"] ["Hong Kong, China" "http://d24ujvixi34248.cloudfront.net/pics/place_hong_kong,_china.jpg"] ["Playa del Carmen, Mexico" "http://d24ujvixi34248.cloudfront.net/pics/place_playa_del_carmen,_mexico.jpg"] ["Cape Town Central, South Africa" "http://d24ujvixi34248.cloudfront.net/pics/place_cape_town_central,_south_africa.jpg"] ["Tokyo, Japan" "http://d24ujvixi34248.cloudfront.net/pics/place_tokyo,_japan.jpg"] ["Cusco, Peru" "http://d24ujvixi34248.cloudfront.net/pics/place_cusco,_peru.jpg"] ["Kathmandu, Nepal" "http://d24ujvixi34248.cloudfront.net/pics/place_kathmandu,_nepal.jpg"] ["Sydney, Australia" "http://d24ujvixi34248.cloudfront.net/pics/place_sydney,_australia.jpg"] ["Budapest, Hungary" "http://d24ujvixi34248.cloudfront.net/pics/place_budapest,_hungary.jpg"]])

;; (let [user-id #uuid "10000000-3c59-4887-995b-cf275db86343"]
;;   (doseq [city places]
;;     (if (c/exists? default-db (first city))
;;       (do
;;         (prn (first city) " exists.")
;;         (j/update! default-db "channels"
;;                   {:picture (second city)}
;;                   ["name = ?" (first city)]))
;;       (do
;;         (prn (first city) " not exists.")
;;         (prn (-> city
;;                  (merge
;;                   {:user_id user-id
;;                    :type "place"})))
;;         (when city
;;           (c/create default-db
;;                     {:name (first city)
;;                      :picture (second city)
;;                      :user_id user-id
;;                      :type "place"})))
;;       )))

;; (vec
;;  (distinct
;;   (concat
;;    (vec (for [city places]
;;           (first (j/query default-db ["select * from channels where name = ?" (first city)]))))

;;    (vec (j/query default-db ["select * from channels where type = 'place' order by created_at asc limit 300"])))))
