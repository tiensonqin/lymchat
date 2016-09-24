(ns lymchat.constants
  (:require [lymchat.utils.module :as m]
            [lymchat.util :as util]))

(def tintColor "#2f95dc")
(def colors
  {:tabIconDefault "#888"
   :tabIconSelected tintColor
   :tabBar "#fefefe"
   :errorBackground "red"
   :errorText "#fff"
   :warningBackground "#EAEB5E"
   :warningText "#666804"
   :noticeBackground "black"
   :noticeText "#fff"})

(def alerts
  {:error {:container {:backgroundColor "red"},
           :text "#fff"}
   :warning {:container {:backgroundColor "#EAEB5E"},
             :text "#666804"}
   :notice {:container {:backgroundColor "black"},
            :text "#fff"}})

(def layouts
  (-> (.get m/dimensions "window")
      util/keywordize))

(def styles
  {:container {:flex 1
               :backgroundColor "#FFF"
               :margin-top 24}
   :statusBarUnderlay {:height 24
                       :backgroundColor "rgba(0,0,0,0.2)"}
   :exponent-button {:flex 1
                     :align-items "center"
                     :justify-content "center"
                     :margin-right 15
                     :padding-top 2}
   :home {:container {:backgroundColor "#fff"}}
   :text-input {:width (- (:width layouts) 20)
                :borderRadius 2
                :borderWidth 1
                :borderColor "#eee"
                :fontSize 15
                :padding 5
                :height 40}
   :button {:paddingHorizontal 20
            :paddingVertical 15
            :marginRight 10
            :backgroundColor tintColor
            :borderRadius 5}})
