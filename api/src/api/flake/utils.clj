(ns api.flake.utils
  (:require [primitive-math :as p])
  (:import [java.net NetworkInterface]
           [java.nio ByteBuffer]))

(def ^{:const true} one-million 1000000)

(def ^{:const true :private true}
  base62-alphabet
  "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")

(defn encode
  "Encodes n in a new base of ks."
  [ks n]
  (let [base (count ks)]
    (->> (iterate #(quot % base) n)
         (take-while pos?)
         (reduce (fn [acc n]
                   (conj acc (nth ks (mod n base))))
                 nil)
         (apply str))))

(def ^{:doc "Encodes a given value into a base62 representation."}
  base62-encode
  (partial encode base62-alphabet))

(defn byte-buffer
  ^{:tag java.nio.ByteBuffer
    :doc "Returns a ByteBuffer allocated to be size."}
  [size]
  (ByteBuffer/allocate size))

(defn now
  "Returns the current Unix time in milliseconds."
  []
  (System/currentTimeMillis))

;; Borrowed from Skuld--thanks, Kyle!
(defn epoch
  "Returns the delta between the Unix time in milliseconds and nanoTime."
  []
  (-> one-million
      (* (now))
      (- (System/nanoTime))))

(defn epoch-mean
  "Takes N samples of epoch and returns the mean."
  [n]
  (-> (->> (repeatedly epoch)
           (map double)
           (take n)
           (reduce +))
      (/ n)
      long))

(defn now-from-epoch
  "Returns the estimated current time in milliseconds from epoch."
  [e]
  (-> ^long e
      (p/+ (System/nanoTime))
      (p/div one-million)))

(defn get-hardware-addresses
  "Returns a sequence of hardware addresses (generally MACs) formatted as byte
  arrays which have been filtered such that they do not contain nil or
  `0.0.0.0.0.0`."
  []
  (->> (NetworkInterface/getNetworkInterfaces)
       enumeration-seq
       (map (fn [^NetworkInterface ni] (.getHardwareAddress ni)))
       (filter identity)
       (remove #(every? zero? %))))
