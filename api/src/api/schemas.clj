(ns api.schemas
  "Schemas and constructors that are used"
  (:require api.schema.util
            [potemkin.namespaces :as p]
            [schema.core :as s]))

(p/import-vars [api.schema.util
                optional
                part
                without-id])

(p/import-macro api.schema.util/wrap)

(s/defschema Ack
  "Simple acknowledgement for successful requests"
  {:message (s/eq "OK")})

(def ack
  {:status 200
   :body {:message "OK"}})

(def created
  {:status 201
   :body {:message "Created"}})

(def not-found
  {:status 404
   :body {:message "Not Found"}})

(s/defschema Missing
  {:message s/Str})

(s/defschema NotFound
  {:message s/Str})

(s/defschema Wrong
  {:message s/Any
   (s/optional-key :data) s/Any})

(s/defschema Forbidden
  {:message s/Any})

(def Unauthorized s/Str)

(s/defn unauthorized
  ([]
   (unauthorized "access denied (authorization)"))
  ([message :- s/Str]
   {:status 401
    :body message}))

;; 1. {:message "email format is error"}
;; 2. {:message {:email "email is wrong",
;;               :password "password is wrong"}}
;; 3. {:message "art is not sale",
;;     :data [{:id 1,
;;             :error "not sale"}]}
(s/defn bad
  "error could be `string' or `map'."
  ([error :- s/Any]
   {:status 400
    :body {:message error}})
  ([error :- s/Any data :- s/Any]
   {:status 400
    :body {:message error
           :data data}}))

(s/def ID s/Uuid)

(s/def NonBlankStr s/Str
  ;; (s/pred (complement clojure.string/blank?) "non-blank-string")
  )

(s/defschema Token {:token NonBlankStr
                    (s/optional-key :refresh_token) NonBlankStr})

(s/defschema OauthType (s/enum "facebook" "google" "wechat"))
(s/defschema User {:id ID
                   :username NonBlankStr
                   :name NonBlankStr
                   :avatar (s/maybe NonBlankStr)
                   :oauth_type OauthType
                   :oauth_id NonBlankStr
                   :language (s/maybe NonBlankStr)
                   :timezone (s/maybe s/Int)
                   :status (s/maybe s/Str)
                   :block s/Bool
                   :no_invite s/Bool
                   :contacts [s/Uuid]
                   :channels [s/Uuid]
                   :created_at java.util.Date
                   :last_seen_at java.util.Date})

(s/defschema NewUser (select-keys User [:username :name :avatar :oauth_type :oauth_id :timezone]))

(s/defschema NewUserWithCredentials (merge NewUser {:app-key s/Str
                                                    :app-secret s/Str}))


(s/defschema UserBare (select-keys User [:id :username :name :avatar :language]))

(s/defschema UserPatch (-> User
                           (select-keys [:name :username :avatar :language :no_invite :status :contacts :channels])
                           (part)))

(s/defschema UserToken {:token NonBlankStr
                        :user (part User)})

(s/defschema Invite {:user_id ID
                     :invite_id ID
                     :state (s/enum "pending" "accept" "reject" "archive")
                     :created_at java.util.Date})

(s/defschema UserInviteBare (assoc
                             (select-keys User [:id :name :avatar])
                             :state (:state Invite)))

(s/defschema Message {:id s/Str
                      :user_id s/Uuid
                      :to_id s/Uuid
                      :body s/Str
                      :created_at java.util.Date})

(s/defschema ChannelMessage {:id s/Str
                             :channel_id s/Uuid
                             :user_id s/Uuid
                             (s/optional-key :to_id) s/Uuid
                             :name s/Str
                             :username s/Str
                             :avatar s/Str
                             :language s/Str
                             :timezone s/Str
                             :body s/Str
                             :created_at java.util.Date})

(s/defschema Report {:id ID
                     :user_id ID
                     :type s/Str
                     :type_id ID
                     :title s/Str
                     :picture (s/maybe s/Str)
                     :description (s/maybe s/Str)
                     :data s/Any
                     :created_at java.util.Date})
(s/defschema NewReport
  (assoc (select-keys Report [:type :type_id :user_id :title])
         (s/optional-key :picture) (:picture Report)
         (s/optional-key :data) (:data Report)))


(s/defschema Channel {:id ID
                      :name s/Str
                      :user_id ID
                      :is_private s/Bool
                      :need_invite s/Bool
                      :purpose (s/maybe s/Str)
                      :members_count s/Int
                      :type s/Str
                      :picture (s/maybe s/Str)
                      :created_at java.util.Date})
(s/defschema NewChannel (select-keys Channel [:user_id :name :is_private :purpose :type :picture :need_invite]))
