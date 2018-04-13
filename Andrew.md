# WWDC 2018 SOTU Demo - Andrew

### Parallel Testing
* Parallel testing via multiple test runners for sharding test cases
* Parallelizes at the test class level
* Supports macOS unit testing
* Supports iOS unit and UI testing in the Simulator

### Debugger
* Memory graph debugger improvements: more compact layout / improvements for complex graphs
* View debugger improvements: target appearance of the target application (macOS only), viewing the current appearance and effetcive appearance of the target application
* Showing true API names for colors (secondaryLabelColor) for Skyglow adoption

### Instruments

* Ability to create new log handles and log to them
* Log using the new *instruments category macro*
* Show waypoint markers in the timeline in the "Points of Interest" track
* UI spins support (macOS only)
* Custom instruments via kdebug and os_log, XML-based instrument to customize analysis / presentation of os_log data

-

*Demo Flow*

* Start with a macOS project, show runnning mac tests non-parallel
* Edit the scheme to enable running tests in parallel (explain why it's opt in and what the parallelization strategy is)
* Re-run the tests and show the speed up when they are parallelized (explaining the heuristical aspects of the scheduler which improves the scheduling the more times you run your tests)
* Switch to iOS application
* Describe some performance aspect of the application (e.g. how often we load some JSON definition of the planets from a web server)
* Explain that our server folks have been seeing a lot of traffic hitting our web servers since we shipped our last software update, and explain that we think we might have a bug in how data gets loaded
* Let's make use of os_log to profile our application and see how often we really are loading that data
* Fix the app, re-run it in Instruments and show the waypoints in the points of interest timeline
* [Optional] Show a pre-baked custom instrument that graphs JSON web service activity (or something similar) in Instruments
* Explain that I've fixed the bug, and we need to ship it quickly, so I'm going to make use of parallel testing to validate my change even faster
* [Optional] Write some kind of test for the problem
* Have a space configured on my machine that has 4x simulators pre-warmed
* Run the UI tests from Xcode, and switch to the space
* Show the tests running in parallel, and finish the demo on a bunch of passing tests in Xcode