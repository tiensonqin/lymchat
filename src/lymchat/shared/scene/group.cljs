(ns lymchat.shared.scene.group
  (:require [reagent.core :as r]
            [re-frame.core :refer [subscribe dispatch]]
            [lymchat.styles :refer [styles pl-style]]
            [lymchat.shared.ui :refer [text view touchable-highlight  scroll material-icon-button button icon image input touchable-opacity dimensions list-view react-native device-event-emitter] :as ui]
            [lymchat.realm :as realm]
            [clojure.string :as str]
            [lymchat.util :as util]
            [lymchat.shared.scene.recommend-channels :refer [recommend-channels]]
            [cljs-time.coerce :as tc]
            [lymchat.api :as api]))

;; 320 86.33
;; 375 73.75
;; 414 83.5
(defn adapt-width
  [width]
  (cond
    (<= width 320)
    86.33

    :else
    (/ (- width 80) 4)))

(defn show-actions
  ([channel in?]
   (show-actions channel in? nil))
  ([channel in? join-success-cb]
   (let [buttons (if in?
                   ["Leave"
                    "Cancel"]
                   [(str "Join " (:name channel))
                    "Cancel"])
         options (cond
                   (ui/ios?)
                   (cond->
                     {:options buttons
                      :cancelButtonIndex 1}
                     in?
                     (assoc :destructiveButtonIndex 0))

                   (ui/android?)
                   buttons

                   :else
                   nil)
         handler (fn [i] (case i
                          0  (if in?
                               (dispatch [:leave-channel (:id channel)])
                               (do
                                 (dispatch [:join-channel (clj->js (update channel :created_at tc/to-date))])
                                 (if join-success-cb (join-success-cb))))
                          ;; cancel
                          nil))]
     (ui/actions options handler))))

(defn channel-cp
  ([channel]
   (channel-cp channel false false))
  ([channel in?]
   (channel-cp channel in? false))
  ([{:keys [id name picture type] :as channel} in? stretch?]
   (let [{:keys [width]} (js->clj (.get dimensions "window") :keywordize-keys true)
         channel-width (adapt-width width)]
     [touchable-opacity {:style {:flex 1
                                 :padding 10}
                         :underlay-color "#eee"
                         :on-press (fn [] (if in?
                                           (dispatch [:jump-in-channel-conversation (clj->js channel)])
                                           (show-actions channel in?)))
                         :on-long-press (fn [] (show-actions channel in?))}
      [view {:key id
             :style {:flex-direction "row"}}
       (if (and picture (not stretch?))
         [image {:source {:uri picture}
                 :style {:width channel-width
                         :height channel-width
                         :resizeMode "cover"
                         :border-radius 4}}]

         [view {:style {:width channel-width
                        :height channel-width
                        :border-radius 4
                        :background-color "rgba(255,255,255,1)"
                        :flex 1
                        :align-items "center"
                        :justify-content "center"}}
          [text {:style {:font-size 18
                         :fontFamily "Times New Roman"
                         :align-self "center"}}
           name]])]])))

(defn scroll-cp
  ([channels]
   (scroll-cp channels false))
  ([channels in?]
   [scroll
    {:automaticallyAdjustContentInsets false
     :horizontal true
     :scrollEventThrottle 200}
    (for [channel channels]
      ^{:key (:id channel)} [channel-cp channel in?])]))

(defn filter-joined
  [channels joined-ids]
  (remove (fn [channel]
            (contains? (set joined-ids) (str (:id channel))))
          channels))

(defn search-channel-cp
  [{:keys [id name picture type] :as channel}]
  (let [{:keys [width]} (js->clj (.get dimensions "window") :keywordize-keys true)
        channel-width (adapt-width width)]
    [touchable-opacity {:underlay-color "#eee"
                        :on-press (fn [] (show-actions channel false
                                                      #(do
                                                         (util/show-header)
                                                         (util/show-statusbar)
                                                         (dispatch [:nav/pop]))))}
     [view {:key id
            :style {:flex 1
                    :flex-direction "row"
                    :padding 6}}
      (if picture
        [view {:style {:flex-direction "row"
                       :background-color "#FFF"
                       :flex 1
                       :padding 6}}
         [image {:source {:uri picture}
                 :style {:width channel-width
                         :height channel-width
                         :resizeMode "cover"
                         :border-radius 4}}]
         [view {:style {:flex 1
                        :justify-content "center"
                        :padding-left 10}}
          [text {:style {:font-size 18
                         :fontFamily "Times New Roman"}}
           name]]]
        [view {:style {:width channel-width
                       :height channel-width
                       :border-radius 4
                       :background-color "#FFF"
                       :flex 1
                       :align-items "center"
                       :justify-content "center"}}
         [text {:style {:font-size 18
                        :fontFamily "Times New Roman"
                        :align-self "center"}}
          name]])]]))

