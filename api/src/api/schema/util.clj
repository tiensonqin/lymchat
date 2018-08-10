(ns api.schema.util
  (:require [api.util :refer [strip-id]]
            [clojure.string :as str]
            [schema.core :as s]))

(defn optional
  [schema]
  (some->> schema
           (map (fn [[k v]]
                  [(s/optional-key k) v]) )
           (into {})))

(defn part
  "When schema used for update, we only need id to be required.
  Example: (part User :excludes [:id])
  (part User :only [:email :password])"
  ([schema]
   (part schema nil))
  ([schema {:keys [excludes only must] :as opts}]
   (let [ks (if only only (remove (set excludes) (keys schema)))]
     (into {}
           (map (fn [[k v]]
                  (if (or (= :id k) (contains? (set must) k))
                    [k v]
                    [(s/optional-key k) v]))
             (select-keys schema ks))))))

(defmacro without-id
  [schema]
  `(part ~schema {:excludes [:id]}))

(defn without-id-and-cu-time [schema]
  (part schema {:excludes [:id :updated_at :created_at]}))

(defn without-uid
  [schema]
  (dissoc schema :user_id))

(defn to-id
  [x]
  (-> x
      (str "_id")
      str/lower-case
      keyword))

(defmacro wrap
  [f s]
  `(let [s# ~s
         id# (to-id '~s)]
     (-> ~f
         (dissoc id#)
         (assoc (strip-id id#) (part s#))
         part)))

(defn wrap-uid
  [body user-id]
  (assoc body :user_id user-id))

(defn wrap-any
  [schema]
  (assoc schema s/Keyword s/Any))
