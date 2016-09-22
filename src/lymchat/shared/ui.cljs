(ns lymchat.shared.ui
  (:require [reagent.core :as r]
            [lymchat.shared.colors :as color]
            [clojure.string :as str]))

(enable-console-print!)

(def react-native (js/require "react-native"))

(def NativeModules (.-NativeModules react-native))
;; ios part
(def statusbar-background (.-StatusBarBackground NativeModules))

(def RCTConfig (.-Config NativeModules))

(def platform (.-Platform react-native))

(defn get-platform
  []
  (.-OS platform))

(defn ios?
  []
  (= "ios" (get-platform)))

(defn android?
  []
  (= "android" (get-platform)))

(def text (r/adapt-react-class (.-Text react-native)))
(def view (r/adapt-react-class (.-View react-native)))
(def scroll (r/adapt-react-class (.-ScrollView react-native)))
(def Image (.-Image react-native))
(def image (r/adapt-react-class Image))
(defn image-prefetch
  [url]
  (.prefetch Image url))
(def interaction-manager (.-InteractionManager react-native))
(def device-event-emitter (.-DeviceEventEmitter react-native))

(defn run-after-interactions
  [cb]
  (.runAfterInteractions interaction-manager
                         cb))

;; refresh-control
(def refresh-control (r/adapt-react-class (.-RefreshControl react-native)))
(def StatusBar (.-StatusBar react-native))
(def status-bar (r/adapt-react-class StatusBar))

(def device-info (js/require "react-native-device-info"))

(def touchable-highlight (r/adapt-react-class (.-TouchableHighlight react-native)))
(def touchable-opacity (r/adapt-react-class (.-TouchableOpacity react-native)))
(def touchable-without-feedback (r/adapt-react-class (.-TouchableWithoutFeedback react-native)))
(def touchable-native-feedback (r/adapt-react-class (.-TouchableNativeFeedback react-native)))
(def input (r/adapt-react-class (.-TextInput react-native)))
(def switch-ios (r/adapt-react-class (.-SwitchIOS react-native)))
(def switch (r/adapt-react-class (.-Switch react-native)))
(def vibration (.-Vibration react-native))

(defn vibrate
  []
  (.vibrate vibration))

(def list-view (r/adapt-react-class (.-ListView react-native)))
(def SwipeableListView (js/require "SwipeableListView"))
(def swipeable-list-view (r/adapt-react-class SwipeableListView))
(def swipeable-quick-actions (r/adapt-react-class (js/require "SwipeableQuickActions")))

;; image-progress
;; (def image (r/adapt-react-class (js/require "react-native-image-progress")))

(def progress (js/require "react-native-progress"))

;; dismisskeyboard
(def dismiss-keyboard (js/require "dismissKeyboard"))
(defn dismiss-keyboard-cp
  [child]
  (let [dismissed? (r/atom false)]
    (fn []
      (if dismissed?
        child

        [touchable-opacity {:style {:flex 1
                                    :activeOpacity 1
                                    :background-color "transparent"}
                            :on-press (fn []
                                        (dismiss-keyboard)
                                        (reset! dismissed? true))}
         child]))))

(def activity-indicator (r/adapt-react-class (.-ActivityIndicator react-native)))
(def button (r/adapt-react-class (js/require "apsl-react-native-button")))
(def linking (.-Linking react-native))
(def app-registry (.-AppRegistry react-native))

(defn open-url [url]
  (.openURL linking url))


(def dimensions (.-Dimensions react-native))
(def modal (r/adapt-react-class (.-Modal react-native)))

;; net-info
(def net-info (.-NetInfo react-native))

;; clipboard
(def clipboard (.-Clipboard react-native))

;; push notification
(def push-notification (js/require "react-native-push-notification"))

;; facebook
(def fb-sdk (js/require "react-native-fbsdk"))

;; google signin
(def google-signin-module (js/require "react-native-google-signin"))
(def google-signin (.-GoogleSignin google-signin-module))
(def google-signin-button (r/adapt-react-class (.-GoogleSigninButton google-signin-module)))

;; wechat
(def wechat (js/require "react-native-wechat"))

;; sound
(def incall-manager (.-default (js/require "react-native-incall-manager")))

(defn force-speaker-on
  []
  (.setForceSpeakerphoneOn incall-manager true))

(defn ring
  []
  (.start incall-manager (clj->js {:media "video"
                                   :ringback "_BUNDLE_"}))
  (when (not= "granted" (.-recordPermission incall-manager))
    (-> (.requestRecordPermission incall-manager)
        (.then (fn [result]
                 (prn "Incall request record permission result: " result)))
        (.catch (fn [err]
                  (prn "Incall request record permission err: " err))))))

