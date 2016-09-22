(defproject lymchat "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url  "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [org.clojure/clojurescript "1.9.36"]
                 [org.clojure/core.async "0.2.385"]
                 [com.taoensso/sente "1.10.0-SNAPSHOT"]
                 [com.taoensso/encore      "2.64.1"]
                 [org.clojure/tools.reader "0.10.0"]
                 [com.taoensso/timbre      "4.6.0"]
                 [reagent "0.6.0-SNAPSHOT" :exclusions [cljsjs/react cljsjs/react-dom cljsjs/react-dom-server]]
                 [re-frame "0.7.0"]
                 [prismatic/schema "1.0.4"]
                 [com.andrewmcveigh/cljs-time "0.4.0"]]
  :plugins [[lein-cljsbuild "1.1.1"]
            [lein-figwheel "0.5.4-4"]]
  :clean-targets ["target/" "index.ios.js" "index.android.js"]
  :aliases {"prod-build" ^{:doc "Recompile code with prod profile."}
            ["do" "clean"
             ["with-profile" "prod" "cljsbuild" "once" "ios"]
             ["with-profile" "prod" "cljsbuild" "once" "android"]]

            "android-prod-build"
            ["do" "clean"
             ["with-profile" "prod" "cljsbuild" "once" "android"]]

            "ios-prod-build"
            ["do" "clean"
             ["with-profile" "prod" "cljsbuild" "once" "ios"]]
            }
  :profiles {:dev {:dependencies [[figwheel-sidecar "0.5.4-4"]
                                  [com.cemerick/piggieback "0.2.1"]]
                   :source-paths ["src" "env/dev"]
                   :cljsbuild    {:builds [{:id :ios
                                            :source-paths ["src" "env/dev"]
                                            :figwheel     true
                                            :compiler     {:output-to     "target/ios/not-used.js"
                                                           :main          "env.ios.main"
                                                           :output-dir    "target/ios"
                                                           :optimizations :none}}
                                           {:id :android
                                            :source-paths ["src" "env/dev"]
                                            :figwheel     true
                                            :compiler     {:output-to     "target/android/not-used.js"
                                                           :main          "env.android.main"
                                                           :output-dir    "target/android"
                                                           :optimizations :none}}]}
                   :repl-options {:nrepl-middleware [cemerick.piggieback/wrap-cljs-repl]}}
             :prod {:cljsbuild {:builds {:ios     {:source-paths ["src" "env/prod"]
                                                   :compiler     {:output-to     "index.ios.js"
                                                                  :main          "env.ios.main"
                                                                  :output-dir    "target/ios"
                                                                  :static-fns    true
                                                                  :optimize-constants true
                                                                  :optimizations :simple
                                                                  :closure-defines {"goog.DEBUG" false}}}
                                         :android {:source-paths ["src" "env/prod"]
                                                   :compiler     {:output-to     "index.android.js"
                                                                  :main          "env.android.main"
                                                                  :output-dir    "target/android"
                                                                  :static-fns    true
                                                                  :optimize-constants true
                                                                  :optimizations :simple
                                                                  :closure-defines {"goog.DEBUG" false}}}}}
                    }})
