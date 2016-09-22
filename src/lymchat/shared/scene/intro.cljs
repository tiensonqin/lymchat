(ns lymchat.shared.scene.intro
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch]]
            [lymchat.styles :refer [styles]]
            [lymchat.shared.ui :refer [text view image touchable-highlight colors status-bar push-notification gradient image-prefetch code-push activity-indicator app-intro dimensions modal button]]
            [lymchat.shared.scene.login :as login]
            [lymchat.util :as util]))

(def image-s1 (js/require "./images/intro/s1.png"))
(def image-s2 (js/require "./images/intro/s2.png"))
(def image-s3 (js/require "./images/intro/s3.png"))

(defn skip-button-handler
  [state]
  (reset! state :done))

(defn done-button-handler
  [state]
  (reset! state :done))

(defn next-button-handler
  [i]
  )

(defn slide-change-handler
  [i t]
  )

(defn pages
  [width height]
  [{:title "Learn different cultures"
    :img image-s1
    :imgStyle {:width width
               :resizeMode "contain"}
    :backgroundColor (:teal500 colors)
    :fontColor "#fff"
    :level 10}
   {:title "Talk to people with same interests"
    :img image-s2
    :imgStyle {:width width
               :resizeMode "contain"}
    :backgroundColor (:teal500 colors)
    :fontColor "#fff"
    :level 10}
   {:title "Unlimited video chat"
    :description "Start learning, completely free!"
    :img image-s3
    :imgStyle {:width width
               :resizeMode "contain"}
    :backgroundColor (:teal500 colors)
    :fontColor "#fff"
    :level 10}])

(defn intro-cp
  []
  (let [skip-or-done? (r/atom nil)]
    (fn []
      (let [term-style (assoc (:gist styles)
                              :font-size 18
                              :font-weight "500"
                              :padding-top 10
                              :padding-bottom 10)]
        (case @skip-or-done?
          nil
          (let [{:keys [width height]} (js->clj (.get dimensions "window") :keywordize-keys true)]
            [app-intro {:onNextBtnClick next-button-handler
                        :onDoneBtnClick (fn []
                                          (done-button-handler skip-or-done?))
                        :onSkipBtnClick (fn []
                                          (skip-button-handler skip-or-done?))
                        :onSlideChange slide-change-handler
                        :pageArray (pages width height)}])

          :done

          [modal {:animationType "slide"
                  :transparent false
                  :visible true}
           [view {:flex 1
                  :padding-top 30
                  :background-color (:teal600 colors)
                  :align-items "center"}
            [text {:style (:gist styles)}
             "Respect everyone's culture"]
            [view {:style {:margin-top 20
                           :margin-bottom 20}}
             [text {:style term-style}
              "No porn"]
             [text {:style term-style}
              "No abusive"]
             [text {:style term-style}
              "No advertisement"]
             [text {:style term-style}
              "No dates"]
             [text {:style term-style}
              "No spam"]
             [text {:style term-style}
              "No nudity"]
             [text {:style term-style}
              "No animal cruelty"]
             [text {:style term-style}
              "No dead animals"]
             [text {:style term-style}
              "Or your account will be disabled"]]
            [button {:style {:margin-left 10
                             :margin-right 10
                             :border-color "#FFF"}
                     :on-press #(reset! skip-or-done? :accept)}
             [text {:style (:gist styles)}
              "I Agree"]]]]

          [login/login-scene])))))
