(ns env
  (:require [environ.core :as environ]
            [environ-plus.core]
            [clojure.edn :as edn]
            [clojure.java.io :as io])
  (:import java.io.PushbackReader))

(defn- read-config-file [path]
  (try
    (with-open [r (-> path io/resource io/reader PushbackReader.)]
      (edn/read r))
    (catch Exception e
      (println (str "WARNING: edn-config: " (.getLocalizedMessage e))))))

(defn local-env [environment]
  (let [environment (name environment)
        config (read-config-file (format "config/%s.edn" environment))]
    (merge
     config
     environ/env
     {:environment (keyword environment)})))

(defn- switch-env
  [environment]
  (alter-var-root #'environ-plus.core/env (fn [x] (local-env environment))))

(defn switch-to-test!
  []
  (switch-env :test))

(defn switch-to-development!
  []
  (switch-env :development))

(defn remove-contacts
  []
  (api.db.user/update api.db.util/default-db #uuid "10000000-3c59-4887-995b-cf275db86343" {:contacts []})
  (api.db.user/update api.db.util/default-db #uuid "20000000-81c1-4f1a-aa22-eeb57d2eea98" {:contacts []})
  (api.db.user/update api.db.util/default-db #uuid "30000000-ecf6-484c-bade-4993662742ba" {:contacts []})
  (api.db.user/update api.db.util/default-db #uuid "40000000-ecf6-484c-bade-4993662742ba" {:contacts []})

  (comment
    (do
      (switch-to-development!)
      (remove-contacts)
      ))

  )
