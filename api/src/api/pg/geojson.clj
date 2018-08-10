(ns api.pg.geojson
  (:require [schema.core :as s]))

;;
;; GeoJSON as Primatic Schema
;;

(s/defschema NamedCRS
  {:type (s/eq :name)
   :properties {:name s/Str}})

(s/defschema LinkedCRS
  {:type (s/eq :link)
   :properties {:href s/Str
                :type s/Str}})

(s/defschema CRS
  "Coordinate Reference System - default is WGS84 if not defined."
  (s/either NamedCRS LinkedCRS))

(s/defschema BBox
  [s/Num])

(s/defschema Position
  [s/Num])

(s/defschema Point
  "GeoJSON Point"
  {:type (s/eq :Point)
   :coordinates Position
   (s/optional-key :crs) CRS
   (s/optional-key :bbox) BBox})

(s/defschema MultiPoint
  "GeoJSON MultiPoint"
  {:type (s/eq :MultiPoint)
   :coordinates [Position]
   (s/optional-key :crs) CRS
   (s/optional-key :bbox) BBox})

(s/defschema LineStringCoords
  [(s/one Position 'p1) (s/one Position 'p2) Position])

(s/defschema LineString
  "GeoJSON LineString"
  {:type (s/eq :LineString)
   :coordinates LineStringCoords
   (s/optional-key :crs) CRS
   (s/optional-key :bbox) BBox})

(s/defschema MultiLineString
  "GeoJSON MultiLineString"
  {:type (s/eq :MultiLineString)
   :coordinates [LineStringCoords]
   (s/optional-key :crs) CRS
   (s/optional-key :bbox) BBox})

(s/defschema LinearRingCoords
  "LinearRing coordinate array used for building polygons.
   The first and last positions must be equivalent."
  [(s/one Position 'p1) (s/one Position 'p2) (s/one Position 'p3) (s/one Position 'p4) Position])

(s/defschema PolygonCoords
  [LinearRingCoords])

(s/defschema Polygon
  "GeoJSON Polygon"
  {:type (s/eq :Polygon)
   :coordinates PolygonCoords
   (s/optional-key :crs) CRS
   (s/optional-key :bbox) BBox})

(s/defschema MultiPolygon
  "GeoJSON MultiPolygon"
  {:type (s/eq :MultiPolygon)
   :coordinates [PolygonCoords]
   (s/optional-key :crs) CRS
   (s/optional-key :bbox) BBox})

(declare GeometryCollection)

(s/defschema Geometry
  (s/either Point MultiPoint LineString MultiLineString Polygon MultiPolygon (s/recursive #'GeometryCollection)))

(s/defschema GeometryCollection
  {:type (s/eq :GeometryCollection)
   :geometries [Geometry]})

(s/defschema Feature
  {:geometry (s/maybe Geometry)
   :properties (s/maybe {})
   (s/optional-key :id) s/Any})

(s/defschema FeatureCollection
  {:features [Feature]})

;;
;; Predicates
;;


(defn schema-pred
  [schema m]
  (try (s/validate schema m)
    true
    (catch Exception e
      false)))

(defn point?
  [m]
  (schema-pred Point m))

(defn point
  [& coords]
  {:post [(s/validate Point %)]}
  {:type :Point
   :coordinates (into [] coords)})

(defn multi-point
  [points]
  {:pre [(coll? points)]
   :post [(s/validate MultiPoint %)]}
  {:type :MultiPoint
   :coordinates nil})
