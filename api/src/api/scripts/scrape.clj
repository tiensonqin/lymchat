(ns api.scripts.scrape
  (:require [net.cgrand.enlive-html :as html]
            [api.scripts.aws :as aws]))

(defn fetch-url [url]
  (html/html-resource (java.net.URL. url)))

(defn attrs
  [node selector ks]
  (map (fn [node]
         (-> (:attrs node)
             (select-keys ks)
             (vals)
             (first)))
    (html/select node selector)))

(defn contents
  [node selector]
  (map (fn [node] (-> node
                     :content
                     (nth 1)
                     :content
                     (nth 1)
                     :content
                     first))
    (html/select node selector)))
