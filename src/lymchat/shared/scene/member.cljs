(ns lymchat.shared.scene.member
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch]]
            [lymchat.styles :refer [styles pl-style]]
            [lymchat.shared.ui :refer [text view touchable-highlight list-view react-native button icon image input touchable-opacity colors activity-indicator moment refresh-control]]
            [lymchat.photo :refer [offline-avatar-cp]]
            [lymchat.shared.scene.chat :refer [channel-current-input]]
            [lymchat.realm :as realm]
            [clojure.string :as str]
            [lymchat.util :as util]
            [cljs-time.coerce :as tc]
            [lymchat.ws :as ws]))

(defn member-cp
  [user]
  (let [{:keys [id name username avatar]} (js->clj user :keywordize-keys true)]
    [touchable-opacity {:on-press (fn []
                                    (dispatch [:nav/push {:key :channel-profile
                                                          :title ""
                                                          :user user}]))
                        :style {:flex-direction "column"}}
     [view {:style {:flex-direction "row"
                    :padding-left 10
                    :padding-right 10
                    :padding-bottom 10
                    :padding-top 10
                    :border-width 0.5
                    :border-color "#ccc"}}
      [image {:source {:uri avatar}
              :style {:width 40
                      :height 40
                      :resizeMode "cover"
                      :border-radius 4}}]
      [view {:style {:margin-left 10}}
       [text {:style {:font-weight "500"
                      :color "rgba(0,0,0,0.8)"}}
        name]

       [text {:style {:margin-top 5
                      :color "rgba(0,0,0,0.6)"}}
        (str "@" username)]]]]))

(defn members-cp
  [channel]
  (let [members (subscribe [:channel-members (aget channel "id")])]
    (when (empty? @members)
      (ws/get-members (aget channel "id")))
    (fn []
      (let [ds (.-DataSource (.-ListView react-native))
            list-view-ds (new ds #js {:rowHasChanged #(not= %1 %2)})]
        [list-view {:style (assoc (pl-style :header-container)
                                  :background-color (:white800 colors))
                    :automaticallyAdjustContentInsets false
                    :dataSource (.cloneWithRows list-view-ds (clj->js @members))
                    :renderRow (fn [row]
                                 (r/as-element (member-cp row)))
                    :renderSeparator (fn [section-id row-id]
                                       (r/as-element
                                        [view {:key (str section-id "-" row-id)
                                               :style {:height 0.5
                                                       :margin-left 10
                                                       :margin-right 10
                                                       :background-color "#efefef"}}]))}]))))
