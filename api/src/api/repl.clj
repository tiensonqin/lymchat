(ns api.repl
  "Live debug, copy from riemann."
  (:require [clojure.tools.nrepl.server :as nrepl]))

(defonce server nil)

(defn stop-server!
  "Stops the REPL server."
  []
  (when-let [s server]
    (nrepl/stop-server s))
  (def server nil))

(defn start-server!
  "Starts a new repl server. Stops the old server first, if any. Options:

  :host (default \"127.0.0.1\")
  :port (default 8988)"
  [opts]
  (stop-server!)
  (let [opts (merge {:port 8991 :host "127.0.0.1"} opts)]
    (def server (nrepl/start-server
                 :port (:port opts)
                 :bind (:host opts)))
    (prn "REPL server" opts "online")))

(defn start-server
  "Starts a new REPL server, when one isn't already running."
  [opts]
  (when-not server (start-server! opts)))
