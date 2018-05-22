;  unnecessary-retry-detection.clp
;  Solar System
;
;  Copyright © 2018 Apple. All rights reserved.

(deftemplate finished-server-error-request
    (slot code
        (type INTEGER))
    (slot url
        (type STRING))
    (slot finish-time
        (type INTEGER))
    )

(defrule RECORDER::detect-unnecessary-retry-get-request-results
    (http-request (http-code ?http-code) (url ?url) (start ?start) (duration ?duration))
    (table (table-id ?output) (side append))
    (table-attribute (table-id ?output) (has schema request-narrative))
    (eq ?http-code 500)
    =>
    (assert (finished-server-error-request (code ?http-code) (url ?url) (finish-time (+ ?start ?duration))))
)

(defrule RECORDER::detect-unnecessary-retry-generate-warnings
    (os-signpost (subsystem "com.demo.SolarSystem") (category "Networking") (name "NetworkRequest")
        (message$ "Request started [ID:" ?request-id "][URL:" ?url "][TYPE:" ?request-type "][CATEGORY:" ?category "]")
        (time ?time) (identifier ?identifier) (event-type "Begin")
    )
    (table (table-id ?output) (side append))
    (table-attribute (table-id ?output) (has schema request-narrative))
    
    =>
    (create-new-row ?output)
    (set-column time ?time)
    (set-column narrative "Test")
)
