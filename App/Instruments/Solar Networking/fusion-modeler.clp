;  fusion-modeler.clp
;  Solar System
;
;  Created by Kacper Harasim on 5/15/18.
;  Copyright © 2018 Apple. All rights reserved.

(defrule RECORDER::record-unified-http
    (http-requests (start ?start) (duration ?duration))
    (table (table-id ?output) (side append))
    (table-attribute (table-id ?output) (has schema unified-network-json))
    =>
    (create-new-row ?output)
    (set-column start ?start)
    (set-column duration ?start)
)

(defrule RECORDER::record-unified-json
    (json-parsing (start ?start) (duration ?duration))
    (table (table-id ?output) (side append))
    (table-attribute (table-id ?output) (has schema unified-network-json))
    =>
    (create-new-row ?output)
    (set-column start ?start)
    (set-column duration ?start)
)
