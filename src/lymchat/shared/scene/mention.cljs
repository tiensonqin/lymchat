(ns lymchat.shared.scene.mention
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch]]
            [lymchat.styles :refer [styles pl-style]]
            [lymchat.shared.ui :refer [text view touchable-highlight list-view react-native button icon image input touchable-opacity colors activity-indicator moment refresh-control] :as ui]
            [lymchat.shared.scene.chat :refer [channel-current-input]]
            [lymchat.shared.scene.chat :refer [parse-text]]
            [lymchat.realm :as realm]
            [lymchat.util :as util]))

(defn row-cp
  [row]
  (let [{:keys [id name username channel_id channel_name avatar user_id body created_at]} (js->clj row :keywordize-keys true)
        channel (realm/get-by-id "Channel" channel_id)]
    [touchable-opacity {:on-press (fn []
                                    (when channel
                                      (reset! channel-current-input (str "@" username ": "))
                                      (dispatch [:set-channel-auto-focus true])
                                      (dispatch [:jump-in-channel-conversation channel])))}
     [view {:key id
            :style {:flex 1
                    :padding 10
                    :flex-direction "row"}}
      [image {:source {:uri avatar}
              :style {:width 40
                      :height 40
                      :resizeMode "cover"
                      :border-radius 4}}]
      [view {:style {:flex 1
                     :flex-direction "column"
                     :padding-left 10}}
       [view {:style {:flex-direction "row"
                      :justify-content "space-between"}}
        [view {:style {:flex-direction "row"}}
         [text {:style {:font-weight "700"
                        :color "rgba(0,0,0,0.85)"}}
          username]
         [text {:style {:font-weight "700"
                        :margin-left 10
                        :color "rgba(0,0,0,0.6)"}}
          (str "#" (util/underscore-channel-name channel_name))]
         [text {:style {:color "grey"
                        :margin-left 10}}
          (.format (new moment created_at) "h:mm A")]]]

       [text {:style {:font-size 16
                      :color "rgba(0,0,0,0.8)"
                      :margin-top 5}}
        (parse-text body)]]]]))

(defn mentions-cp
  []
  (let [loading? (subscribe [:loading?])
        mentions (subscribe [:mentions])
        refreshing? (r/atom false)]
    (dispatch [:load-mentions])
    (fn []
      (cond
        @loading?
        [view {:style (pl-style :mentions-loading)}
         [activity-indicator {:animating true
                              :size "large"}]]

        (seq @mentions)
        (do
          (dispatch [:reset-mention-latest-id])
          (let [ds (.-DataSource (.-ListView react-native))
                list-view-ds (new ds #js {:rowHasChanged #(not= %1 %2)
                                          :sectionHeaderHasChanged #(not= %1 %2)})]
            [list-view {:style (pl-style :mentions)
                        :automaticallyAdjustContentInsets false
                        :dataSource (.cloneWithRowsAndSections list-view-ds  (clj->js @mentions) (clj->js (keys @mentions)))
                        :refreshControl (r/as-element
                                         [refresh-control {:refreshing @refreshing?
                                                           :onRefresh (fn []
                                                                        (dispatch [:refresh-mentions refreshing?]))}])
                        :renderRow (fn [row]
                                     (r/as-element (row-cp row)))
                        :renderSectionHeader (fn [data section-id]
                                               (r/as-element
                                                (if (ui/ios?)
                                                  [view {:style {:opacity 1
                                                                 :background-color "rgba(255,255,255,0.6)"}}
                                                   [text {:style {:color "rgba(0,0,0,0.8)"
                                                                  :font-size 18
                                                                  :fontFamily "Optima-Bold"
                                                                  :align-self "center"
                                                                  :padding-top 8
                                                                  :padding-bottom 8}}
                                                    section-id]]
                                                  [view
                                                   [text {:style {:color "rgba(0,0,0,0.8)"
                                                                  :font-size 13
                                                                  :font-weight "bold"
                                                                  :align-self "center"
                                                                  :padding-top 8
                                                                  :padding-bottom 8}}
                                                    section-id]])))
                        :renderSeparator (fn [section-id row-id]
                                           (r/as-element
                                            [view {:key (str section-id "-" row-id)
                                                   :style {:height 1
                                                           :margin-left 10
                                                           :margin-right 10
                                                           :background-color "#ddd"}}]))}]))

        :else
        [view {:style (pl-style :mentions-empty)}
         (if (ui/ios?)
           [text {:style {:color "rgba(0,0,0,0.8)"
                          :font-size 18
                          :fontFamily "Optima-Bold"
                          :align-self "center"
                          :padding-top 8
                          :padding-bottom 8}}
            "mentions"])
         [view {:style {:flex 1
                        :justify-content "center"
                        :align-items "center"}}
          [text {:style {:fontFamily "Cochin"
                         :font-size 20}}
           "No mentions yet."]]]))))
