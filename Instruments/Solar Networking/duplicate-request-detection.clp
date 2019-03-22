;;;
;;; duplicate-overlapping-detection.clp
;;; Copyright © 2018 Apple. All rights reserved.
;;;
;;; Input schemas: solar-network-request-interval
;;; Output schemas: solar-request-narrative
;;;

;;; MARK: MODELER

; No MODELER rules necessary; the overlap detection works because intervals are asserted as facts for
; their entire duration and only retracted when the modeling clock passes their end, so we can simply
; check for two intervals in existence at any moment with the same url.

;;; MARK: RECORDER

(defrule RECORDER::overlap-detection
    (solar-network-request-interval (start ?start1) (request-id ?id1) (url ?same-url))
    (solar-network-request-interval (start ?start2) (request-id ?id2) (url ?same-url))
    (test (< ?start1 ?start2))
    (table (table-id ?output) (side append)) (table-attribute (table-id ?output) (has schema solar-request-narrative))
    =>
    (create-new-row ?output)
    (set-column time ?start2)
    (set-column narrative (str-cat "Requested the same resource: " ?same-url" with identifier: " ?id2 " before canceling previous request with identifier: " ?id1))
)
