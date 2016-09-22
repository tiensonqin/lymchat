(ns lymchat.photo
  (:require [lymchat.shared.ui :refer [image-picker rns3 image-resizer alert image]]
            [lymchat.config :as config]
            [lymchat.util :refer [uuid-v4 development?]]
            [re-frame.core :refer [dispatch]]
            [re-frame.db :refer [app-db]]
            [lymchat.fs :as fs]
            [lymchat.realm :as realm]))

(defn new-photo-name
  [user-id]
  (str (uuid-v4) user-id ".jpg"))

(defn avatar-name
  [user-id]
  (str user-id ".jpg"))

(defn offline-sync-contacts-avatars
  []
  (let [contacts (cons
                  (realm/me)
                  (realm/get-contacts))
        offline-pics (realm/get-offline-pics)]
    (doseq [{:keys [id avatar]} contacts]
      (let [avatar-path (fs/path (str "/avatar_" id ".jpg"))]
        (when-not (get offline-pics id)
          (fs/download
           avatar
           avatar-path
           (fn []
             (realm/offline-pics-set id true))
           (fn []
             (realm/offline-pics-set id false))))))))

(defn resize
  ([uri cb]
   (resize uri cb 600 90))
  ([uri cb size quality]
   (let [width size
         height size
         compress-format "JPEG"
         quality 90
         rotation 0
         output-path nil]
     (-> (.createResizedImage image-resizer uri width height compress-format quality rotation output-path)
         (.then (fn [resized-uri]
                  (cb resized-uri)))
         (.catch (fn [err]
                   (prn "Resize image error:" err)))))))

(defn s3-upload
  [uri file-name success-cb]
  (let [file (clj->js {:uri uri
                       :name (if (development?)
                               (str "developments/" file-name)
                               file-name)
                       :type "image/JPEG"})
        options (clj->js (:s3-options @config/xxxxx))]
    (-> (.put rns3 file options)
        (.then (fn [response]
                 (if-not (= 201 (aget response "status"))
                   (alert "Failed to upload photo.")
                   (let [url (str "http://d24ujvixi34248.cloudfront.net/" (aget response "body" "postResponse" "key"))]
                     (dispatch [:set-uploading? false])
                     (success-cb url))))))))

(defn download-avatar
  ([id avatar]
   (download-avatar id avatar false))
  ([id avatar s3-upload?]
   (let [path (fs/path (str "/avatar_" id ".jpg"))]
     (fs/download avatar
                  path
                  (fn []
                    (realm/offline-pics-set id true)
                    ;; upload to s3
                    (when s3-upload? (s3-upload path (avatar-name id) #(dispatch [:set-avatar %]))))
                  (fn []
                    (realm/offline-pics-set id false))))))

(defn upload
  ([user-id type]
   (upload user-id type nil))
  ([user-id type channel-id]
   (.showImagePicker image-picker
                     #js {:storageOptions true}
                     (fn [response]
                       (let [original-uri (.-uri response)]
                         (cond
                           (.-didCancel response)
                           (prn "User cancelled image picker")

                           (.-error response)
                           (prn "ImagePicker Error: " (.-error response))

                           :else
                           (case type
                             :avatar
                             (resize original-uri
                                     (fn [uri]
                                       (dispatch [:set-uploading? true])

                                       (download-avatar user-id original-uri)
                                       (dispatch [:set-temp-avatar original-uri])
                                       (s3-upload uri (avatar-name user-id) #(dispatch [:set-avatar %])))
                                     1080
                                     100)

                             :message
                             (resize original-uri
                                     (fn [uri]
                                       (dispatch [:set-uploading? true])
                                       (if channel-id
                                         (dispatch [:send-channel-photo-message channel-id uri])
                                         (dispatch [:send-photo-message uri])))
                                     600
                                     100)

                             nil)))))))

;; (defn offline-avatar-cp
;;   [user-id user-avatar style]
;;   (let [current-user (:current-user @app-db)
;;         path (fs/path (str "/avatar_" user-id ".jpg"))
;;         avatar (cond
;;                  (and
;;                   (= user-id (:id current-user))
;;                   (re-find #"tmp" (:avatar current-user)))
;;                  (:avatar current-user)

;;                  (realm/pic-offline? user-id)
;;                  path

;;                  :else
;;                  (do
;;                    (download-avatar user-id user-avatar)
;;                    user-avatar))]
;;     [image {:source {:uri avatar}
;;             :style style}]))

(defn offline-avatar-cp
  [user-id user-avatar style]
  [image {:source {:uri user-avatar}
          :style style}])
