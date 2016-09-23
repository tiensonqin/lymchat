(ns lymchat.util)

(defn keywordize
  [obj]
  (when obj
    (js->clj obj :keywordize-keys true)))
