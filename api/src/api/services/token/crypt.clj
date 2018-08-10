(ns api.services.token.crypt
  (:require [clojure.data.codec.base64 :as b64])
  (:import (javax.crypto KeyGenerator SecretKey Cipher SecretKeyFactory)
           (javax.crypto.spec SecretKeySpec PBEKeySpec)))

(defonce salt "fdjalfjlafjlkajf")

(defn cipher- [] (. Cipher getInstance "AES"))
(defn aes-keyspec [rawkey] (new SecretKeySpec rawkey "AES"))

(defn encrypt-
  [rawkey plaintext]
  (let [cipher (cipher-)
        mode (. Cipher ENCRYPT_MODE)]
    (. cipher init mode (aes-keyspec rawkey))
    (-> (. cipher doFinal (. plaintext getBytes))
        b64/encode
        (String.))))

(defn decrypt-
  [rawkey ciphertext]
  (let [ciphertext (b64/decode  (.getBytes ciphertext))
        cipher (cipher-)
        mode (. Cipher DECRYPT_MODE)]
    (. cipher init mode (aes-keyspec rawkey))
    (new String(. cipher doFinal ciphertext))))

(defn passkey
  [password & [iterations size]]
  (let [keymaker (SecretKeyFactory/getInstance "PBKDF2WithHmacSHA1")
        pass (.toCharArray password)
        salt (.getBytes salt)
        iterations (or iterations 1000)
        size (or size 128)
        keyspec (PBEKeySpec. pass salt iterations size)]
    (-> keymaker (.generateSecret keyspec) .getEncoded)))

(defn encrypt
  [password plaintext]
  (encrypt- (passkey password) plaintext))

(defn decrypt
  [password cyphertext]
  (decrypt- (passkey password) cyphertext))
