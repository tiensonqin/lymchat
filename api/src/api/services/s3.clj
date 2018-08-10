(ns api.services.s3
  (:use [amazonica.aws.s3]
        [amazonica.aws.s3transfer])
  (:require [clojure.java.io :as io]
            [amazonica.core :as core]
            [environ-plus.core :refer [env]]
            [api.util :refer [development?]]
            [byte-streams :as bs]
            [taoensso.timbre :as t]))

(defn copy-uri-to-file [uri file]
  (with-open [in (clojure.java.io/input-stream uri)
              out (clojure.java.io/output-stream file)]
    (clojure.java.io/copy in out)))

(defn put-image
  [name uri]
  (try
    (let [tmp-path (str "/tmp/" name ".jpg")
         name (if (development?) (str "developments/" name) name)
         {:keys [accessKey secretKey region]} (:s3-options (:xxxxx env))]
     (copy-uri-to-file uri tmp-path)
     (let [file (io/file tmp-path)]
       (core/with-credential [accessKey secretKey region]
         (put-object :bucket-name "lymchat"
                     :key (format "pics/%s.jpg" name)
                     :file file))))
    (catch Exception e
      (t/error e))))
