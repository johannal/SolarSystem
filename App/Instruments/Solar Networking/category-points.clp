;;;
;;; category-points.clp
;;; Copyright © 2018 Apple. All rights reserved.
;;;
;;; Input schemas: os-signpost [category="Networking", subsystem="com.demo.SolarSystem"]
;;; Output schemas: solar-request-start
;;;

(defrule RECORDER::record-unified-http
    (os-signpost (time ?time) (event-type "Begin") (name "NetworkRequest") (identifier ?identifier)
        (message$ "Request started URL:" ?url ",TYPE:" ?request-type ",CATEGORY:" ?category)
    )
    (table (table-id ?output) (side append)) (table-attribute (table-id ?output) (has schema solar-request-start))
    =>
    (create-new-row ?output)
    (set-column time ?time)
    (set-column url ?url)
    (set-column category ?category)
    (set-column identifier ?identifier)
    (set-column request-type ?request-type)
    (set-column request-label (str-cat "[" ?request-type "] " ?url))
)
