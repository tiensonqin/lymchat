(ns lymchat.db
  (:require [schema.core :as s :include-macros true]
            [lymchat.realm :as realm]))

(def NavigationState
  {:key s/Keyword
   :title s/Str
   s/Keyword s/Any})

(def NavigationParentState
  {:index    s/Int
   :routes [NavigationState]})

;; schema of app-db
(def schema {:nav NavigationParentState
             :current-user s/Any
             :current-tab s/Any
             :contact-search-input (s/maybe s/Str)
             :channels-search-input (s/maybe s/Str)
             :channels-search-result s/Any
             :username-input (s/maybe s/Str)
             :username-set? s/Bool
             :current-callee (s/maybe s/Str)
             :current-channel (s/maybe s/Str)
             :in-call? s/Bool
             :local-stream s/Any
             :remote-stream s/Any
             :header? s/Bool
             :signing? s/Bool
             :google-access? s/Bool
             :drawer s/Any

             :contacts s/Any

             :search-members-result s/Any
             :channel-auto-focus s/Bool
             :mentions s/Any

             :temp-avatar (s/maybe s/Str)
             ;; new message while in conversation
             :new-message? s/Bool
             :channel-messages s/Any
             :channel-members s/Any
             :photo-modal? s/Any
             :recommend-channels s/Any

             :conversations s/Any
             :invites s/Any
             :current-messages s/Any
             :loading? s/Bool
             :uploading? s/Bool
             :sync? s/Bool
             :open-video-call-modal? s/Bool
             :net-state (s/maybe s/Bool)
             :no-disturb? s/Bool
             :scroll-to-top? s/Bool
             :hidden-input s/Any
             :guide-step s/Any})


;; initial state of app-db
(def app-db {:nav {:index    0
                   :routes [{:key :lymchat
                             :title "Lymchat"}]}
             :current-user (realm/me)
             :conversations (realm/get-conversations)
             :invites (realm/get-invites)
             :current-tab "Lymchat"
             :contact-search-input nil
             :channels-search-input nil
             :username-input nil
             :hidden-input nil
             :net-state nil

             :open-video-call-modal? false
             :loading? false
             :uploading? false
             :sync? false
             :in-call? false
             :signing? false

             :no-disturb? (boolean (realm/kv-get "no-disturb?"))

             ;; posts
             :scroll-to-top? false

             ;; chat
             :current-messages []
             :new-message? false

             :google-access? true

             :current-channel nil
             :mentions nil

             ;; video call
             :current-callee nil
             :local-stream nil
             :remote-stream nil

             :channel-messages (realm/get-groups-messages)
             :channel-members {}
             :channels-search-result nil
             :channel-auto-focus false
             :recommend-channels []

             :photo-modal? {}

             :drawer {:open? false
                      :ref nil}
             :contacts (vec (realm/get-contacts))

             :temp-avatar nil
             :header? true
             :guide-step (realm/kv-get :guide-step)
             :username-set? (boolean (realm/kv-get :username-set?))
             :search-members-result nil})
