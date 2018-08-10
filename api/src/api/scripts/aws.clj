(ns api.scripts.aws
  (:use [amazonica.aws.s3]
        [amazonica.aws.s3transfer])
  (:require [clojure.java.io :as io]
            [amazonica.core :as core]
            [environ-plus.core :refer [env]]
            [api.util :refer [jpeg? png?]])
  (:import [java.nio.file Files]
           [java.nio.file Path]))

(defn copy-uri-to-file [uri file]
  (with-open [in (clojure.java.io/input-stream uri)
              out (clojure.java.io/output-stream file)]
    (clojure.java.io/copy in out)))

(defn put-image
  [name uri]
  (copy-uri-to-file uri "/tmp/test.jpg")
  (let [{:keys [accessKey secretKey region]} (:s3-options (:xxxxx env))]
    (core/with-credential [accessKey secretKey region]
     (put-object :bucket-name "lymchat"
                 :key (format "pics/%s.jpg" name)
                 :file (io/file "/tmp/test.jpg")))
    (str "http://d24ujvixi34248.cloudfront.net/" (format "pics/%s.jpg" name))))
