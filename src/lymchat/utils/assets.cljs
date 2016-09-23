(ns lymchat.utils.assets
  (:require-macros [cljs.core.async.macros :refer [go]])
  (:require [lymchat.utils.module :as m]
            [cljs.core.async :refer [<!]]))

(defn- cache-images
  [images]
  (go
    (doseq [image images]
     (when image
       (-> (.fromModule m/Asset image)
           (.downloadAsync))))))

(defn- cache-fonts
  [fonts]
  (go
    (doseq [font fonts]
     (when font
       (.loadAsync m/Font font)))))

(defn cache-assets
  [images fonts cb]
  (go
    (doseq [c [(cache-images (clj->js images)) (cache-fonts (clj->js fonts))]]
      (<! c))
    (if cb (cb))))
