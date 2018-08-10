(ns api.core
  (:require [plumbing.core :refer :all]
            [clojure.tools.cli :refer [parse-opts]]
            [aleph.http :as http]
            [fnhouse.handlers :as handlers]
            [fnhouse.middleware :as middleware]
            [fnhouse.routes :as routes]
            [taoensso.timbre :as timbre]
            [taoensso.timbre.appenders.core :as appenders]
            [api.middlewares.ring :as ring]
            [api.schema.coerce :as sc]
            [api.util :refer [production?]]
            [api.repl :as repl]
            [api.tasks :as tasks]
            [api.fnhouse.swagger :as swagger]
            [api.handler.ws :as ws]
            [api.handler.auth]
            [api.handler.me]
            [api.handler.invite]
            [api.handler.report]
            [api.handler.channel]
            [api.handler.admin]
            [api.handler.admin.auth])
  (:gen-class))

(defn custom-coercion-middleware
  "Wrap a handler with the schema coercing middleware"
  [handler]
  (middleware/coercion-middleware
   handler
   sc/input-coercer
   sc/output-coercer))

(defn attach-docs [resources prefix->ns-sym]
  (let [prefix->ns-sym (if (production?)
                         prefix->ns-sym
                         (assoc prefix->ns-sym
                                "" 'api.fnhouse.swagger))
        proto-handlers (handlers/nss->proto-handlers prefix->ns-sym)]
    (if (production?)
      ((handlers/curry-resources proto-handlers) resources)
      (let [swagger-ns (dissoc prefix->ns-sym "" "notify")
            swagger-handlers (-> swagger-ns
                                 handlers/nss->proto-handlers)
            swagger (swagger/collect-routes swagger-handlers
                                            swagger-ns)]
        (-> resources
            (assoc :swagger swagger)
            ((handlers/curry-resources proto-handlers)))))))

(defn wrapped-root-handler
  "Take the resources, partially apply them to the handlers in
  the 'api.handler namespace, wrap each with a custom
  coercing middleware, and then compile them into a root handler
  that will route requests to the appropriate underlying handler."
  [resources]
  (let [routes {"v1/auth" 'api.handler.auth
                "v1/me" 'api.handler.me
                "v1/invites" 'api.handler.invite
                "v1/reports" 'api.handler.report
                "v1/channels" 'api.handler.channel
                "auth" 'api.handler.admin.auth
                "admin" 'api.handler.admin}]
    (->> (attach-docs resources routes)
         (map custom-coercion-middleware)
         routes/root-handler)))

(defn app-handler
  [resources]
  (-> (fn [req]
        (if (= "/ws" (:uri req))
          (ws/ring-ajax-get-or-ws-handshake req)
          ((wrapped-root-handler resources) req)))
      ring/ring-middleware))

(defn start-api
  "Take resources and server options, and spin up a server with jetty"
  [resources]
  (if (production?)
    (app-handler resources)
    (swagger/wrap-swagger-ui
     (app-handler resources))))

(defonce server (atom nil))

(defn stop-server []
  (when-not (nil? @server)
    (.close @server)))

(def app (start-api nil))

(def cli-options
  ;; An option with a required argument
  [["-p" "--port PORT" "Port number"
    :default 8089
    :parse-fn #(Integer/parseInt %)
    :validate [#(< 0 % 0x10000) "Must be a number between 0 and 65536"]]
   ;; A boolean option defaulting to nil
   ["-h" "--help"]])

(defn -main
  [& args]
  (let [opts (parse-opts args cli-options)]
    (timbre/merge-config! {:appenders {:spit (appenders/spit-appender {:fname "/var/log/lymchat/api.log"})}})

    (tasks/run)

    (reset! server (http/start-server #'app {:port (get-in opts [:options :port])}))

    ;; todo restart router
    (ws/start-router!)

    (repl/start-server nil)
    (prn "Lymchat API started!")))
