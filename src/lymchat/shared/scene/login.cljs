(ns lymchat.shared.scene.login
  (:require
   [reagent.core :as r]
   [re-frame.core :refer [subscribe dispatch]]
   [lymchat.styles :refer [styles]]
   [lymchat.shared.ui :refer [text view image touchable-highlight card-stack icon-button colors status-bar gradient image-prefetch google-signin dimensions Image gradient] :as ui]
   [lymchat.shared.login :as login]
   [lymchat.util :as util]))

(def logo (js/require "./images/logo.png"))

(defn login-scene
  []
  (let [access? (subscribe [:google-access?])]
    (r/create-class {:component-will-mount
                     (fn []
                       (util/hide-statusbar))

                     :component-did-mount
                     (fn []
                       (.configure ui/google-signin
                                   (cond
                                     (ui/android?)
                                     #js {:webClientId (.-google_signin_client_id ui/RCTConfig)}

                                     (ui/ios?)
                                     #js {:iosClientId (.-google_signin_client_id ui/RCTConfig)}

                                     :else
                                     #js {})))

                     :reagent-render
                     (fn []
                       (let [{:keys [width height]} (js->clj (.get dimensions "window") :keywordize-keys true)]
                         [view {:style (:login styles)}
                          [gradient {:style (:gradient styles)
                                     :colors #js [(:teal500 colors) (:teal400 colors) "rgba(255,255,255,0.1)"]}]
                          [view {:style {:position "absolute"
                                         :top 10
                                         :right 10
                                         :background-color "transparent"}}
                           [view {:flex 1
                                  :flex-direction "row"}
                            [image {:style {:width 40
                                            :height 40
                                            :resizeMode "cover"}
                                    :source logo}]]]

                          [view
                           (when-not @access?
                             [view {:style {:margin-bottom 30}}
                              [icon-button {:name "wechat"
                                            :width 184.5
                                            :background-color "#3CB034"
                                            :on-press (fn []
                                                        (login/wechat-login))}
                               "微信登录"]])

                           [view {:style {:margin-bottom 30}}
                            [icon-button {:name "facebook"
                                          :width 184.5
                                          :background-color "#3b5998"
                                          :on-press (fn []
                                                      (login/fb-login))}
                             "Sign in with Facebook"]]

                           [view {:style {:margin-bottom 30}}
                            [icon-button {:name "google-plus"
                                          :width 184.5
                                          :background-color "#E54C2C"
                                          :on-press (fn []
                                                      (login/google-login))}
                             "Sign in with Google"]]]]))})))