(defn stop-ring
  []
  (.stop incall-manager))

;; modalbox
(def modalbox (r/adapt-react-class (js/require "react-native-modalbox")))

;; image-picker
(def image-picker (js/require "react-native-image-picker"))
(def image-resizer (.-default (js/require "react-native-image-resizer")))

;; aws3
(def aws3 (js/require "react-native-aws3"))
(def rns3 (.-RNS3 aws3))

;; icon
(def font-awesome (js/require "react-native-vector-icons/FontAwesome"))
(def icon (r/adapt-react-class font-awesome))
(def icon-button (r/adapt-react-class (.-Button font-awesome)))

(def material-icons (js/require "react-native-vector-icons/MaterialIcons"))
(def material-icon (r/adapt-react-class material-icons))
(def material-icon-button (r/adapt-react-class (.-Button material-icons)))

;; navigationexperimental
(def card-stack (r/adapt-react-class (.-CardStack (.-NavigationExperimental react-native))))
(def navigation-header-comp (.-Header (.-NavigationExperimental react-native)))
(def navigation-header (r/adapt-react-class navigation-header-comp))
(def header-title (r/adapt-react-class (.-Title (.-Header (.-NavigationExperimental react-native)))))

(def Realm (js/require "realm"))

(def realm-react-native (js/require "realm/react-native"))
(def realm-list-view (r/adapt-react-class (.-ListView realm-react-native)))

;; app intro
(def app-intro (r/adapt-react-class (.-default (js/require "react-native-app-intro"))))

;; linear gradient
(def gradient (r/adapt-react-class (.-default (js/require "react-native-linear-gradient"))))

(def gifted-chat (r/adapt-react-class (.-GiftedChat (js/require "react-native-gifted-chat"))))

(def parsed-text (r/adapt-react-class (.-default (js/require "react-native-parsed-text"))))

;; webrtc
(def webrtc (js/require "react-native-webrtc"))
(def rtc-view (r/adapt-react-class (.-RTCView webrtc)))

(def action-sheet (.-ActionSheetIOS react-native))

(def back-android (.-BackAndroid react-native))

;; moment
(def moment (js/require "moment"))

(def colors color/colors)

;; codepush
(def code-push (js/require "react-native-code-push"))

;; android
(def Drawer (js/require "react-native-drawer"))
(def drawer (r/adapt-react-class Drawer))

(def ActionButton (.-default (js/require "react-native-action-button")))
(def action-button (r/adapt-react-class ActionButton))

(def DialogAndroid (js/require "react-native-dialogs"))

(defn show-dialog
  [options]
  (let [dialog (DialogAndroid.)]
    (.set dialog (clj->js options))
    (.show dialog)))

(defn android-prompt
  [title content handler]
  (show-dialog {:title title
                :content content
                :positiveText "Ok"
                :negativeText "Cancel"
                :input {:callback (fn [text]
                                    (when-not (str/blank? text)
                                      (handler text)))}}))

(defn alert
  ([title]
   (.alert (.-Alert react-native) title))
  ([title message buttons]
   (.alert (.-Alert react-native) title message (clj->js buttons))))

(defn prompt
  [title message cb-or-buttons]
  (cond
    (android?)
    (android-prompt title message cb-or-buttons)

    (ios?)
    (.prompt (.-AlertIOS react-native) title message cb-or-buttons)

    :else
    nil))

(defn actions
  [options handler]
  (cond
    (android?)
    (show-dialog {:items options
                  :itemsCallback handler})

    (ios?)
    (.showActionSheetWithOptions
     action-sheet
     (clj->js options)
     handler)

    :else
    nil))

(def material-kit (js/require "react-native-material-kit"))
(def MDButton (.-MKButton material-kit))
(def md-button (r/adapt-react-class MDButton))
(defn floating-action-button
  [handler]
  (-> MDButton
      (.accentColoredFlatButton)
      (.withBackgroundColor (:teal400 colors))
      (.withMaskColor "transparent")
      (.withStyle #js {:position "absolute"
                       :right 16
                       :bottom 16
                       :width 56
                       :height 56
                       :borderRadius 28})
      (.withOnPress handler)
      (.build)
      (r/adapt-react-class)))
(def MDSwitch (.-MKSwitch material-kit))
(def md-switch (r/adapt-react-class MDSwitch))