(defn keyboard-will-show-handler
  [e visible-height]
  (let [new-height (- (.-height (.get dimensions "window"))
                      (aget e "endCoordinates" "height"))]
    (reset! visible-height new-height)))

(defn keyboard-will-hide-handler
  [e visible-height]
  (let [new-height (.-height (.get dimensions "window"))]
    (reset! visible-height new-height)))

(defn search-cp
  []
  (let [current-input (subscribe [:channels-search-input])
        visible-height (r/atom (.-height (.get dimensions "window")))
        channels (subscribe [:channels-search-result])
        ds (.-DataSource (.-ListView react-native))
        list-view-ds (new ds #js {:rowHasChanged #(not= %1 %2)})]
    (.addListener device-event-emitter "keyboardWillShow" (fn [e] (keyboard-will-show-handler e visible-height)))
    (.addListener device-event-emitter "keyboardWillHide" (fn [e] (keyboard-will-hide-handler e visible-height)))
    (fn []
      [view {:style (if (ui/android?)
                      {:flex 1
                       :background-color "#efefef"}
                      {:flex 1
                       :background-color "rgba(255,255,255,0.8)"
                       :height (- @visible-height 20)
                       :top 20})}
       (when (ui/ios?)
         [view {:style {:flex-direction "row"
                        :margin-top -12}}
          [material-icon-button {:name "arrow-back"
                                 :on-press (fn []
                                             (util/show-header)
                                             (util/show-statusbar)
                                             (dispatch [:nav/pop]))
                                 :size 40
                                 :background-color "transparent"
                                 :color "rgba(0,0,0,0.7)"}]

          [input {:style (:no-border-input styles)
                  :auto-focus true
                  :auto-correct false
                  :clear-button-mode "always"
                  :value @current-input
                  :on-change-text (fn [value]
                                    (dispatch [:reset-channels-search-input value])
                                    (dispatch [:load-channels-search-result value]))
                  :placeholder "Search groups"}]])

       (when (and (not (empty? @channels))
                  (not (str/blank? @current-input)))
         [view {:style {:flex 1
                        :padding-top 6
                        :background-color "#efefef"}}
          [list-view {:keyboardShouldPersistTaps true
                      :enableEmptySections true
                      :automaticallyAdjustContentInsets false
                      :dataSource (.cloneWithRows list-view-ds (clj->js @channels))
                      :renderRow (fn [row]
                                   (r/as-element [search-channel-cp (js->clj row :keywordize-keys true)]))
                      :renderSeparator (fn [section-id row-id]
                                         (if (ui/ios?)
                                           (r/as-element
                                            [view {:key (str section-id "-" row-id)
                                                   :style {:height 0.5
                                                           :background-color "#ccc"}}])
                                           (r/as-element
                                            [view])))}]])]))
  )

(defn groups-cp
  []
  (let [current-input (subscribe [:channels-search-input])
        channels (subscribe [:channels-search-result])
        current-user (subscribe [:current-user])
        other-channels (subscribe [:recommend-channels])]
    (fn []
      (if (and (not (str/blank? @current-input))
               (seq @channels))
        [search-cp]

        (let [chinese? (= "Chinese" (:language @current-user))
              joined-channels (:channels @current-user)
              channels-ids (set (map (comp str :id) joined-channels))
              nba-exists? (seq (filter #(= "nba" (:type %)) joined-channels))
              place-exists? (seq (filter #(or (= "place" (:type %))
                                              (= "chinese-place" (:type %))) joined-channels))
              country-exists? (seq (filter #(= "country" (:type %)) joined-channels))]
          [view {:style {:flex 1
                         :background-color "#efefef"}}
           [view {:style (pl-style :channels)}
            [scroll {:padding-top 10
                     :automaticallyAdjustContentInsets false}
             [scroll-cp joined-channels true]

             (when-not country-exists?
               (let [channels (-> (:countries recommend-channels)
                                  (filter-joined channels-ids))]
                 [scroll-cp channels]))

             (let [channels (if chinese?
                              (get recommend-channels :chinese-places)
                              (let [channels (get recommend-channels :places)
                                    top-50-channels (take 50 channels)
                                    top-100-channels (take 50 (drop 50 channels))]
                                (concat
                                 (repeatedly 10 #(rand-nth top-50-channels))
                                 (repeatedly 10 #(rand-nth top-100-channels)))))
                   channels (filter-joined channels channels-ids)]
               [scroll-cp channels])

             (when-not nba-exists?
               (let [channels (-> (:nba recommend-channels)
                                  (filter-joined channels-ids))]
                 [scroll-cp channels]))

             [view {:style {:margin-bottom 10}}
              (let [channels (-> @other-channels
                                 (filter-joined channels-ids))]
                (for [channel channels]
                  ^{:key (:id channel)} [channel-cp channel false true]))]]]])))))
