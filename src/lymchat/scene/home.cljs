(ns lymchat.scene.home
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
    :style (:exponent-button lc/styles)}
   [m/image {:source (js/require "./assets/images/exponent-icon.png")
             :style {:width 21
                     :height 17}}]])

(defn drawer-layout-cp
  []
  [m/view {:style {:padding 10}}
   [m/text
    "Swipe from the left of the screen to see the drawer."]])

(defn navigation-view-cp
  []
  [m/view {:style {:flex 1
                   :background-color "#fff"
                   :align-items "center"
                   :justify-content "center"}}
   [m/text "DrawerLayoutAndroid"]])

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
     [m/activity-indicator {:size "large" :color "#888"}]]))

(defn alert-cp
  []
  (letfn [(show-alert []
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
     [button show-alert
      "Give me some options"]]))

(defn date-picker-cp []
  (letfn [(show-date-picker []
            (try
              (go
                (let [{:keys [action year month day]}
                      (-> (.open m/DatePickerAndroid
                                 #js {:date (js/Date. 2020 4 25)})
                          (promise->chan)
                          (<!)
                          (util/keywordize))]
                  (when (not= action m/DatePickerAndroid.dismissedAction)
                    ;; Selected year, month (0-11), day
                    (prn {:year year
                          :month month
                          :day day}))))

              (catch js/Error e
                (.warn js/console "Cannot open date picker" (aget e "message")))))]
    [m/view {:style {:flex-direction "row"
                     :padding 10}}
     [button show-date-picker "Show date picker"]]))

(defn time-picker-cp []
  (letfn [(show-time-picker []
            (try
              (go
                (let [{:keys [action hour minute]}
                      (-> (.open m/TimePickerAndroid
                                 #js {:hour 14
                                      :minute 0
                                      ;; Will display as '2 PM'
                                      :is24Hour false})
                          (promise->chan)
                          (<!)
                          (util/keywordize))]
                  (when (not= action m/TimePickerAndroid.dismissedAction)
                    (prn {:hour hour
                          :minute minute}))))

              (catch js/Error e
                (.warn js/console "Cannot open time picker" (aget e "message")))))]
    [m/view {:style {:flex-direction "row"
                     :padding 10}}
     [button show-time-picker "Show time picker"]]))

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

(defn progress-bar-example-cp [initial-progress tint-color]
  (let [progress (r/atom initial-progress)]

    (r/create-class
     {:component-did-mount (fn []
                             (progress-loop progress))

      :reagent-render
      (fn []
        [m/progress-bar-android {:styleAttr "Horizontal"
                                 :style {:margin-top 20}
                                 :color tint-color
                                 :progress @progress}])})))

(defn progress-bar-cp []
  [m/view {:style {:padding 10
                   :padding-bottom 30}}
   [progress-bar-example-cp 0 nil]
   [progress-bar-example-cp 0.4 "red"]
   [progress-bar-example-cp 0.6 "orange"]
   [progress-bar-example-cp 0.8 "yellow"]])

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
    [m/view {:style {:flex 1}}
     [m/view {:style {:padding 10
                      :flex-direction "row"
                      :flex 1}}
      [m/touchable-highlight {:underlayColor "rgba(1, 1, 255, 0.9)"
                              :style (:button lc/styles)
                              :on-press (fn [] (prn "highlight clicked"))}
       (text-cp "Highlight!")]

      [m/touchable-opacity {:style (:button lc/styles)
                            :on-press (fn [] (prn "opacity clicked"))}
       (text-cp "Opacity!")]]

     [m/view {:style {:padding 10
                      :flex-direction "row"
                      :flex 1}}
      [m/touchable-native-feedback {:background (m/TouchableNativeFeedback.Ripple "#FFF" false)
                                    :on-press (fn [] (prn "native feedback clicked"))
                                    :delayPressIn 0}
       [m/view {:style (:button lc/styles)}
        [m/text {:style {:color "#fff"}}
         "Native clicked"]]]
      [m/touchable-bounce{:style (:button lc/styles)
                          :on-press (fn [] (prn "bounch clicked"))}
       (text-cp "Bounce!")]]]))

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

(defn home-scene
  []
  (let [refreshing? (r/atom false)
        ds (m/clone-ds (m/->ds {:rowHasChanged #(not= %1 %2)
                                :sectionHeaderHasChanged #(not= %1 %2)})
                       (array-map "Vertical ScrollView, RefreshControl" [refresh-control-cp]
                                  "DrawerLayoutAndroid" [drawer-layout-cp]
                                  "ActivityIndicator" [activity-indicator-cp]
                                  "Alert" [alert-cp]
                                  "DatePickerAndroid" [date-picker-cp]
                                  "TimerPickerAndroid" [time-picker-cp]
                                  "Horizontal ScrollView" [horizontal-scrollview-cp]
                                  "ImagePicker" [image-picker-cp]
                                  "Picker" [picker-cp]
                                  "ProgressBar" [progress-bar-cp]
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

                  [m/drawer-layout-android
                   {:drawerWidth 300
                    :drawerPosition m/DrawerLayoutAndroid.positions.Left
                    :renderNavigationView (fn []
                                            (r/as-element [navigation-view-cp]))}

                   [m/list-view
                    {:keyboardShouldPersistTaps true
                     :keyboardDismissMode "on-drag"
                     :refreshControl (m/refresh @refreshing?
                                                (fn []
                                                  (prn "refreshing...")))
                     :style container-style
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
                                              [m/text section-id]]))}]]))})]
      (aset c
            "route"
            (clj->js
             {:navigationBar {:title "Native components Android"
                              :renderRight (fn [] (r/as-element [exponent-button]))}}))
      c)))
