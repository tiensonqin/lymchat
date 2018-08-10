(ns api.pg.protocol
  (:use [clojure.pprint])
  (:import [java.net Socket]
           [java.io InputStream OutputStream ObjectInputStream ObjectOutputStream]
           [java.nio ByteBuffer]
           [java.nio.charset Charset]
           [java.nio.channels SocketChannel]
           [java.net InetSocketAddress]
           [java.security MessageDigest]))

(def ^:constant ^Charset UTF-8 (Charset/forName "UTF-8"))

(defn md5
  [& args]
  (let [^MessageDigest md (MessageDigest/getInstance "MD5")]
    (doseq [a args]
      (if (string? a)
        (.update md ^bytes (.getBytes ^String a ^Charset UTF-8))
        (.update md ^bytes a)))
    (apply str (map #(String/format "%02x" (into-array Object [%])) (.digest md)))))

(defn int32
  [n]
  (doto (ByteBuffer/allocate 4)
    (.putInt n)))

(defn int16
  [n]
  (doto (ByteBuffer/allocate 2)
    (.putShort n)))

(defn byte1
  [n]
  (doto (ByteBuffer/allocate 1)
    (.put (byte n))))

(defn string
  [s]
  (let [bytes (.getBytes ^String (str s) ^Charset UTF-8)]
    (doto (ByteBuffer/allocate (+ (alength ^bytes bytes) 1))
      (.put ^bytes bytes)
      (.put (byte 0)))))

(defn bytify-map
  [m]
  (mapcat (fn [[k v]] [(string (name k)) (string (str v))]) m))

(defn byte-count
  [bytebufs]
  (reduce + (map #(.capacity ^ByteBuffer  %) bytebufs)))

(defn startup-message
  [m]
  (let [msg (flatten [(int32 196608)
                      (bytify-map m)
                      (byte1 0)])]
    (flatten [(int32 (+ (byte-count msg) 4))
              msg])))

(defn md5-auth
  [auth-salt username password]
  (let [a (md5 password username)
        b (md5 a auth-salt)]
    (str "md5" b)))

(defn password-message
  [content]
  (let [bytes (string content)]
    [(byte1 \p)
     (int32 (+ (.capacity ^ByteBuffer bytes) 4))
     bytes]))

(defn terminate-message
  []
  [(byte1 \X)
   (int32 4)])

(defn query-message
  [query-string]
  (let [buf (string query-string)]
    [(byte1 \Q)
     (int32 (+ (.capacity ^ByteBuffer buf) 4))
     buf]))

(defmulti auth-req (fn [t bb] t))
(defmethod auth-req 0
  [_ ^ByteBuffer bb]
  :auth-ok)
(defmethod auth-req 5
  [_ ^ByteBuffer bb]
  (let [salt (byte-array 4)]
    (.get bb salt)
    salt))

(defn get-string
  [^ByteBuffer bb]
  (loop [bytes []]
    (let [x (.get bb)]
      (if (= x 0)
        (String. (byte-array bytes))
        (recur (conj bytes x))))))

(defmulti response (fn [response-type _ _] response-type))
(defmethod response (int \R)
  [_ len ^ByteBuffer bb]
  (let [auth-type (.getInt bb)]
    (auth-req auth-type bb)))
(defmethod response (int \E)
  [_ len ^ByteBuffer bb]
  :error)
(defmethod response (int \S)
  [_ len ^ByteBuffer bb]
  {:type :parameter-status
   :name (get-string bb)
   :value (get-string bb)})
(defmethod response (int \K)
  [_ len ^ByteBuffer bb]
  {:type :backend-key-data
   :pid (.getInt bb)
   :key (.getInt bb)})
(defmethod response (int \Z)
  [_ len ^ByteBuffer bb]
  {:type :ready-for-query
   :backend-status (char (.get bb))})
(defmethod response (int \T)
  [_ len ^ByteBuffer bb]
  (let [fields (.getShort bb)]
    (println fields)
    {:type :row-description
     :field-count fields
     :fields (for [i (range fields)]
               {:name (get-string bb)
                :table-oid (.getInt bb)
                :column-attribute-num (.getShort bb)
                :field-oid (.getInt bb)
                :data-type-size (.getShort bb)
                :type-modifier (.getInt bb)
                :format-code (.getShort bb)})}))
(defmethod response (int \D)
  [_ len ^ByteBuffer bb]
  (let [cols (.getShort bb)]
    {:type :data-row
     :column-value-count cols
     :values (for [i (range cols)]
               (let [len (.getInt bb)]
                 {:len len
                  :val (if (> len 0)
                         (let [bytea (byte-array len)]
                           (.get bb ^bytes bytea)
                           bytea)
                         nil)}))}))
(defmethod response (int \C)
  [_ len ^ByteBuffer bb]
  {:type :command-complete
   :tag (get-string bb)})

(defn send!
  [^SocketChannel sc bufs]
  (as-> bufs x
        (map #(.rewind ^ByteBuffer %) x)
        (into-array ByteBuffer x)
        (.write sc ^"[Ljava.nio.ByteBuffer;" x)))

(defn recv!
  [^SocketChannel sc]
  (let [bb (ByteBuffer/allocate 5)]
    (.read sc bb)
    (.rewind bb)
    (let [type (.get bb)
          len (.getInt bb)
          content-bb (ByteBuffer/allocate (- len 4))]
      (.read sc ^ByteBuffer content-bb)
      (.rewind content-bb)
      (response type len content-bb))))

(defn converse
  []
  (with-open [sc (SocketChannel/open (InetSocketAddress. "127.0.0.1" 5432))]
    (send! sc (startup-message {:user "postgres" :database "postgres"}))
    (let [auth-salt (recv! sc)]
      (send! sc (password-message (md5-auth auth-salt "postgres" "qRoJXpy"))))
    (pprint
     (loop [preamble []]
       (let [msg (recv! sc)]
         (if (= (:type msg) :ready-for-query)
           [msg preamble]
           (recur (conj preamble msg))))))
    (send! sc (query-message "SELECT '{}'::json AS foo"))
    (pprint (recv! sc))
    (pprint (recv! sc))
    (pprint (recv! sc))
    (pprint (recv! sc))
    (send! sc (terminate-message))))


;; startup
;; ReadyForQuery
;; dostuff
;; ReadyForQuery
;; ...
;
;; Simple query:
;; (Query_Q query-string) ->|
;;   (CommandComplete_C command-tag)
;;   (CopyInResponse_G overall-format num-colums column-formats)
;;   (CopyOutResponse_H overall-format num-columns column-formats)
;;   (RowDescription_T fields)
;;   (DataRow_D values)
;;   (EmptyQueryResponse_I) -- partner for command-complete
;;   (ErrorReponse_E error-fields)
;;   (ReadyForQuery_Z backend-status)
;;   (NoticeResponse_N message)
;;
;; (Query_Q "SELECT 'test' AS foo")
;;   (RowDescription [{name "foo", format 0, field-oid 705}])
;;   (DataRow ["test"])
;;   (CommandComplete :tag "SELECT 1")
;;   (ReadyForQuery :backed-status \I)
;;
;; (Query_Q "")
;;   (EmptyQueryResponse_I)
;;   (ReadyForQuery_Z :backed-status \I)
;;
;;
;;
;; Extended query:
;; (Parse_P stmt-name query oids)
;;   (ParseComplete_1) | (ErrorResponse_E)
;; (Bind_B portal-name stmt-name param-formats values result-formats)
;;   (BindComplete_2) | (ErrorResponse_E)
;; (Describe_D portal-name)
;;   (RowDescription_T fields)
;; (Execute_E portal-name row-limit)
;;   -- no ReadyForQuery or RowDescription
;;   -- ends with CommandComplete|EmptyQueryResponse|ErrorResponse|PortalSuspended
;; (Close_C stmt-name) -- can close stmt or portal, closing stmt closes portals too
;;   (CloseComplete_3)
;; (Sync_S) -- will commit/rollback internal tx, won't touch BEGIN tx
;;   (ReadyForQuery_Z status) -- I no tx, T in tx, E in failed tx
;;
;; -- can do multiple bind/describe/execute cycles
;;
;; Response meta from portal, as not automatic in extended query:
;; (Describe_D :portal portal-name) -- also can be :statement
;;   -- RowDescription_T|NoData_n
;;   (RowDescription_T fields)
;;
;; Parameter and respose meta from statement:
;; (Describe_D :statement statement-name)
;;   (ParameterDescription_t oids)
;;   (RowDescription_T fields)|(NoData_n) -- before bind field format is not known.. will be zeroes
;;
;; Hitting limit:
;;   (PortalSuspended_s)
;; (Execute_E portal-name row-limit) -- to continue
;;
;; Async stuff:
;;   (NoticeResponse_N msg)
;;   (ParameterStatus_S param value) -- run-time param changed
;;   (NotificationResponse_A pid channel payload)
;;
;; Cancel by opening new conn and using secret key - BackendKeyData in startup:
;; (CancelRequest pid key)
;;



;;
;; pg-async ?
;;
;; (def ch1 (parse "SELECT $1"))
;; (go
;;   (let [[stmt field-info] <! ch1]
;;     (bind stmt [1])))
;;
;; (def resp-ch (execute port :batch-size 10))  -- use growing window to batch properly
;; (go-loop [x <! resp-ch]
;;   (print x)
;;   (recur (<! resp-ch)))
;;
;;
