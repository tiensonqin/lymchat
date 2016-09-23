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
(def dimensions (.-Dimensions ReactNative))
(def Platform (.-Platform ReactNative))
(def status-bar (r/adapt-react-class (.-StatusBar ReactNative)))
(def activity-indicator (r/adapt-react-class (.-ActivityIndicator ReactNative)))
(def Alert (.-Alert ReactNative))
(def DatePickerAndroid (.-DatePickerAndroid ReactNative))
(def DrawerLayoutAndroid (.-DrawerLayoutAndroid ReactNative))
(def Picker (.-Picker ReactNative))
(def ProgressBarAndroid (.-ProgressBarAndroid ReactNative))
(def RefreshControl (.-RefreshControl ReactNative))
(def Slider (.-Slider ReactNative))
(def Switch (.-Switch ReactNative))
(def ListView (.-ListView ReactNative))
(def ScrollView (.-ScrollView ReactNative))
(def TextInput (.-TextInput ReactNative))
(def TimePickerAndroid (.-TimePickerAndroid ReactNative))
(def TouchableOpacity (.-TouchableOpacity ReactNative))
(def TouchableHighlight (.-TouchableHighlight ReactNative))
(def TouchableNativeFeedback (.-TouchableNativeFeedback ReactNative))
(def WebView (.-WebView ReactNative))

;; Exponentjs
(def exponent (js/require "exponent"))
;; Exponentjs api
(def Amplitude (aget exponent "Amplitude"))
(def Asset (aget exponent "Asset"))
(def Components (aget exponent "Components"))
(def app-loading (r/adapt-react-class Components.AppLoading))
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

;; vector-icons
;; (def vector-icons (js/require "@exponent/vector-icons"))

;; helper
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
