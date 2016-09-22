(ns lymchat.styles
  (:require [lymchat.shared.ui :refer [colors] :as ui]
            [re-frame.db :refer [app-db]]))

(def styles
  {:header {:android {:height 60
                      :background-color (:teal400 colors)}
            :ios {:height 45
                  :background-color "rgba(255,255,255,1)"
                  :top 20}}
   :header-title {:android {}
                  :ios {:margin-top -25}}
   :header-text {:android {:color "#FFF"
                           :font-size 18}
                 :ios {:color "rgba(0,0,0,0.8)"
                       :font-size 18
                       :fontFamily "Optima-Bold"}}
   :header-container {:android {:flex 1}
                      :ios {:flex 1
                            :margin-top 20}}
   :mentions {:android {:flex 1
                        :background-color "#efefef"}
              :ios {:flex 1
                    :background-color "rgba(255,255,255,0.8)"
                    :margin-top 20
                    :margin-bottom 47}}

   :channels {:android {:flex 1}
              :ios {:flex 1
                    :margin-top 20
                    :margin-bottom 50}}
   :channel-members-count {:android {:padding-top 35
                                     :padding-right 10
                                     :font-size 20
                                     :color "#FFF"
                                     :align-self "center"}
                           :ios {:padding-top 12
                                 :padding-right 30
                                 :align-self "center"
                                 :color "#65BC54"
                                 :font-size 18
                                 :fontFamily "Times New Roman"}}
   :search-icon {:android {:size 24
                           :background-color "transparent"
                           :margin-top 34
                           :margin-right -5
                           :color "#FFF"}
                 :ios {:size 24
                       :background-color "transparent"
                       :margin-top 2
                       :margin-right -10
                       :color "#rgba(0,0,0,0.8)"}}
   :photo-upload-icon {:android {:size 24
                                 :background-color "transparent"
                                 :margin-top 30
                                 :margin-right -5
                                 :color "#FFF"}
                       :ios {:size 24
                             :background-color "transparent"
                             :margin-top 5
                             :margin-right -8
                             :color "#rgba(0,0,0,0.8)"}}
   :video-call-icon {:android {:size 24
                               :background-color "transparent"
                               :margin-top 35
                               :margin-right -5
                               :color "#FFF"}
                     :ios {:size 24
                           :background-color "transparent"
                           :margin-top 5
                           :margin-right -8
                           :color "#rgba(0,0,0,0.8)"}}

   :avatar-icon {:android {:margin-top 40
                           :margin-right 8}
                 :ios {:margin-top 10
                       :margin-right 6}}

   :right-menu {:android {:padding-top 35
                          :padding-bottom 10
                          :padding-right 10
                          :padding-left 20
                          :font-size 20
                          :font-weight "700"
                          :color "#FFF"
                          :align-self "center"}
                :ios {:font-size 20
                      :padding-top 6
                      :padding-bottom 6
                      :font-weight "700"
                      :color "rgba(0,0,0,0.8)"}}
   :mentions-loading {:android {:flex 1
                                :justify-content "center"
                                :align-items "center"
                                :background-color "#efefef"}
                      :ios {:flex 1
                            :margin-top 20
                            :justify-content "center"
                            :align-items "center"
                            :background-color "rgba(255,255,255,0.8)"}}
   :mentions-empty {:android {:flex 1
                              :background-color "#efefef"}
                    :ios {:flex 1
                          :margin-top 20
                          :background-color "rgba(255,255,255,0.8)"}}
   :invites-empty {:android {:flex 1
                             :background-color "#efefef"}
                    :ios {:flex 1
                          :margin-top 20
                          :background-color "rgba(255,255,255,0.8)"}}

   :login {:flex 1
           :justify-content "center"
           :align-items "center"
           :background-color (:teal500 colors)}

   :container {:flex 1
               :margin-top (if (:header? @app-db)
                             (.-HEIGHT ui/navigation-header-comp)
                             20)}

   :search-row {:flex 1
                :backgroundColor "#eeeeee"
                :padding 10}

   :search-text-input {:backgroundColor "white"
                       :borderColor "#cccccc"
                       :borderRadius 3
                       :borderWidth 1
                       :paddingLeft 8
                       :height 35}

   :header-search-text-input {:borderWidth 0
                              :font-size 16
                              :color "#fff"}
   :no-border-input {:flex 1
                     :backgroundColor "transparent"
                     :borderWidth 0
                     :paddingLeft 8
                     :height 60
                     :font-size 20}

   :small-avatar {:width 40
                  :height 40}

   :horizontal-scroll {:flex 1
                       :justify-content "space-between"
                       :flex-direction "row"
                       :flex-wrap "wrap"
                       :padding-left 10}

   :topic-button {:border-width 1
                  :border-color "#ffffff"
                  :border-radius 7
                  :padding-left 10
                  :padding-right 10
                  :margin-bottom 20
                  :margin-right 10
                  :height 25
                  :background-color "transparent"}

   :topic-button-text {:font-size 12
                       :font-weight "bold"
                       :color "#ffffff"
                       :text-align "center"}

   :topic-header {:flex-direction "row"
                  :justify-content "space-between"
                  :background-color "transparent"
                  :padding 10
                  :margin-bottom 10}

   :gist {:font-size 26
          :font-weight "bold"
          :color "#FFFFFF"
          :fontFamily "Cochin"
          :background-color "transparent"}

   :hl-interest-button {:background-color (:amber800 colors)
                        :border-color (:amber800 colors)}

   :left-corner {:position "absolute"
                 :top 0
                 :left 0
                 :backgroundColor "transparent"
                 :padding 10}

   ;; copy from react-native-material-kit
   :card {:view-style {:flex 1
                       :margin-top (.-HEIGHT ui/navigation-header-comp)
                       :backgroundColor "rgba(0,0,0,0.3)"
                       :borderRadius 2
                       :borderColor "#ffffff"
                       ;; :borderWidth 1
                       :shadowColor "rgba(0, 0, 0, 0.12)"
                       :shadowOpacity 0.8
                       :shadowRadius 2
                       :shadowOffset {:height 1 :width 2}}
          :image-style {:flex 1
                        :resizeMode "cover"}
          :title-style {:fontSize 16
                        :color (:dark-white colors)
                        :fontWeight "bold"}
          :menu-style {:position "absolute"
                       :top 0
                       :right 10
                       :backgroundColor "transparent"}}

   :gradient {:position "absolute"
              :top 0
              :bottom 0
              :left 0
              :right 0}

   :back-button {:color "rgba(0,0,0,0.8)"
                 :font-size 35}

   :plus-button {:color "rgba(0,0,0,0.8)"
                 :font-size 25}

   :setting-item {:flex-direction "row"
                  :justify-content "space-between"
                  :align-items "center"
                  :padding-left 10
                  :padding-right 10
                  :height 50
                  :background-color "rgba(255,255,255,0.90)"
                  :border-bottom-width 0.5
                  :border-color "#cccccc"}

   :setting-icon-item {:flex-direction "row"
                       :align-items "center"
                       :padding-left 10
                       :padding-right 10
                       :height 50
                       :background-color "rgba(255,255,255,0.90)"
                       :border-bottom-width 0.5
                       :border-color "#cccccc"}

   :top-stream {:position "absolute"
                :top 30
                :left 10
                :width 90
                :height 120}
   :background-stream {:flex 1
                       :align-self "stretch"
                       :transform [{:scaleX -1}]}

   :delete-container {:flex 1
                      :flexDirection "row"
                      :alignItems "center"
                      :justifyContent "flex-end"
                      :overflow "hidden"}

   :message {:bubble-left {:background-color "#FFFFFF"
                           :margin-left 5}
             :bubble-right {:background-color "#DCF8C6"
                            :margin-right 5}

             :bubble {:padding-left 10
                      :padding-right 10
                      :padding-top 5
                      :padding-bottom 5
                      :margin-bottom 5
                      :border-radius 7}}

   :triangle-corner {:position "absolute"
                     :width 0
                     :height 0
                     :backgroundColor "transparent"
                     :borderStyle "solid"
                     :borderRightWidth 12
                     :borderTopWidth 12
                     :borderRightColor "transparent"
                     :borderTopColor "#e6e6eb"}
   :triangle-left {:borderTopColor "#ffffff"
                   :left -12
                   :bottom 0
                   :transform [{:rotate "180deg"}]}
   :triangle-right {:borderTopColor "#DCF8C6"
                    :right -12
                    :bottom 0
                    :transform [{:rotate "270deg"}]}})

(defn pl-style
  [k]
  (get-in styles [k (keyword (ui/get-platform))]))
