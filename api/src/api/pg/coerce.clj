(ns api.pg.coerce
  (:require [api.pg.spatial :as st]))

(defmulti geojson->postgis :type)

(defmethod geojson->postgis :Point
  [m]
  (apply st/point (:coordinates m)))

(defmethod geojson->postgis :MultiPoint
  [m]
  (st/multi-point (:coordinates m)))

(defmethod geojson->postgis :LineString
  [m]
  (st/line-string (:coordinates m)))

(defmethod geojson->postgis :MultiLineString
  [m]
  (st/multi-line-string (:coordinates m)))

(defmethod geojson->postgis :Polygon
  [m]
  (st/polygon (:coordinates m)))

(defmethod geojson->postgis :MultiPolygon
  [m]
  (st/multi-polygon (:coordinates m)))

(defprotocol PostgisToCoords
  (postgis->coords [o]))

(extend-protocol PostgisToCoords
  org.postgis.Point
  (postgis->coords [o]
    (if (= (.dimension o) 3)
      [(.x o) (.y o) (.z o)]
      [(.x o) (.y o)]))
  org.postgis.MultiPoint
  (postgis->coords [o]
    (mapv postgis->coords (.getPoints o)))
  org.postgis.LineString
  (postgis->coords [o]
    (mapv postgis->coords (.getPoints o)))
  org.postgis.MultiLineString
  (postgis->coords [o]
    (mapv postgis->coords (.getLines o)))
  org.postgis.LinearRing
  (postgis->coords [o]
    (mapv postgis->coords (.getPoints o)))
  org.postgis.Polygon
  (postgis->coords [o]
    (mapv postgis->coords (for [i (range (.numRings o))] (.getRing o i))))
  org.postgis.MultiPolygon
  (postgis->coords [o]
    (mapv postgis->coords (.getPolygons o))))

(defprotocol PostgisToGeoJSON
  (postgis->geojson [o]))

(extend-protocol PostgisToGeoJSON
  org.postgis.Point
  (postgis->geojson [o]
    {:type :Point
     :coordinates (postgis->coords o)})
  org.postgis.MultiPoint
  (postgis->geojson [o]
    {:type :MultiPoint
     :coordinates (postgis->coords o)})
  org.postgis.LineString
  (postgis->geojson [o]
    {:type :LineString
     :coordinates (postgis->coords o)})
  org.postgis.MultiLineString
  (postgis->geojson [o]
    {:type :MultiLineString
     :coordinates (postgis->coords o)})
  org.postgis.Polygon
  (postgis->geojson [o]
    {:type :Polygon
     :coordinates (postgis->coords o)})
  org.postgis.MultiPolygon
  (postgis->geojson [o]
    {:type :MultiPolygon
     :coordinates (postgis->coords o)}))
