(ns api.flake.core
  "A decentralized, k-ordered unique ID generator.
  This is a port of Boundary's eponymous Erlang unique ID service. The format
  of the IDs is as follows:
    41 bits - ts (i.e. a timestamp)
    12 bits - worker-id (i.e. MAC address)
    10 bits - seq-no (i.e. a counter)
  ts is a timestamp derived from System/nanoTime with millisecond resolution,
  worker-id is the MAC address of the machine, and seq-no is a sequence of
  numbers usually initialized to the minimum value.
  Whenever an ID is requested within the same millisecond as a previous ID,
  seq-no is incremented otherwise it is reset to its minimum value. Since
  seq-no is a short this allows for 2^16-1 unique IDs per millisecond per
  machine.
  New IDs may be generated with the `generate!` function, however before doing
  so, `init!` should be executed. Using `init!` helps to ensure that duplicate
  IDs are not generated on a given machine by checking that the current
  timestamp exceeds the last timestamp written to disk.
  For example:
    => (require '[flake.core :as flake])
    => (flake/init!)
    => (flake/flake->bigint (take 10 (repeatedly flake/generate!)))
    (25981799066832176213716719468544N ...)
  Calling `generate!` will yield a ByteBuffer of 128 bits. This in turn can
  be converted to a BigInteger via `flake->bigint`. Because these numbers are
  long, it may be desirable to encode them in a shorter representation. To
  facilitate this, `flake.utils` provides a base62 encoder.
  For example:
    => (require '[flake.utils :as utils])
    => (->> (repeatedly flake/generate!)
            (take 3)
            flake/flake->bigint
            utils/base62-encode)
    (\"8n0RhygzZ84kHHLw1I\" \"8n0RhygzZ84kHHLw1J\" \"8n0RhyhLXoMKINWDZY\")"
  (:require [api.flake.timer     :as timer]
            [api.flake.utils     :as utils]
            [primitive-math  :as p])
  (:import [java.nio ByteBuffer]))


;; Simple container for all the bits necessary to assemble a flake ID.
;;
(deftype Flake [^long ts ^bytes worker-id ^short seq-no])

(defonce ^{:private true}
  default-epoch 1466577521161)

(defonce ^{:private true} sequence-bits  12)
(defonce ^{:private true} worker-id-bits  10)
(defonce ^{:private true} worker-id-shift sequence-bits)
(defonce ^{:private true} timestamp-left-shift (+ sequence-bits worker-id-bits))
(defonce ^{:private true} sequence-max 4096)

(defonce ^{:private true}
  default-worker-id 0)

;; (defonce ^{:private true}
;;   flake (atom (Flake. Long/MIN_VALUE default-worker-id 0)))
(def flake (atom (Flake. Long/MIN_VALUE default-worker-id 0)))

;; Generator.
;;
(defn generate-flake!
  "Given an atom containing a Flake, a timestamp, and a worker ID, returns
  a Flake where the sequence has either been incremented or reset. An
  IllegalStateException will be thrown if the provided timestamp appears to be
  in the past--e.g. in multi-threaded contexts, where one thread has won a race
  to alter the state of the Flake."
  [f ^long ts worker-id]
  (swap! f
         (fn [^Flake s]
           (cond
             (= ts (.ts s))
             (Flake. ts worker-id (inc (.seq-no s)))

             (> ts (.ts s))
             (Flake. ts worker-id 0)


             :else (throw (IllegalStateException. "time cannot flow backwards."))))))

(defn generate!
  "Generate a new long id from a Flake. An optional worker-id can be
  provided, otherwise the default uses a valid hardware interface. Returns the
  ByteBuffer which contains a fully formed Flake."
  ([]
   (generate! default-worker-id default-epoch))
  ([worker-id]
   (generate! worker-id default-epoch))
  ([worker-id epoch]
   (let [bs (try
              (let [ts (utils/now-from-epoch epoch)
                    ^Flake f (generate-flake! flake ts worker-id)]
                (bit-or
                 (bit-shift-left (.ts f) timestamp-left-shift)
                 (bit-shift-left (.worker-id f) worker-id-shift)
                 (.seq-no f)))
              (catch IllegalStateException _ ::illegal-state))]
     (if (= bs ::illegal-state)
       (recur worker-id epoch)
       bs))))

;; Initializer.
;;
(defn init!
  "Ensures path contains a timestamp that is less than the current Unix time in
  milliseconds. This should be called before generating new IDs!"
  ([]
   (init! "/tmp/flake-timestamp-dets" default-epoch))
  ([path]
   (init! path default-epoch))
  ([path epoch]
   (assert (> epoch (timer/read-timestamp path))
           "persisted time is in the future.")
   (timer/write-timestamp path flake epoch)))
