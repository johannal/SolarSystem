;  duplicate-overlapping-detection.clp
;  Solar System
;
;  Created by Kacper Harasim on 5/22/18.
;  Copyright © 2018 Apple. All rights reserved.

(deftemplate started-request
    (slot time
    (type INTEGER))
    (slot url
    (type STRING))
    (slot identifier
    (type INTEGER))
)

(defrule RECORDER::record-any-request-starting
    (request-start (time ?time) (url ?url) (identifier ?identifier))
    =>
    (assert (started-request (time ?time) (url ?url) (identifier ?identifier)))
)

(defrule RECORDER::record-request-starting-for-same-resource
    (request-start (time ?time) (url ?url) (identifier ?identifier))
    (table (table-id ?output) (side append))
    (table-attribute (table-id ?output) (has schema request-narrative))
    =>
    (create-new-row ?output)
    (set-column time ?time)
    (set-column narrative "Test")
)

(defrule RECORDER::record-request-finished
    (os-signpost (subsystem "com.demo.SolarSystem") (category "Networking") (name "NetworkRequest")
        (message$ "Request finished [ID:" ?request-id "][CODE:" ?http-code"]")
        (identifier ?identifier)
    )
    ?which <- (started-request (time ?time) (url ?url) (identifier ?identifier))
    =>
    (retract ?which)
)
