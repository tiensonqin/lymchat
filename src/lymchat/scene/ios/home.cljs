(ns lymchat.scene.ios.home
  (:require-macros [cljs.core.async.macros :refer [go]])
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch dispatch-sync]]
            [lymchat.utils.module :as m]
            [lymchat.constants :as lc]
            [lymchat.utils.async :refer [promise->chan]]
            [lymchat.util :as util]
            [cljs.core.async :refer [<!]]))

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

;; TODO @withNavigation decorator, needs macro
(defn exponent-button
  []
  [m/touchable-opacity
   {:on-press #(dispatch [:nav/push {:key "exponent"}])
    :style {:flex 1
            :align-items "center"
            :justify-content "center"
            :margin-right 10
            :padding-top 1}}
   [m/image {:source (js/require "./assets/images/exponent-icon.png")
             :style {:width 21
                     :height 17}}]])

(defn refresh-control-cp
  []
  [m/view {:style {:padding 10}}
   [m/text "This screen is a vertical ScrollView, try the pull to refresh gesture to see the RefreshControl."]])

(defn activity-indicator-cp
  []
  (let [spacer [m/view {:margin-right 10}]]
    [m/view {:style {:flex-direction "row"
                     :padding 10}}
     [m/activity-indicator {:size "small"}]
     spacer
     [m/activity-indicator {:size "large"}]
     spacer
     [m/activity-indicator {:size "small" :color "#888"}]
     spacer
     [m/activity-indicator {:size "large" :color "#888"}]
     [m/activity-indicator {:size "small" :animating false :hidesWhenStopped false}]
     [m/activity-indicator {:size "large" :animating false :hidesWhenStopped false}]]))

(defn alert-cp
  []
  (letfn [(show-prompt []
            (.prompt m/AlertIOS
                     "Enter a value"
                     nil
                     (fn [text] (prn "You entered " text))))
          (show-alert []
            (.alert m/Alert
                    "Alert Title"
                    "My Alert Msg"
                    (clj->js
                     [{:text "Ask me later"
                       :onPress (fn [] (prn "Ask me later pressed"))}
                      {:text "Cancel"
                       :onPress (fn [] (prn "Cancel Pressed"))
                       :style "cancel"}
                      {:text "Ok"
                       :onPress (fn [] (prn "Ok pressed"))}])))]
    [m/view {:style {:flex-direction "row"
                     :padding 10}}
     [button show-prompt
      "Prompt for a value"]
     [button show-alert
      "Give me some options"]]))

(defn horizontal-scrollview-cp []
  (let [image-style {:width (:width lc/layouts)
                     :height (/ (:height lc/layouts) 2)}
        image-cp (fn [source]
                   [m/image {:source source
                             :style image-style
                             :resizeMode "cover"}])]
    [m/scroll-view
     {:pagingEnabled true
      :directionalLockEnabled true
      :horizontal true}
     [image-cp (js/require "./assets/images/example1.jpg")]
     [image-cp (js/require "./assets/images/example2.jpg")]
     [image-cp (js/require "./assets/images/example3.jpg")]]))

