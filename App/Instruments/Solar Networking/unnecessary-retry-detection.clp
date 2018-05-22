;  unnecessary-retry-detection.clp
;  Solar System
;
;  Created by Kacper Harasim on 5/22/18.
;  Copyright © 2018 Apple. All rights reserved.


;(defrule RECORDER::detect-unnecessary-retry-get-request-results
;    (table (table-id ?output) (side append))
;    (table-attribute (table-id ?output) (has schema request-narrative))
;
;    =>
;    (create-new-row ?output)
;    (set-column <#mnemonic#> <#expression#>)
;    )

(defrule RECORDER::detect-unnecessary-retry-generate-warnings
    (os-signpost (subsystem "com.demo.SolarSystem") (category "Networking") (name "NetworkRequest")
        (message$ "Request started [ID:" ?request-id "][URL:" ?url "][TYPE:" ?request-type "][CATEGORY:" ?category "]")
        (time ?time) (identifier ?identifier) (event-type "BEGIN")
    )
    (table (table-id ?output) (side append))
    (table-attribute (table-id ?output) (has schema request-narrative))
    =>
    (create-new-row ?output)
    (set-column time ?time)
    (set-column narrative "Test")
)
