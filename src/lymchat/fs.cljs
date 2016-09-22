(ns lymchat.fs)

(def fs (js/require "react-native-fs"))

(def documents-path (.-DocumentDirectoryPath fs))

(defn path
  [file-path]
  (str documents-path file-path))

(defn get-info
  []
  (->
   (.getFSInfo fs)
   (.then (fn [result]
            (prn result)))
   (.catch (fn [err]
             (prn err)))))

(defn list-files
  ([]
   (list-files nil))
  ([k]
   (->
    (if (= :verbose k)
      (.readDir fs documents-path)
      (.readdir fs documents-path))
    (.then (fn [result]
             (prn (js->clj result :keywordize-keys true))))
    (.catch (fn [err]
              (prn err))))))

(defn download
  [url path success-cb error-cb]
  (->
   (.downloadFile fs #js {:fromUrl url
                          :toFile path})
   (.then (fn [result]
            (if (= 200 (aget result "statusCode"))
              (success-cb)
              (error-cb))))
   (.catch (fn [err]
             (prn err)))))

(defn delete
  [path]
  (->
   (.unlink fs path)
   (.then (fn [result]
            (prn result)))
   (.catch (fn [err]
             (prn err)))))

(defn file-exists?
  [path true-cb false-cb]
  (->
   (.exists fs path)
   (.then (fn [result]
            (if result
              (true-cb)
              (false-cb))))
   (.catch (fn [err]
             (prn err)))))

;; ctime mtime isFile
(defn stat
  [path]
  (->
   (.stat fs path)
   (.then (fn [result]
            (prn result)))
   (.catch (fn [err]
             (prn err)))))

(defn copy
  [from to]
  (->
   (.copyFile fs from to)
   (.then (fn [result]
            (prn result)))
   (.catch (fn [err]
             (prn err)))))