(defn image-picker-cp []
  (letfn [(show-camera []
            (go
              (let [result (-> (.launchCameraAsync m/ImagePicker #js {})
                               (promise->chan)
                               (<!))]
                (prn {:result result}))))
          (show-photos []
            (go
              (let [result (-> (.launchImageLibraryAsync m/ImagePicker #js {})
                               (promise->chan)
                               (<!))]
                (prn {:result result}))))]
    [m/view {:style {:flex-direction "row"
                     :padding 10}}
     [button show-camera "Open camera"]
     [button show-photos "Open photos"]]))

(defn picker-cp []
  (let [language (r/atom "js")]
    (fn []
      [m/picker
       {:selectedValue @language
        :onValueChange (fn [l] (reset! language l))}
       [m/picker-item {:label "Java" :value "java"}]
       [m/picker-item {:label "JavaScript" :value "js"}]
       [m/picker-item {:label "Objective C" :value "objc"}]
       [m/picker-item {:label "Swift" :value "swift"}]])))

(defn progress-loop
  [progress]
  (js/setTimeout
   (fn []
     (reset! progress
             (if (= 1 @progress)
               0
               (min 1 (+ 0.01 @progress))))
     (progress-loop progress))
   (* 2 17)))

(defn progress-view-example-cp [initial-progress tint-color]
  (let [progress (r/atom initial-progress)]

    (r/create-class
     {:component-did-mount (fn []
                             (progress-loop progress))

      :reagent-render
      (fn []
        [m/progress-view-ios {:style {:margin-top 20}
                              :progressTintColor tint-color
                              :progress @progress}])})))

(defn progress-view-cp []
  [m/view {:style {:padding 10
                   :padding-bottom 30}}
   [progress-view-example-cp 0 nil]
   [progress-view-example-cp 0.4 "red"]
   [progress-view-example-cp 0.6 "orange"]
   [progress-view-example-cp 0.8 "yellow"]])

(defn slider-cp []
  (let [value (r/atom 0)]
    (fn []
      [m/view {:style {:marginBottom 10}}
       [m/view {:style {:padding 10}}
        [m/text {:style {:color (if (zero? @value) "rgba(0,0,0,0.3)" "rgba(0,0,0,0.9)")
                         :margin-bottom -2}}
         (js/Math.abs (.toFixed @value 3))]]
       [m/slider {:onValueChange (fn [v]
                                   (reset! value v))}]])))

(defn status-bar-cp []
  (letfn [(random-animation []
            (if (> (js/Math.random) 0.5) "slide" "fade"))
          (hide [] (.setHidden m/StatusBar true (random-animation)))
          (show [] (.setHidden m/StatusBar false (random-animation)))]
    [m/view {:style {:flex-direction "row"
                     :padding 10}}
     [button hide "Hide"]
     [button show "Show"]]))

(defn switch-cp []
  (let [true-switch-on? (r/atom true)
        false-switch-on? (r/atom false)]
    (fn []
      [m/view {:style {:flex-direction "row"
                       :padding 10}}
       [m/switch {:on-value-change (fn [value] (reset! false-switch-on? value))
                  :value @false-switch-on?
                  :style {:margin-right 10}}]
       [m/switch {:on-value-change (fn [value] (reset! true-switch-on? value))
                  :value @true-switch-on?}]])))

(defn text-cp []
  (let [link-style {:color lc/tintColor
                    :marginVertical 3}]
    [m/view {:style {:padding 10}}
     [m/text "All text in React Native on iOS uses the native text component and supports a bunch of useful properties."]
     [m/text {:style link-style
              :on-press (fn [] (m/Alert.alert "Pressed!"))}
      "Press on this!"]
     [m/text {:numberOfLines 1
              :ellipsizeMode "tail"}
      "It's easy to limit the number of lines that some text can span and ellipsize it"]]))

(defn textinput-cp []
  (let [single-line-value (r/atom "")
        secure-text-value (r/atom "")]
    (fn []
      [m/view {:padding 10}
       [m/text-input
        {:placeholder "A single line text input"
         :onChangeText #(reset! single-line-value %)
         :style (merge
                 {:margin-bottom 10}
                 (:text-input lc/styles))
         :value @single-line-value}]

       [m/text-input
        {:placeholder "A secure text field"
         :keyboardAppearance "dark"
         :onChangeText #(reset! secure-text-value %)
         :secureTextEntry true
         :value @secure-text-value
         :style (:text-input lc/styles)}]])))

(defn touchables-cp []
  (let [text-cp (fn [value]
                  [m/text {:style {:color "#fff"}} value])]
    [m/view {:style {:padding 10
                     :flex-direction "row"}}
     [m/touchable-highlight {:underlayColor "rgba(1, 1, 255, 0.9)"
                             :style (:ios-button lc/styles)
                             :on-press (fn [] (prn "highlight clicked"))}
      (text-cp "Highlight!")]

     [m/touchable-opacity {:style (:ios-button lc/styles)
                           :on-press (fn [] (prn "opacity clicked"))}
      (text-cp "Opacity!")]

     [m/touchable-bounce {:style (:ios-button lc/styles)
                          :on-press (fn [] (prn "bounce clicked"))}
      (text-cp "Bounce!")]]))

(defn webview-cp []
  [m/webview {:style {:width (:width lc/layouts)
                      :height 250}
              :source {:html
                       "<h2>You can always use a WebView if you need to!</h2>
          <p>
            <h4>But don't the other components above seem like better building blocks for most of your UI?</h4>
            <input type=\"text\" placeholder=\"Disagree? why?\"></input>
            <input type=\"submit\">
          </p>
          <p>
            <a href=\"https://www.getexponent.com\">getexponent.com</a>
          </p>"}}])

(defn show-action-sheet
  []
  (.showActionSheetWithOptions
   m/ActionSheetIOS
   (clj->js {:options ["Option 0" "Option 1" "Delete" "Cancel"]
             :cancelButtonIndex 3
             :destructiveButtonIndex 2})
   (fn [i] (prn i))))

(defn show-share-sheet
  []
  (.showShareActionSheetWithOptions
   m/ActionSheetIOS
   (clj->js {:url "https://getexponent.com"
             :message "message to go with the shared url"
             :subject "a subject to go in the email heading"})
   (fn [error] (.alert m/Alert error))
   (fn [success method]
     (if success
       (.alert m/Alert (str "Shared via " method))))))

(defn action-sheet-cp []
  [m/view {:style {:flex-direction "row"
                   :padding 10}}
   [button show-action-sheet "Action sheet"]
   [button show-share-sheet "Share sheet"]])

(defn date-picker-cp []
  (let [state (r/atom {:date (js/Date.)
                       :timeZoneOffsetInHours (* -1 (/ (.getTimezoneOffset (js/Date.)) 60))})]
    (fn []
      [m/date-picker-ios {:date (:date @state)
                          :mode "datetime"
                          :timeZoneOffsetInMinutes (:timeZoneOffsetInMinutes @state)
                          :onDateChange (fn [date] (swap! state (fn [s] (assoc s :date date))))}])))

(defn map-view-cp []
  [m/map-view {:style {:flex 1
                       :height 200}
               :showsUserLocation true}])

(defn segmented-control-cp []
  (let [selected (r/atom 0)]
    (fn []
      (let [tint-color (case @selected
                         0 "black"
                         1 lc/tintColor
                         2 "green"
                         3 "purple")]
        [m/segmented-control-ios {:values #js ["One", "Two", "Three", "Four"]
                                  :tintColor tint-color
                                  :selectedIndex @selected
                                  :onChange (fn [e] (reset! selected (aget e "nativeEvent" "selectedSegmentIndex")))}]))))

(defn home-scene
  []
  (let [refreshing? (r/atom false)
        ds (m/clone-ds (m/->ds)
                       (array-map "Vertical ScrollView, RefreshControl" [refresh-control-cp]
                                  "ActionSheetIOS" [action-sheet-cp]
                                  "ActivityIndicator" [activity-indicator-cp]
                                  "Alert" [alert-cp]
                                  "DatePickerIos" [date-picker-cp]
                                  "Horizontal ScrollView" [horizontal-scrollview-cp]
                                  "ImagePicker" [image-picker-cp]
                                  "MapView" [map-view-cp]
                                  "Picker" [picker-cp]
                                  "ProgressView" [progress-view-cp]
                                  "SegmentedControl" [segmented-control-cp]
                                  "Slider" [slider-cp]
                                  "StatusBar" [status-bar-cp]
                                  "Switch" [switch-cp]
                                  "Text" [text-cp]
                                  "TextInput" [textinput-cp]
                                  "Touchables" [touchables-cp]
                                  "WebView" [webview-cp]))]
    (let [c (r/create-class
             {:reagent-render
              (fn []
                (let [this (r/current-component)
                      nav (r/props this)
                      container-style (get-in lc/styles [:home :container])]
                  (dispatch [:nav/set-nav nav])

                  [m/list-view
                   {:keyboardShouldPersistTaps true
                    :keyboardDismissMode "on-drag"
                    :refreshControl (m/refresh @refreshing?
                                               (fn []
                                                 (prn "refreshing...")))
                    :style {:flex 1
                            :margin-top 60}
                    :contentContainerStyle container-style
                    :dataSource ds
                    :renderRow (fn [row-fn]
                                 (r/as-element [row-fn]))
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
             {:navigationBar {:title "Native components Ios"
                              :translucent true
                              :renderRight (fn [] (r/as-element [exponent-button]))}}))
      c)))
