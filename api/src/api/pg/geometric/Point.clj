(ns api.pg.geometric.Point
  "Example implementation of a PGobject that also implements
   Clojure's ISeq and shows as a sequence of two numbers."
  (:gen-class
    :extends org.postgresql.geometric.PGpoint
    :implements [clojure.lang.Counted clojure.lang.ISeq]
    :main false))

(defn to-list
  [^org.postgresql.geometric.PGpoint this]
  (list (.-x this) (.-y this)))

(defn -count
  [this]
  (.count (to-list this)))

(defn -first
  [this]
  (.first (to-list this)))

(defn -next
  [this]
  (.next (to-list this)))

(defn -more
  [this]
  (.more (to-list this)))

(defn -empty
  [this]
  (.empty (to-list this)))

(defn -equiv
  [this other]
  (.equiv (to-list this) (to-list other)))

(defn -seq
  [this]
  (.seq (to-list this)))
