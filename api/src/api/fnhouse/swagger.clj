(ns api.fnhouse.swagger
  (:require
    [plumbing.core :refer :all]
    [ring.swagger.swagger2 :as swagger]
    [ring.swagger.ui :as swagger-ui]
    [ring.swagger.middleware :refer [comp-mw]]
    [clojure.set :refer [map-invert]]
    [schema.core :as s]))

;;
;; Internals
;;

(defn- convert-parameters [request]
  (let [parameters (for-map [[type f] {:body :body, :query :query-params, :path :uri-args}
                             :let [model (f request)]
                             :when (and model (not (empty? model)))]
                     type model)]
    (if-not (empty? parameters)
      {:parameters parameters})))

(defn- convert-responses [responses]
  (let [responses (for-map [[code model] responses
                            :let [message (or (some-> model meta :message) "")]]
                    code {:description message, :schema model})]
    (if-not (empty? responses)
      {:responses responses})))

(defn- ignore-ns? [ns-sym]
  (:no-doc (meta (the-ns ns-sym))))

(defn- collect-route [ns-sym->prefix extra-metadata-fn routes annotated-handler]
  (letk [[[:info method path description request responses annotations
           [:source-map ns]]] annotated-handler]
    (let [ns-sym (symbol ns)
          prefix (ns-sym->prefix ns-sym)]
      (if (ignore-ns? ns-sym)
        routes
        (assoc-in routes [path method]
                  (merge (extra-metadata-fn annotations)
                         (convert-responses responses)
                         (convert-parameters request)
                         {:tags        [prefix]
                          :summary     description}))))))

;;
;; Public API
;;

(defn collect-routes
  "Parameters:
  - seq of fnhouse AnnotatedProtoHandlers
  - prefix->ns-sym map
  - top-level extra swagger parameters to be used as a baseline, defaults to {}
  - extra function (like fnhouse extra-info-fn). It takes contents of :annotations
  field on handler and returns a map that will be merged into
  ring-swagger's Operation-data. Such function can be used to obtain Swagger auth
  spec from fnhouse's handler or to override any fnhouse-swagger-derived
  metadata."
  ([handlers prefix->ns-sym]
    (collect-routes handlers prefix->ns-sym {}))
  ([handlers prefix->ns-sym base]
    (collect-routes handlers prefix->ns-sym base (constantly {})))
  ([handlers prefix->ns-sym extra-parameters extra-metadata-fn]
    (let [ns-sym->prefix (map-invert prefix->ns-sym)
          route-collector (partial collect-route ns-sym->prefix extra-metadata-fn)
          routes (reduce route-collector {} handlers)]
      (assoc extra-parameters :paths routes))))

(def wrap-swagger-ui
  (comp-mw swagger-ui/wrap-swagger-ui :swagger-docs "swagger.json"))

;;
;; Swagger 2.0 Endpoint
;;

(defnk $swagger.json$GET
  "Swagger 2.0 Specs"
  {:responses {200 s/Any}}
  [[:resources swagger]]
  {:body (-> (swagger/swagger-json swagger)
             (update-in [:paths] #(into (sorted-map) %)))})
