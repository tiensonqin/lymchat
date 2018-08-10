(ns api.pg.spatial
  ":require [api.pg.spatial :as st]"
  (:import [org.postgis Geometry PGgeometryLW PGgeometry LineString LinearRing MultiLineString MultiPoint MultiPolygon Point Polygon]))

(defn srid
  "Returns the set SRID of a geometry object"
  [^Geometry geometry]
  (.getSrid geometry))

(defn with-srid!
  "Return the geometry object with SRID set. Alters the object."
  [^Geometry geometry srid]
  (doto geometry
    (.setSrid ^int srid)))

(defn- pointy-structure?
  [x]
  (or (instance? Point x)
      (and (coll? x)
           (>= (count x) 2)
           (<= (count x) 3)
           (every? number? (map number? x)))))

(defn point
  "Make a 2D or 3D Point."
  ([x y]
    (Point. x y))
  ([x y z]
    (Point. x y z))
  ([coll-or-str]
    (cond (instance? Point coll-or-str) coll-or-str
          (coll? coll-or-str) (let [x (first coll-or-str)
                                    y (second coll-or-str)]
                                (if-let [z (nth coll-or-str 2 nil)]
                                  (Point. x y z)
                                  (Point. x y)))
          :else (Point. (str coll-or-str)))))

(defn multi-point
  "Make a MultiPoint from collection of Points."
  [points]
  (cond (instance? MultiPoint points) points
        (coll? points) (MultiPoint. (into-array Point (map point points)))
        :else (MultiPoint. (str points))))

(defn line-string
  "Make a LineString from a collection of points."
  [points]
  (cond (instance? LineString points) points
        (coll? points) (LineString. (into-array Point (map point points)))
        :else (LineString. (str points))))

(defn multi-line-string
  "Make a MultiLineString from a collection of LineStrings."
  [line-strings]
  (cond (instance? MultiLineString line-strings) line-strings
        (coll? line-strings) (MultiLineString. (into-array LineString (map line-string line-strings)))
        :else (MultiLineString. (str line-strings))))

(defn linear-ring
  "Used for constructing Polygons from Points."
  [points]
  (cond (instance? LinearRing points) points
        (coll? points) (LinearRing. (into-array Point (map point points)))
        :else (LinearRing. (str points))))

(defn polygon
  "Make a Polygon from a collection of Points."
  [linear-rings]
  (cond (instance? Polygon linear-rings) linear-rings
        (coll? linear-rings) (Polygon. (into-array LinearRing (map linear-ring linear-rings)))
        :else (Polygon. (str linear-rings))))

(defn multi-polygon
  "Make a MultiPolygon from collection of Polygons."
  [polygons]
  (cond (instance? MultiPolygon polygons) polygons
        (coll? polygons) (MultiPolygon. (into-array Polygon (map polygon polygons)))
        :else (MultiPolygon. (str polygons))))

(defn pg-geom
  [geometry]
  (PGgeometryLW. geometry))
