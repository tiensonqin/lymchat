(ns lymchat.scene.exponent
  (:require-macros [cljs.core.async.macros :refer [go]])
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch dispatch-sync]]
            [lymchat.utils.module :as m]
            [lymchat.constants :as lc]
            [lymchat.utils.async :refer [promise->chan]]
            [lymchat.util :as util]
            [cljs.core.async :refer [<!]]
            [lymchat.api :as api]
            [clojure.string :as str]))

(defn button
  [on-press text]
  [m/touchable-opacity {:onPress on-press
                        :style {:paddingHorizontal 15
                                :paddingVertical 10
                                :borderRadius 3
                                :backgroundColor lc/tintColor
                                :marginRight 10}}
   [m/text {:style {:color "#fff"}}
    text]])

(defn animate-blur [opacity]
  (->
   (.timing m/Animated
            @opacity
            #js {:duration 2500
                 :toValue 1})
   (.start (fn [value]
             (->
              (.timing m/Animated
                       @opacity
                       #js {:duration 2500
                            :toValue 0})
              (.start (fn []
                        (animate-blur opacity))))))))

(defn blur-view-cp []
  (let [animated-blur-view (r/adapt-react-class
                            (.createAnimatedComponent m/Animated m/blur-view))
        opacity (atom (Animated.value. 0))]
    (r/create-class
     {:component-did-mount
      (fn []
        (animate-blur opacity))
      :reagent-render
      (fn []
        (let [uri "https://s3.amazonaws.com/exp-brand-assets/ExponentEmptyManifest_192.png"]
          [m/view {:style {:flex 1
                           :margin 30}}
           [m/view {:style {:flex 1
                            :padding 55
                            :padding-top 60}}
            [m/image {:style {:width 180
                              :height 180}
                      :source uri}
             [animated-blur-view {:tintEffect "default"
                                  :style (merge
                                          m/StyleSheet.absoluteFill
                                          {:opacity @opacity})}]]]]))})))

(defn constant-cp [name]
  [m/view {:style {:flex-direction "row"
                   :flex 1}}
   [m/text {:numberOfLines 1
            :ellipsizeMode "tail"
            :style {:flex 1}}
    [m/text {:style {:fontWeight "bold"}}
     name]
    (aget m/Constants name)]])

(defn constants-cp []
  [m/view {:style {:padding 10}}
   [constant-cp "exponentVersion"]
   [constant-cp "deviceId"]
   [constant-cp "deviceName"]
   [constant-cp "deviceYearClass"]
   [constant-cp "sessionId"]
   [constant-cp "linkingUri"]])

