(ns lymchat.utils.module
  (:require [reagent.core :as r]))

(enable-console-print!)

;; React Native
(def ReactNative (js/require "react-native"))
(def app-registry (.-AppRegistry ReactNative))
(def text (r/adapt-react-class (.-Text ReactNative)))
(def view (r/adapt-react-class (.-View ReactNative)))
(def image (r/adapt-react-class (.-Image ReactNative)))
(def touchable-highlight (r/adapt-react-class (.-TouchableHighlight ReactNative)))
(def touchable-opacity (r/adapt-react-class (.-TouchableOpacity ReactNative)))
(def TouchableNativeFeedback (.-TouchableNativeFeedback ReactNative))
(def touchable-native-feedback (r/adapt-react-class TouchableNativeFeedback))
(def dimensions (.-Dimensions ReactNative))
(def Platform (.-Platform ReactNative))
(def StatusBar (.-StatusBar ReactNative))
(def status-bar (r/adapt-react-class StatusBar))
(def activity-indicator (r/adapt-react-class (.-ActivityIndicator ReactNative)))
(def Alert (.-Alert ReactNative))
(def DrawerLayoutAndroid (.-DrawerLayoutAndroid ReactNative))
(def drawer-layout-android (r/adapt-react-class DrawerLayoutAndroid))
(def Picker (.-Picker ReactNative))
(def picker (r/adapt-react-class Picker))
(def picker-item (r/adapt-react-class Picker.Item))
(def ProgressBarAndroid (.-ProgressBarAndroid ReactNative))
(def progress-bar-android (r/adapt-react-class ProgressBarAndroid))
(def RefreshControl (.-RefreshControl ReactNative))
(def refresh-control (r/adapt-react-class RefreshControl))
(def Slider (.-Slider ReactNative))
(def slider (r/adapt-react-class Slider))
(def Switch (.-Switch ReactNative))
(def switch (r/adapt-react-class Switch))
(def ListView (.-ListView ReactNative))
(def list-view (r/adapt-react-class ListView))
(def ScrollView (.-ScrollView ReactNative))
(def scroll-view (r/adapt-react-class ScrollView))
(def TextInput (.-TextInput ReactNative))
(def text-input (r/adapt-react-class TextInput))
(def DatePickerAndroid (.-DatePickerAndroid ReactNative))
(def TimePickerAndroid (.-TimePickerAndroid ReactNative))
(def WebView (.-WebView ReactNative))
(def webview (r/adapt-react-class WebView))
(def Animated (.-Animated ReactNative))
(def animated-value (.-Value Animated))
(def StyleSheet (.-StyleSheet ReactNative))
(def DeviceEventEmitter (.-DeviceEventEmitter ReactNative))
(def NativeModules (.-NativeModules ReactNative))
(def TouchableBounce (js/require "react-native/Libraries/Components/Touchable/TouchableBounce"))
(def touchable-bounce (r/adapt-react-class TouchableBounce))

;; ios
(def ActionSheetIOS (.-ActionSheetIOS ReactNative))
(def AlertIOS (.-AlertIOS ReactNative))
(def DatePickerIOS (.-DatePickerIOS ReactNative))
(def date-picker-ios (r/adapt-react-class DatePickerIOS))
(def MapView (.-MapView ReactNative))
(def map-view (r/adapt-react-class MapView))
(def ProgressViewIOS (.-ProgressViewIOS ReactNative))
(def progress-view-ios (r/adapt-react-class ProgressViewIOS))
(def SegmentedControlIOS (.-SegmentedControlIOS ReactNative))
(def segmented-control-ios (r/adapt-react-class SegmentedControlIOS))

;; Exponentjs
(def exponent (js/require "exponent"))
;; Exponentjs api
(def Amplitude (aget exponent "Amplitude"))
(def Asset (aget exponent "Asset"))
(def Components (aget exponent "Components"))
(def app-loading (r/adapt-react-class Components.AppLoading))
(def blur-view (r/adapt-react-class Components.BlurView))
(def linear-gradient (r/adapt-react-class Components.LinearGradient))
(def video (r/adapt-react-class Components.Video))
(def Constants (aget exponent "Constants"))
(def Contacts (aget exponent "Contacts"))
(def Crypto (aget exponent "Crypto"))
(def Fabric (aget exponent "Fabric"))
(def Facebook (aget exponent "Facebook"))
(def FileSystem (aget exponent "FileSystem"))
(def Font (aget exponent "Font"))
(def ImageCropper (aget exponent "ImageCropper"))
(def ImagePicker (aget exponent "ImagePicker"))
(def Location (aget exponent "Location"))
(def Notifications (aget exponent "Notifications"))
(def Permissions (aget exponent "Permissions"))
(def Segment (aget exponent "Segment"))
(def Util (aget exponent "Util"))
(def registerRootComponent (aget exponent "registerRootComponent"))
(def takeSnapshotAsync (aget exponent "takeSnapshotAsync"))

;; ex-navigation
(def ex-navigation (js/require "@exponent/ex-navigation"))
(def create-router (aget ex-navigation "createRouter"))
(def NavigationProvider (aget ex-navigation "NavigationProvider"))
(def navigation-provider (r/adapt-react-class NavigationProvider))
(def StackNavigation (aget ex-navigation "StackNavigation"))
(def stack-navigation (r/adapt-react-class StackNavigation))

;; victory-chart
;; (def VictoryChart (js/require "victory-chart-native"))

;; vector-icons
(def material-icons (r/adapt-react-class (.-default (js/require "@exponent/vector-icons/MaterialIcons"))))

;; helper

(defn ->ds
  ([]
   (->ds {:rowHasChanged (partial not=)
          :sectionHeaderHasChanged (partial not=)}))
  ([options]
   (let [ds (.-DataSource ListView)]
     (new ds (clj->js options)))))

(defn clone-ds
  [ds data]
  (.cloneWithRowsAndSections ds (clj->js data)))

(defn refresh
  [value on-refresh-cb]
  (r/as-element
   [refresh-control
    {:refreshing value
     :onRefresh on-refresh-cb}]))

(defn android?
  []
  (= "android" Platform.OS))

(defn ios?
  []
  (= "ios" Platform.OS))

(defn jsx->clj
  [x]
  (if (map? x)
    x
    (into {} (for [k (.keys js/Object x)]
               [(keyword k)
                (aget x k)]))))

;; (sort (keys (jsx->clj exponent)))
;; '(:Amplitude :Asset :Components :Constants :Contacts :Crypto :Fabric :Facebook :FileSystem :Font :ImageCropper :ImagePicker :Location :Notifications :Permissions :Segment :Util :registerRootComponent :takeSnapshotAsync)

;; (sort (keys (jsx->clj Constants)))
;; '(:appOwnership :default :deviceId :deviceName :deviceYearClass :experienceUrl :exponentVersion :intentUri :isDevice :linkingUri :manifest :sessionId :statusBarHeight)

;; (sort (keys (jsx->clj ex-navigation)))
;; '(:AndroidBackButtonBehavior :DrawerNavigation :DrawerNavigationItem :NavigationActions :NavigationBar :NavigationContext :NavigationProvider :NavigationReducer :NavigationStyles :SlidingTabNavigation :SlidingTabNavigationItem :StackNavigation :TabBadge :TabNavigation :TabNavigationItem :createFocusAwareComponent :createNavigationEnabledStore :createRouter :getBackButtonManager :withNavigation)
