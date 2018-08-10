(ns facebook-locales
  (:require [clojure.xml :as xml]))

(defn get-locale-lang
  [c]
  (let [c (:content c)]
    [(keyword (first (:content (second (:content (first (:content (first (:content (second c))))))))))
    (first (:content (first c)))]))

(def locales
  (->> (xml/parse "https://www.facebook.com/translations/FacebookLocales.xml")
       :content
       (map get-locale-lang)
       (into {})))
