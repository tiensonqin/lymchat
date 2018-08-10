(ns api.pg.pgpass
  "Logic for matching passwords ~/.pgpass passwords to db specs."
  (:require [clojure.java.io :as io]
            [clojure.string :as str]))

(defn parse-pgpass-line
  "The .pgpass files has lines of format: hostname:port:database:username:password
  Return a map of fields {:pg-hostname \"*\" ...}"
  [s]
  (zipmap
   [:pg-hostname :pg-port :pg-database :pg-username :pg-password]
   (str/split s #":")))

(defn read-pgpass
  "Find ~/.pgpass, read it and parse lines into maps"
  []
  (let [homedir (io/file (System/getProperty "user.home"))
        passfile (io/file homedir ".pgpass")]
    (when (.isFile passfile)
      (with-open [r (io/reader passfile)]
        (->> r
             line-seq
             (map parse-pgpass-line)
             doall)))))

(defn pgpass-matches?
  "(filter (partial pgpass-matches? spec) pgpass-lines)"
  [{:keys [host port dbname user]} {:keys [pg-hostname pg-port pg-database pg-username pg-password]}]
  (when
      (and
       (or (= pg-hostname "*") (= pg-hostname host) (and (= pg-hostname "localhost") (nil? host)))
       (or (= pg-port "*") (= pg-port port) (and (= pg-port "5432") (nil? port)))
       (or (= pg-database "*") (= pg-database dbname))
       (or (= pg-username "*") (= pg-username user)))
    pg-password))

(defn pgpass-lookup
  "Look up password from ~/.pgpass based on db spec {:host ... :port ... :dbname ... :user ...}"
  [spec]
  (when-let [match (first (filter (partial pgpass-matches? spec) (read-pgpass)))]
    (:pg-password match)))
