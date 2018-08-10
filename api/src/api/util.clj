(ns api.util
  (require [clojure.java.io :refer [resource]]
           [clojure.data.codec.base64 :as b64]
           [environ-plus.core :refer [env]]
           [clj-time.coerce :refer [to-long]]
           [clj-time.core :refer [now]]
           [taoensso.carmine :as car]
           [api.flake.core :as flake]
           [api.flake.utils :as fu]
           [clojure.string :as str])
  (import [java.security MessageDigest]
          [java.math BigInteger]
          [java.util UUID]))

(defmacro wcar*
  [conn & body]
  `(car/wcar ~conn ~@body))

(defn timestamp
  "Return timestamp."
  []
  (System/currentTimeMillis))

(defn epoch-minute
  []
  (-> (timestamp)
      (quot 1000)
      (quot 60)))

(defn str-int?
  [x]
  (and
   (some? x)
   (or (integer? x)
       (some? (re-find #"^\d+$" x)))))

(defn ->long
  [x]
  (if (string? x) (Long/parseLong x) x))

(defn ->double
  [x]
  (if (string? x) (Double/parseDouble x) x))

(defn load-resource
  "Load edn from resources."
  [file]
  (-> file
      resource
      slurp
      read-string))

(def doc {:messages (load-resource "lang/zh_cn/errors.edn")
          :validation (load-resource "lang/zh_cn/validation.edn")
          :credentials (load-resource "config/credentials.edn")})

(defn uuid
  "Generate uuid."
  []
  (str (UUID/randomUUID)))

(defn token
  []
  (str/replace (uuid) "-" ""))

(defn md5
  [s]
  (let [algorithm (MessageDigest/getInstance "MD5")
        size (* 2 (.getDigestLength algorithm))
        raw (.digest algorithm (.getBytes s))
        sig (.toString (BigInteger. 1 raw) 16)
        padding (apply str (repeat (- size (count sig)) "0"))]
    (str padding sig)))

(defn base64-encode
  [s]
  (-> (.getBytes s "UTF-8")
      b64/encode
      (String.)))

(defn extension
  "Get file extension."
  [file-name]
  (if-let [i (.lastIndexOf file-name ".")]
    (subs file-name i)))

(defn cdn-prefix
  "Get image cdn's prefix."
  ([suffix]
   (if (re-find #"^http" suffix)
     suffix
     (str (get-in env [:upyun :prefix]) suffix)))
  ([entity key]
   (if (and (key entity) (not= "" (key entity)))
     (update-in entity [key] cdn-prefix)
     entity)))

;; (defn path
;;   "Get relative uri by handler and params."
;;   [handler & args]
;;   (apply (partial path-for routes handler) args))

(defn abs-path
  "Like path, but absolutely."
  [handler & args]
  (apply str (:base-uri env) "/" (name handler) args))

;; (defn- normalize-routes
;;   [routes handlers]
;;   (reduce-kv (fn [m k v]
;;                (assoc m k
;;                       (if (and (keyword? v) (contains? handlers v))
;;                         (v handlers)
;;                         (normalize-routes v handlers))
;;                       ))
;;              {} routes))

;; (defn normalize
;;   "Since we separate handlers from routes, we need to glue both together."
;;   [[k v] handlers]
;;   [k (normalize-routes v handlers)])

(defn submap?
  "True if every key and value in sub is present and = in m"
  [sub m]
  (every? (fn [[k v]]
            (and (contains? m k)
                 (= (get m k) v))) (seq sub)))

(defn app-auth?
  [app-key app-secret]
  (some #(submap? {:key app-key :secret app-secret}
                  %)
        (:credentials doc)))

(defn get-platform-by-app-key
  [app-key]
  (some->> (:credentials doc)
           (filter #(= app-key (:key %)))
           first
           (#(select-keys % [:platform :mobile?]))))

(defn mobile?-by-app-key
  [app-key]
  (some->> (:credentials doc)
           (filter #(= app-key (:key %)))
           first
           :mobile?))

(defn app-key-exists?
  [app-key]
  (some #(= app-key (:key %)) (:credentials doc)))

(defn strip-id
  [x]
  (keyword (str/replace (name x) "_id" "")))

(defn vec->map
  [col field]
  (into {}
        (mapcat (fn [x] (assoc {} (field x)
                              (dissoc x field)))
                col)))

(defn exists-check?
  [result]
  (-> result
      first
      :exists))

(defn parse-template [text m]
  (str/replace text
               #"\{\{\[?[\w-: ]+\]?\}\}"
               (fn [groups]
                 (let [k (subs groups
                               2
                               (dec (dec (.length groups))))]
                   (if (re-find #"\[" k)
                     (let [k (read-string k)]
                       (get-in m k))
                     (get m (keyword k)))))))

(defn production?
  []
  (= :production (:environment env)))

(defn stage?
  []
  (= :stage (:environment env)))

(defn test?
  []
  (= :test (:environment env)))

(defn ci?
  []
  (= :ci (:environment env)))

(defn development?
  []
  (= :development (:environment env)))

(defn prod-or-stage?
  []
  (contains? #{:production :stage} (:environment env)))

(defn ci-or-test?
  []
  (contains? #{:ci :test} (:environment env)))

(defn uri-query-params
  [uri params]
  (if-let [params (some->> (map (fn [[k v]] (when (and k v)
                                             (str (name k) "=" v))) params)
                           (remove nil?)
                           (seq)
                           (clojure.string/join "&"))]
    (str uri "?" params)
    uri))

(defmacro with-timeout [millis & body]
  `(let [future# (future ~@body)]
     (try
       (.get future# ~millis java.util.concurrent.TimeUnit/MILLISECONDS)
       (catch java.util.concurrent.TimeoutException x#
         (do
           (future-cancel future#)
           nil)))))

(defmacro doseq-indexed
  "loops over a set of values, binding index-sym to the 0-based index of each value"
  ([[val-sym values index-sym] & code]
   `(loop [vals# (seq ~values)
           ~index-sym (long 0)]
      (if vals#
        (let [~val-sym (first vals#)]
          ~@code
          (recur (next vals#) (inc ~index-sym)))
        nil))))


(defn ^String as-str
  "Converts its arguments into a string using to-str."
  [& xs]
  (apply str xs))

(defn escape-html
  "Change special characters into HTML character entities."
  [text]
  (.. ^String (as-str text)
      (replace "&"  "&amp;")
      (replace "<"  "&lt;")
      (replace ">"  "&gt;")
      (replace "\"" "&quot;")))

(defn un-escape-html
  "Change HTML character entities into special characters."
  [text]
  (.. ^String text
      (replace "&amp;" "&")
      (replace "&lt;" "<")
      (replace "&gt;" ">")
      (replace "&quot;" "\"")
      (replace "&#39;" "'")
      (replace "&apos;" "'")))

(defn strip-html [html]
  (.trim (.replaceAll html "<[^<]+>" "\n")))

(defn mobile-display
  [text]
  (when text ((comp un-escape-html strip-html) text)))

(defn mobile-request?
  [request]
  (true? (get-in request [:custom :mobile?])))

(defn flake-id
  []
  (flake/generate!))

(defn flake-id->str
  []
  (fu/base62-encode (flake-id)))

(defn get-avatar
  [avatar]
  (let [type (cond
               (re-find #"google" avatar)
               :google

               (re-find #"facebook" avatar)
               :facebook

               :else
               :s3)]
    (cond
      (= :google type)
      (str/replace avatar "/s120/" "/s360/")

      (= :facebook type)
      (some-> avatar
              (str/replace "http" "https")
              (str/replace "type=large" (str "width=" 360 "&height=" 360)))

      :else
      avatar)))

(defn get-cdn-path
  [name]
  (str "http://d24ujvixi34248.cloudfront.net/" (format "pics/%s.jpg" name)))

(defn jpeg?
  [uri]
  (with-open [in (clojure.java.io/input-stream uri)]
    (and
     (= 255 (.read in))
     (= 216 (.read in))
     (= 255 (.read in))
     (= 224 (.read in)))))

(defn png?
  [uri]
  (with-open [in (clojure.java.io/input-stream uri)]
    (and
     (= 137 (.read in))
     (= 80 (.read in))
     (= 78 (.read in))
     (= 71 (.read in)))))
