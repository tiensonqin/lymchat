(ns api.schema.human
  (:require [schema
             [core :as s]
             [utils :as utils]])
  (:import schema.utils.ValidationError))

;; copy from https://github.com/cddr/integrity

;; ### Support for internationalization

;; (def ^{:private true}
;;   dictionary
;;   "`dictionary` defines translations so that error messages in multiple
;;   languages can be easily supported"
;;   {:it           "it"
;;    :not-eq       "is not eq with"
;;    :not-one-of   "is not one of"
;;    :is-not       "is not"
;;    :and          "and"
;;    :fails-all    "fails all of the following:-"
;;    :is-not-a     "is not a"})

(def type-dictionary
  {s/Num "数字"
   s/Int "整数"})

(def ^{:private true}
  dictionary
  "`dictionary` defines translations so that error messages in multiple
  languages can be easily supported"
  {:it           "这个"
   :not-eq       "不等于"
   :not-one-of   "不包含在"
   :is-not       "不是"
   :and          "and"
   :fails-all    "fails all of the following:-"
   :is-not-a     "不是"})

(defn- tval
  "`tval` returns the translation for the specified language independent key"
  [key]
  (dictionary key))

(defn- show-val
  "`show-val` returns the failing input value, or if that value has
  been displayed already, the 'third-person singular pronoun'"
  [err parent]
  (if (nil? parent)
    (:value err)
    (tval :it)))

(defn- humanize
  "`humanize` takes a value and returns a human readable representation
  of that value"
  [v]
  (if (symbol? v)
    (clojure.string/replace (str (name v)) "?" "")
    v))

(defn- error [check-result]
  {:explain (utils/.-fail-explanation check-result)
   :schema (utils/.-schema check-result)
   :value (utils/.-value check-result)
   :expectation @(utils/.-expectation-delay check-result)
   :fail-explanation (utils/.-fail-explanation check-result)})

(defprotocol ValidationTranslator
  "A `ValidationTranslator` knows how to translate a `schema.util.ValidationError`
into a message intended for an end-user"
  (translate [schema error parent]
             "Uses `schema` to help translates the `error` into an end-user error message
TODO: refactor to avoid ['control coupling'](http://robots.thoughtbot.com/types-of-coupling)"))

(extend schema.core.EqSchema
  ValidationTranslator
  {:translate (fn [schema e parent]
                (with-out-str
                  (print (show-val e parent) (tval :not-eq)
                         (second (:expectation e)))))})

(extend schema.core.EnumSchema
  ValidationTranslator
  {:translate (fn [schema error parent]
                (with-out-str
                  (print (show-val error parent) (tval :not-one-of) "")
                  (print (.vs (:schema error)))))})

(defn- pred-expectation [expectation]
  (let [[pred val] expectation]
    (cond
      (symbol? pred) (list (humanize pred))
      (seq pred) (let [[op & args] pred]
                   (conj (interpose (tval :and) (map humanize args))
                         (humanize op))))))

(extend schema.core.Predicate
  ValidationTranslator
  {:translate (fn [schema error parent]
                (str (show-val error parent)
                     (tval :is-not)
                     (if-let [v (get type-dictionary schema)]
                       v
                       (pred-expectation (:expectation error)))))})

(extend schema.core.Either
  ValidationTranslator
  {:translate (fn [schema e p]
                (with-out-str
                  (println (show-val e p) (tval :fails-all))
                  (doseq [exp (map (fn [sub-schema]
                                     (let [val (:value e)
                                           check-result (s/check sub-schema val)]
                                       (if check-result
                                         (translate (:schema (error check-result))
                                                    (error check-result)
                                                    e))))
                                (.-schemas schema))]
                    (println " " exp))))})

(extend java.lang.Class
  ValidationTranslator
  {:translate (fn [schema error parent]
                (str (show-val error parent)
                     (tval :is-not-a)
                     (if-let [v (get type-dictionary schema)]
                       v
                       (:schema error))))})

(defn human-explain [check-result]
  (cond
    (nil? check-result) nil

    (instance? ValidationError check-result)
    (let [error (error check-result)]
      (translate (:schema error) error nil))

    (map? check-result) (into {} (for [[k v] check-result]
                                   [k (human-explain v)]))))
