;  duplicate-overlapping-detection.clp
;  Solar System
;
;  Copyright © 2018 Apple. All rights reserved.

(deftemplate started-request
    (slot time
    (type INTEGER))
    (slot url
    (type STRING))
    (slot identifier
    (type INTEGER))
)

(defrule MODELER::record-any-request-starting
    (os-signpost (subsystem "com.demo.SolarSystem") (category "Networking") (name "NetworkRequest")
        (message$ "Request started URL:" ?url ",TYPE:" ?request-type ",CATEGORY:" ?category)
        (time ?time) (identifier ?identifier) (event-type "Begin")
    )
    =>
    (assert (started-request (time ?time) (url ?url) (identifier ?identifier)))
)

(defrule MODELER::record-request-starting-for-same-resource
    (started-request (time ?time) (url ?url) (identifier ?identifier))
    (started-request (url ?url) (time ?t&:(and (> ?time ?t) (< (- ?time ?t) 5000000000))))
    (table (table-id ?output) (side append))
    (table-attribute (table-id ?output) (has schema request-narrative))
    =>
    (create-new-row ?output)
    (set-column time ?time)
    (set-column narrative (str-cat "Requested the same resource: " ?url" before canceling previous request with identifier: " ?identifier))
)

(defrule RECORDER::record-request-finished
    (os-signpost (subsystem "com.demo.SolarSystem") (category "Networking") (name "NetworkRequest")
        (message$ "Request finished [ID:" ?request-id "][CODE:" ?http-code"]")
        (identifier ?identifier) (event-type "End")
    )
    ?which <- (started-request (time ?time) (url ?url) (identifier ?identifier))
    =>
    (retract ?which)
)
