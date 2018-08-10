(ns api.schema.coerce
  (:require [schema.core :as s]
            [api.schemas :as as]
            [clj-time.coerce :as coerce]
            [hiccup.util :refer [escape-html]]
            [api.util :refer [->long ->double mobile-display mobile-request?]]))

(defonce ^:private request-non-escape-rules
  {:arts :description})

;; (defn escape-if-match
;;   [request x]
;;   (let [{:keys [uri body]} request
;;         [_ e] (re-find #"/v[\d]+/(\w+)" uri)
;;         e (keyword e)]
;;     (if-let [k (get request-non-escape-rules e)]
;;       (if (and (string? x) (= (get body k) x))
;;         x
;;         (escape-html x))
;;       (escape-html x))))

(def input-coercer
  (fn [schema]
    (fn [request x]
      (cond
        (contains? #{"null" "nil" ""} x)
        (if (= java.lang.String schema) "" nil)

        (= 'Int
           (s/explain schema))
        (->long x)

        (= java.util.UUID schema)
        (java.util.UUID/fromString x)

        (= java.lang.Number
           (s/explain schema))
        (->double x)

        (= java.lang.String schema)
        ;; escape html chars
        x
        ;; (escape-if-match request x)

        (= java.lang.Boolean
           schema)
        (if (or (true? x) (= x "true")) true false)

        (= java.util.Date
           schema)
        (-> x
            coerce/from-string
            coerce/to-sql-time)

        (= java.sql.Date
           schema)
        (-> x
            coerce/from-string
            coerce/to-sql-date)

        (= java.sql.Timestamp
           schema)
        (-> x
            coerce/from-string
            coerce/to-sql-time)

        :else
        x))))

(def output-coercer
  (fn [schema]
    (fn [request x]
      x)))
