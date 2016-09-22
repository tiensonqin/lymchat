(ns lymchat.shared.scene.invite
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch]]
            [lymchat.styles :refer [styles pl-style]]
            [lymchat.shared.ui :refer [text view image touchable-highlight touchable-opacity  button icon icon-button material-icon-button colors gradient scroll activity-indicator dimensions] :as ui]
            [lymchat.util :as util]))

(defn seperator-cp
  []
  [view {:style {:border-width 0.5
                 :border-color "#ccc"
                 :margin-top 10
                 :margin-bottom 10}}])

(defn invite-request-cp
  []
  (let [current-user (subscribe [:current-user])
        first-invite (subscribe [:first-invite])
        self? (= (str (:id @current-user)) (str (:id @first-invite)))
        first-invite (if self? nil first-invite)]
    (when (ui/ios?) (util/remove-header))
    (fn []
      (if (empty? @first-invite)
        [view {:style {:flex 1
                       :background-color "#efefef"
                       :justify-content "center"
                       :align-items "center"}}
         [text {:style {:font-size 20}}
          "No invitations."]]
        (let [{:keys [id name username avatar language timezone]} @first-invite
              {:keys [width height]} (js->clj (.get dimensions "window") :keywordize-keys true)]
          [view {:style {:flex 1}}
           [image {:style {:width width
                           :height 250
                           :resizeMode "cover"}
                   :source {:uri (util/get-avatar avatar :large)}}]
           (when (ui/ios?)
             [view {:style {:position "absolute"
                            :top 20}}
              [material-icon-button {:name "arrow-back"
                                     :on-press (fn []
                                                 (dispatch [:nav/pop])
                                                 (when (ui/ios?) (util/restore-header)))
                                     :size 30
                                     :background-color "transparent"
                                     :color "#FFF"}]])
           [view {:style {:position "absolute"
                          :left 15
                          :top 190}}
            [text {:style {:font-size 20
                           :font-weight "bold"
                           :color "#FFFFFF"}}
             name]
            [text {:style {:margin-top 5
                           :font-size 14
                           :color "#FFFFFF"}}
             (str "@" username)]]

           [view {:style {:background-color "#FFF"
                          :flex 1
                          :padding-top 15
                          :padding-left 15
                          :padding-right 15}}

            [view {:style {:flex-direction "row"
                           :justify-content "space-between"}}
             [button {:style {:border-width 1.5
                              :border-color "#rgba(0,0,0,0.3)"
                              :border-radius 4
                              :width 120
                              :height 40
                              :background-color "transparent"}
                      :text-style {:font-size 20
                                   :font-weight "500"
                                   :color "#rgba(0,0,0,0.6)"}
                      :on-press #(dispatch [:invite-reply @first-invite true])}
              "Accept"]

             [button {:style {:border-width 1.5
                              :border-color "#rgba(0,0,0,0.3)"
                              :border-radius 4
                              :width 120
                              :height 40
                              :background-color "transparent"}
                      :text-style {:font-size 20
                                   :font-weight "500"
                                   :color "#rgba(0,0,0,0.6)"}
                      :on-press #(do
                                   (dispatch [:skip-invite id])
                                   (dispatch [:invite-reply @first-invite false]))}
              "Ignore"]]

            [text {:style {:color "grey"
                           :margin-top 15}}
             "Native language"]
            [text {:style {:margin-top 5
                           :font-size 16}}
             language]

            [seperator-cp]

            (when timezone
              [view
               [text {:style {:color "grey"}}
                "Timezone"]
               [text {:style {:margin-top 5
                              :font-size 16}}
                timezone]

               [seperator-cp]])]])))))
