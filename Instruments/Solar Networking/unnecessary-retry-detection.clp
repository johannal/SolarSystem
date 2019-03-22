;;;
;;; unnecessary-retry-detection.clp
;;; Copyright © 2018 Apple. All rights reserved.
;;;
;;; Input schemas: solar-network-request-interval
;;; Output schemas: solar-request-narrative
;;;

;;; MARK: MODELER

(deffacts MODELER::initial-state
    (detection-leeway-nanos 10000000000)
)

(deftemplate MODELER::finished-server-error-request
    (slot code (type INTEGER))
    (slot url (type STRING))
    (slot finish-time (type INTEGER))
)

(defrule MODELER::detect-unnecessary-retry-get-request-results
    (solar-network-request-interval (http-code ?http-code) (url ?url) (start ?start) (duration ?duration))
    (test (>= ?http-code 500))
    (test (<= ?http-code 599))
    =>
    (assert (finished-server-error-request (code ?http-code) (url ?url) (finish-time (+ ?start ?duration))))
)

(defrule MODELER::age-out-failures
    (solar-network-request-interval (start ?start)) ; event horizon of previous stage modeler must be >= this value now
    (detection-leeway-nanos ?leeway)
    ?f <- (finished-server-error-request (finish-time ?error-timestamp&:(< (+ ?error-timestamp ?leeway) ?start)))
    =>
    (retract ?f)
)

;;; MARK: RECORDER

(defrule RECORDER::detect-unnecessary-retry-generate-warnings
    (solar-network-request-interval (url ?same-url) (start ?time) (request-id ?identifier))
    (finished-server-error-request (url ?same-url) (code ?http-code))
    (table (table-id ?output) (side append)) (table-attribute (table-id ?output) (has schema solar-request-narrative))
    =>
    (create-new-row ?output)
    (set-column time ?time)
    (set-column narrative (str-cat "Requested URL on the server despite it returning code "?http-code " within last 10 seconds. URL: "?same-url " Identifier: "?identifier))
)
