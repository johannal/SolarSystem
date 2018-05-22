;;;
;;; load-modeling.clp
;;; Copyright © 2018 Apple. All rights reserved.
;;;
;;; Input schemas: http-request, tick
;;; Output schemas: solar-network-request-load
;;;

;;; MARK: MODELER

(deftemplate MODELER::last-interval-end
    (slot timestamp (type INTEGER) (default 0))
)

(deffacts MODELER::initial-state
    (load-period-nanos 100000000)
    (last-interval-end)
)

(deftemplate MODELER::load-total
    (slot interval-start (type INTEGER) (default ?NONE))
    (slot interval-end (type INTEGER) (default ?NONE))
    (slot accumulator (type INTEGER) (default 0))
)

(deftemplate MODELER::add-time-to-load-avg
    (slot start (type INTEGER) (default ?NONE))
    (slot end (type INTEGER) (default ?NONE))
)

(defrule MODELER::add-activity-to-load
    (http-request (start ?start) (duration ?duration))
    =>
    (assert (add-time-to-load-avg (start ?start) (end (+ ?start ?duration))))
)

(defrule MODELER::compute-avg-for-tick
    (declare (salience -100))  ;; make sure the other facts have already been asserted before computing
    (tick (time ?end-time))
    ?f <- (last-interval-end (timestamp ?interval-start&~?end-time))
    =>
    (bind ?total 0)
    (do-for-all-facts ((?data add-time-to-load-avg)) (< ?data:start ?end-time)
        (if (<= ?data:end ?end-time) then
            (bind ?amount (- ?data:end ?data:start))
            (retract ?data)
            else
            (bind ?amount (- ?end-time ?data:start))
            (modify ?data (start ?end-time))
        )
        (bind ?total (+ ?total ?amount))
    )
    (modify ?f (timestamp ?end-time))
    (assert (load-total (interval-start ?interval-start) (interval-end ?end-time) (accumulator ?total)))
)

(defrule MODELER::merge-tick-averages
    ?f <- (load-total (interval-start ?start) (interval-end ?middle) (accumulator ?first))
    ?g <- (load-total (interval-start ?middle) (interval-end ?end) (accumulator ?second))
    =>
    (retract ?f)
    (retract ?g)
    (assert (load-total (interval-start ?start) (interval-end ?end) (accumulator (+ ?first ?second))))
)


;;; MARK: RECORDER

(defrule RECORDER::record-interval
    (table (table-id ?output) (side append)) (table-attribute (table-id ?output) (has schema solar-network-request-load))
    ?f <- (load-total (interval-start ?start) (interval-end ?end) (accumulator ?total))
    (load-period-nanos ?load-nanos&:(not (< (- ?end ?start) ?load-nanos)))
    =>
    (retract ?f)
    (bind ?duration (- ?end ?start))
    (create-new-row ?output)
    (set-column start ?start)
    (set-column duration ?duration)
    (set-column load (/ ?total ?duration))
    (bind ?load (/ ?total ?duration))
    (if (> ?load 16)
        then (set-column load-commitment "Over")
        else (set-column load-commitment "Partial")
    )
)