(defn contacts-cp []
  (let [contacts (r/atom nil)
        find-contacts-fn
        (fn []
          (go
            (some->> (m/Contacts.getContactsAsync #js [m/Contacts.EMAIL])
                     (promise->chan)
                     (<!)
                     (map (fn [contact] {:name (first (str/split (aget contact "name") #" "))
                                        :email "hidden for demo"
                                        :phone "-"}))
                     (take 5)
                     (reset! contacts))))]

    (fn []
      (if (seq @contacts)
        [m/view {:style {:padding 10}}
         [m/text (js/JSON.stringify (clj->js @contacts))]]

        [m/view {:style {:padding 10}}
         [button find-contacts-fn "Find my contacts"]]))))

(defn test-fb-login
  ([id permissions]
   (test-fb-login id permissions "web"))
  ([id permissions behavior]
   (go
     (try
       (let [{:keys [type token] :as result}
             (-> (m/exponent.Facebook.logInWithReadPermissionsAsync id (clj->js {:permissions permissions
                                                                                 :web true}))
                 (promise->chan)
                 (<!)
                 (util/keywordize))]
         (if (= type "cancel")
           (prn "cancel")
           (.alert m/Alert "Logged in!"
                          (js/JSON.stringify result)
                          (clj->js
                           [{:text "Ok!"
                             :onPress (fn []
                                        (prn {:type type
                                              :token token}))}]))))
       (catch js/Error e
         (.alert m/Alert "Error!"
                        (aget e "message")
                        (clj->js
                         [{:text "Ok!"
                           :onPress (fn [])}])))))))

(defn facebook-cp []
  (let [permissions ["public_profile", "email", "user_friends"]]
    [m/view {:style {:padding 10}}
     [button (fn [] (test-fb-login "1201211719949057" permissions))
      "Authenticate with Facebook"]]))

(defn font-cp []
  [m/view
   [m/view {:style {:paddingVertical 10
                    :paddingHorizontal 15
                    :flexDirection "row"
                    :justifyContent "space-between"}}
    [m/material-icons {:name "airplay" :size 25}]
    [m/material-icons {:name "airport-shuttle" :size 25}]
    [m/material-icons {:name "alarm" :size 25}]
    [m/material-icons {:name "alarm-add" :size 25}]
    [m/material-icons {:name "alarm-off" :size 25}]
    [m/material-icons {:name "all-inclusive" :size 25}]]
   [m/view {:style {:paddingVertical 10
                    :paddingHorizontal 15}}
    [m/text {:style (merge
                     (js->clj (m/Font.style "space-mono"))
                     {:fontSize 16})}
     "Font icons sets and other custom fonts can be loaded from the web"]]])

(defn push-notification-cp []
  (let [notification-sub (atom nil)
        handler (fn [notification]
                  (let [{:keys [origin data]} (util/keywordize notification)
                        data (if (string? data)
                               (js/JSON.parse data)
                               data)
                        text (str "Push notification "
                                  origin
                                  " with data: "
                                  (js/JSON.stringify data))]
                    (dispatch [:nav/show-local-alert
                               text
                               (:notice lc/alerts)])))
        send-fn (fn []
                  (go
                    (api/register-for-push-notifications)
                    ;; Handle notifications that come in while the app is open
                    (when-not @notification-sub
                      (reset! notification-sub
                              (.addListener
                               m/DeviceEventEmitter
                               "Exponent.notification"
                               handler)))))]
    (r/create-class
     {:component-will-unmount
      (fn []
        (when @notification-sub
          (.remove @notification-sub)
          (reset! notification-sub nil)))

      :reagent-render
      (fn []
        [m/view {:style {:padding 10}}
         [button send-fn
          "Send me a push notification!"]])})))

(defn- increment-color
  [color step]
  (let [int-color (js/parseInt (.substr color 1) 16)
        new-int-color (-> (+ int-color step)
                          (.toString 16))]
    (str "#" (apply str (repeat (- 6 (count new-int-color)) \0)) new-int-color)))

(defn linear-gradient-cp []
  (let [interval (atom nil)
        state (r/atom {:count 0
                       :color-top "#000000"
                       :color-bottom "#cccccc"})]
    (r/create-class
     {:component-did-mount
      (fn []
        (->>
         (js/setInterval
          (fn []
            (swap! state
                   (fn [s]
                     {:count (inc (:count s))
                      :color-top (increment-color (:color-top s) 1)
                      :color-bottom (increment-color (:color-bottom s) -1)})))
          20)
         (reset! interval)))

      :component-will-mount
      (fn [] (js/clearInterval @interval))

      :render
      (fn []
        (let [{:keys [color-top color-bottom]} @state]
          [m/view {:style {:flex 1
                           :align-items "center"
                           :justify-content "center"
                           :padding-vertical 10}}
           [m/linear-gradient
            {:colors [color-top color-bottom]
             :style {:width 200, :height 200}}
            [m/text {:style {:color color-top}} color-top]
            [m/text {:style {:color color-bottom}} color-bottom]]]))})))

(defn location-cp []
  (let [location (r/atom nil)
        searching? (r/atom false)
        find-location-fn
        (fn []
          (go
            (let [status (-> (m/Permissions.askAsync m/Permissions.LOCATION)
                             (promise->chan)
                             (<!)
                             (aget "status"))]
              (when (= "granted" status)
                (try
                  (reset! searching? true)
                  (let [result (-> (m/Location.getCurrentPositionAsync #js {:enableHighAccuracy false})
                                   (promise->chan)
                                   (<!))]
                    (reset! location result))

                  (finally
                    (reset! searching? false)))))))]

    (fn []
      (cond
        @searching?
        [m/view {:style {:padding 10}}
         [m/activity-indicator]]

        @location
        [m/view {:style {:padding 10}}
         [m/text (str "Latitude: " (+ (aget @location "coords" "latitude")
                                      (* 5 (js/Math.random))))]
         [m/text (str "Longitude: " (+ (aget @location "coords" "longitude")
                                       (* 5 (js/Math.random))))]]

        :else
        [m/view {:style {:padding 10}}
         [button find-location-fn "Find my location"]]))))

(defn svg-cp [])

(defn touchid-cp []
  (let [waiting (r/atom false)
        auth-fn (if (m/android?)
                  (fn []
                    (go
                      (reset! waiting true)
                      (try
                        (let [result (-> (m/NativeModules.ExponentFingerprint.authenticateAsync)
                                         (promise->chan)
                                         (<!))]
                          (if (aget result "success")
                            (.alert m/Alert "Authenticated!")
                            (.alert m/Alert "Failed to authenticate!")))
                        (finally
                          (reset! waiting false)))))
                  (fn []
                    (go
                      (let [result (-> (m/NativeModules.ExponentFingerprint.authenticateAsync "Show me your finger!")
                                       (promise->chan)
                                       (<!))]
                        (if (aget result "success")
                          (.alert m/Alert "Success!")
                          (.alert m/Alert "Cancel"))))))]
    [m/view {:style {:padding 10}}
     [button auth-fn
      (if @waiting
        "Waiting for fingerprint... "
        "Authenticate with fingerprint")]]))

(defn video-cp []
  [m/view {:style {:flex 1
                   :padding-top 30
                   :padding-left 10
                   :padding-right 10
                   :align-items "center"
                   :justify-content "center"}}
   [m/video {:source (js/require "./assets/videos/ace.mp4")
             :rate 1.0
             :volumn 1.0
             :muted false
             :resizeMode "cover"
             :repeat true
             :style {:width 300
                     :height 300}}]])

(defn exponent-scene
  []
  (let [ds (m/clone-ds (m/->ds)
                       (if (m/android?)
                         (array-map
                          "Constants" [constants-cp]
                          "Contacts" [contacts-cp]
                          "Facebook" [facebook-cp]
                          "Font" [font-cp]
                          "PushNotification" [push-notification-cp]
                          "LinearGradient" [linear-gradient-cp]
                          "Location" [location-cp]
                          "Svg" [svg-cp]
                          "TouchID" [touchid-cp]
                          "Video" [video-cp])

                         (array-map
                          "BlurView" blur-view-cp
                          "Constants" [constants-cp]
                          "Contacts" [contacts-cp]
                          "Facebook" [facebook-cp]
                          "Font" [font-cp]
                          "PushNotification" [push-notification-cp]
                          "LinearGradient" [linear-gradient-cp]
                          "Location" [location-cp]
                          "Svg" [svg-cp]
                          "TouchID" [touchid-cp]
                          "Video" [video-cp])))]
    (let [c (r/create-class
             {:reagent-render
              (fn []
                (let [this (r/current-component)
                      nav (r/props this)
                      container-style (get-in lc/styles [:home :container])]
                  (dispatch [:nav/set-nav nav])

                  [m/list-view
                   {:removeClippedSubviews false
                    :keyboardShouldPersistTaps true
                    :keyboardDismissMode "on-drag"
                    :style {:flex 1
                            :margin-top 60}
                    :contentContainerStyle container-style
                    :dataSource ds
                    :renderRow (fn [row-fn] (r/as-element [row-fn]))
                    :renderSectionHeader (fn [_ section-id]
                                           (r/as-element
                                            [m/view {:style
                                                     {:background-color "rgba(245,245,245,1)"
                                                      :paddingVertical 5
                                                      :paddingHorizontal 10}}
                                             [m/text section-id]]))}]))})]
      (aset c
            "route"
            (clj->js
             {:navigationBar {:title "Built into Exponent"
                              :translucent true}}))
      c)))
