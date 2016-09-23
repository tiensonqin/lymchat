(ns lymchat.utils.async
  (:require-macros [cljs.core.async.macros :as async-m])
  (:require [cljs.core.async :as async]))

;; TODO replace with promesa
(defn promise->chan
  ([promise]
   (promise->chan promise nil))
  ([promise error-handler]
   (let [c (async/promise-chan)]
     (-> promise
         (.then (fn [result] (async-m/go
                              (async/>! c result))))
         (.catch (fn [error] (error-handler error))))
     c)))
