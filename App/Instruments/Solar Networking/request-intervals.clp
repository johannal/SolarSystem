;;;
;;; request-intervals.clp
;;; Copyright © 2018 Apple. All rights reserved.
;;;
;;; Input schemas: os-signpost [category="Networking", subsystem="com.demo.SolarSystem"]
;;; Output schemas: solar-network-request-interval
;;;

;;; MARK: MODELER

(deftemplate MODELER::open-request-interval
    (slot time (type INTEGER))
    (slot output-table (type INTEGER))
    (slot request-id (type INTEGER))
    (slot url (type EXTERNAL-ADDRESS))
    (slot category (type EXTERNAL-ADDRESS))
    (slot request-type (type EXTERNAL-ADDRESS))
    (slot layout-id (type INTEGER SYMBOL) (allowed-symbols sentinel) (default sentinel))
    (slot is-duplicate (type INTEGER) (allowed-values 0 1) (default 0))
)

(deftemplate MODELER::requested-url
    (slot time (type INTEGER))
    (slot request-id (type INTEGER))
    (slot url (type EXTERNAL-ADDRESS))
)

(defrule MODELER::request-begin
    (os-signpost (time ?start-time) (event-type "Begin") (name "NetworkRequest") (identifier ?request-id)
        (message$ "Request started URL:" ?url ",TYPE:" ?request-type ",CATEGORY:" ?category))
    (table (table-id ?output) (side append)) (table-attribute (table-id ?table-id) (has schema solar-network-request-interval))
    =>
    (assert (open-request-interval (time ?start-time) (output-table ?table-id) (request-id ?request-id) (url ?url) (category ?category) (request-type ?request-type)))
    (assert (requested-url (time ?start-time) (request-id ?request-id) (url ?url)))
    (assert (open-layout-reservation (start ?start-time) (category ?table-id)))
)

(defrule MODELER::url-clear
    (os-signpost (event-type "Emit") (name "NetworkRequest")
        (message$ "Request queue complete"))
    ?f <- (requested-url)
    =>
    (retract ?f)
)

(defrule MODELER::layout-begin-adjust
    ?f <- (open-request-interval (time ?time) (output-table ?table-id) (layout-id sentinel))
    (layout-reservation (start ?time) (category ?table-id) (id ?layout-id))
    =>
    (modify ?f (layout-id ?layout-id))
)

(defrule MODELER::duplicate-url
    ?f <- (open-request-interval (url ?same-url) (request-id ?request-id) (is-duplicate 0))
    (requested-url (url ?same-url) (request-id ?different-request-id&~?request-id))
    =>
    (modify ?f (is-duplicate 1))
)

(defrule MODELER::failure-removal
    (open-request-interval (request-id ?same-request-id) (url ?same-url))
    (os-signpost (event-type "End") (name "NetworkRequest") (identifier ?same-request-id)
        (message$ "Request finished CODE:" ?http-code&~200))
    ?f <- (requested-url (url ?same-url) (request-id ?same-request-id))
    =>
    (retract ?f)
)

(defrule MODELER::update-event-horizon
    (speculate (event-horizon ?horizon))
    (open-request-interval (time ?start-time&:(< ?start-time ?horizon)))
    =>
    (bind ?*modeler-horizon* (min ?start-time ?*modeler-horizon*))
)

;;; MARK: RECORDER

(defrule RECORDER::request-end
    ?f <- (open-request-interval (time ?start-time) (output-table ?table-id) (request-id ?request-id) (url ?url) (category ?category) (request-type ?request-type) (layout-id ?layout-id) (is-duplicate ?dupe))
    (os-signpost (time ?end-time) (event-type "End") (name "NetworkRequest") (identifier ?request-id)
        (message$ "Request finished CODE:" ?http-code))
    =>
    (assert (close-layout-reservation (id ?layout-id) (start ?start-time) (category ?table-id) (end (- ?end-time 1))))
    (retract ?f)
    (create-new-row ?table-id)
    (set-column start ?start-time)
    (set-column duration (- ?end-time ?start-time))
    (set-column request-id ?request-id)
    (set-column url ?url)
    (set-column category ?category)
    (set-column request-type ?request-type)
    (set-column request-label (str-cat "[" ?request-type "] " ?url))
    (set-column http-code ?http-code)
    (set-column end-present 1)
    (set-column layout-qualifier ?layout-id)
    (set-column request-color
        (if (eq ?dupe 1) then "Red" else (if (eq ?http-code 200) then "Blue" else "Orange"))
    )
)

(defrule RECORDER::speculation-output
    (speculate (event-horizon ?horizon))
    (open-request-interval (time ?start-time) (output-table ?table-id) (request-id ?request-id) (url ?url) (category ?category) (request-type ?request-type) (layout-id ?layout-id) (is-duplicate ?dupe))
    =>
    (create-new-row ?table-id)
    (set-column start ?start-time)
    (set-column duration (- ?horizon ?start-time))
    (set-column request-id ?request-id)
    (set-column url ?url)
    (set-column category ?category)
    (set-column request-type ?request-type)
    (set-column request-label (str-cat "[" ?request-type "] " ?url))
    (set-column layout-qualifier ?layout-id)
    (set-column request-color "Blue")
)
