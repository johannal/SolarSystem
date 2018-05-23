;  fusion-modeler.clp
;  Solar System
;
;  Copyright © 2018 Apple. All rights reserved.

(defrule RECORDER::record-unified-http
    (os-signpost (subsystem "com.demo.SolarSystem") (category "Networking") (name "NetworkRequest")
        (message$ "Request started URL:" ?url ",TYPE:" ?request-type ",CATEGORY:" ?category)
        (time ?time) (identifier ?identifier)
    )

    (table (table-id ?output) (side append))
    (table-attribute (table-id ?output) (has schema request-start))
    =>
    (create-new-row ?output)
    (set-column time ?time)
    (set-column url ?url)
    (set-column category ?category)
    (set-column identifier ?identifier)
    (set-column request-type ?request-type)
    (set-column request-label (str-cat "[" ?request-type "] " ?url))
)
