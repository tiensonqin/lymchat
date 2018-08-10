(defproject api "0.1.0-SNAPSHOT"
  :description "Lymchat api server"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :main api.core
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [aleph "0.4.1"]
                 [com.taoensso/timbre "4.5.1"
                  :exclusions [org.clojure/tools.reader]]
                 [com.taoensso/encore "2.61.0"
                  :exclusions [org.clojure/tools.reader]]
                 [com.taoensso/sente "1.9.0-beta2"
                  :exclusions [org.clojure/tools.reader]]
                 [org.clojure/java.jdbc "0.6.1"]
                 [org.postgresql/postgresql "9.4-1201-jdbc41"]
                 [net.postgis/postgis-jdbc "2.2.0"
                  :exclusions [org.postgresql/postgresql
                               postgresql]]
                 [hikari-cp "1.7.1"
                  :exclusions [org.clojure/clojure
                               prismatic/schema]]

                 [ring/ring-core "1.4.0"
                  :exclusions [org.clojure/tools.reader]]
                 [ring/ring-json "0.4.0"]
                 [ring/ring-devel "1.4.0"]

                 [tiensonqin/fnhouse-hacks "0.1.2-SNAPSHOT"
                  :exclusions [prismatic/plumbing
                               prismatic/schema]]
                 [metosin/ring-swagger "0.22.8"]
                 [metosin/ring-swagger-ui "2.1.4-0"]
                 [clj-jwt "0.1.1"]

                 [environ-plus "0.2.1"]
                 [com.taoensso/carmine "2.7.1"]
                 [com.twitter/twitter-text "1.13.4"]
                 [hiccup "1.0.5"]
                 [javax.servlet/servlet-api "2.5"]
                 [org.clojure/tools.nrepl "0.2.10"]
                 [org.clojure/tools.cli "0.3.2"]

                 [ring-cors "0.1.7"]
                 [amazonica "0.3.74"]
                 [com.fasterxml.jackson.core/jackson-core "2.8.1"]]
  :profiles {:test {:dependencies [[org.clojure/test.check "0.9.0"]]}
             :dev {:dependencies [[org.clojure/test.check "0.9.0"]
                                  [enlive "1.1.6"]]}
             :ci {:dependencies [[org.clojure/test.check "0.9.0"]]}}
  :jvm-opts ["-Xmx1g" "-Duser.timezone=UTC"])
