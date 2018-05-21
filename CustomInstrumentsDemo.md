## Part 1 — os_log/os_signpost

The Xcode and Instruments have some great new features that make it easier than ever to understand how your app is performing. Let me show you.

I've recently noticed some stutters in my Solar System exploration app.

*Run app and show stutter (or maybe app is already running)*

I've got some basic os_logging in my code already, which has been great for seeing the order of events in the console. But thats not really enough to help me understand whats going on here. 

In Xcode 10, I can update some of my os_log statements to use the new "Points of Interest" category. I'm going to do that here.

*Change os_log category to OS_LOG_CATEGORY_POINTS_OF_INTEREST*

This is a way for me to declare that I want this log to show up as a point in time in Instruments. What would also be really helpful, is to visualize the range of time where I'm parsing JSON. I can do that by using the "os_signpost" API.

At the start of parsing, I'll add this call to mark the beginning of the interval:

*Add os_signpost(begin call*

And I'll mark the end of the internal:

*Add os_signpost(end call*


## Setup

Code snippets:

os_signpost_interval_begin(solarSystemLog, request.identifier, "JSONParsing", "Started parsing data of size \(responseData.count)")

os_signpost_interval_end(solarSystemLog, request.identifier, "JSONParsing", "Finished parsing")


-- OLD BELOW ----------------------------------------- 

I've been working with the team on adding networking functionality to the Solar System app — we want to keep users informed on news of newly-discovered exoplanets and make sure our list of planets and dwarf planets stays up-to-date. I'm working on the JSON parsing pipeline, and I'd like to visualize what it looks like with the new os_log and os_signpost integration. 

I'm going to start by adding an os_log statement for when the user refreshes the network content. os_log is as easy to add as print, but its comes with categorization features as well. 

_scroll to definition of log object_

I've defined a logging handle with my app's bundle ID as subsystem, and I'll use the pre-configured PointsOfInterest category for my quick investigation. Adding this to the refresh is simple:

	`os_log_debug(_networkExperimentLog, "Refresh Network Call Triggered");`

The other part I'm interested in is the JSON parsing, but I'd like to wrap the activity with the new os_signpost APIs to annotate these intervals:

	`os_signpost_interval_begin(_networkExperimentLog, identifier, "JSONParsing", "Started parsing data of size %lu", (unsigned long)dataSize);`

	`os_signpost_interval_end(_networkExperimentLog, identifier, "JSONParsing", "Finished parsing");

With these APIs, I don't need to collect start and end timestamps or write the code to subtract and format them. Let's try these out by Profiling my App in Instruments

_click Profile action_

The Time Profiler template now has a Points of Interest track built-in, so I'll select that and hit record. I'll use cmd-R to trigger a network refresh in the App, and in the background Instruments is already displaying point and interval data. That's all it takes to get my data to show up in Instruments' timeline.

Well that's interesting — none of the JSON parsing intervals are overlapping. Did none of the network requests finish at the same time? We're going to need more data.

## Part 2 — Custom Instruments

The instrumentation I just added in the PointsOfInterest category is great for quick investigations, but network functionality is going to be a central part of the App going forward. It's worth investing in telemetry and defining our own categories that we'll leave in the codebase so that we can quickly trace issues when they arise.

Luckily, _person_ on the team has already instrumented more of our networking code and sent a Custom Instruments Package for just this purpose! Let's try it out.

_double-click custom instrument package_

When I double-click the package, Instruments lets me know what tools and templates are included. Now that I've installed it, bringing up the template chooser shows me the Solar System template that <person> created. 

_select template, record, cmd-R, stop_

I'm going to run my app with this template, refresh, and take a look at the data. The track gives me the intervals I was looking for — the network requests are happening concurrently but the JSON parsing is still being serialized. 

Instruments Packages allow you to customize the modeling and define the presentation of your trace points. This lets you create expressive graphs and rich summaries. _person_ included a summary view to show what the min/max/average durations were, and with just a few lines of XML described this useful in-flight view showing only activity intersecting my inspection point.

Whether you're authoring an App or a Framework, we're excited Custom Instruments Packages will let you share your tools with the developers you work with.

## Wrap Up
That's a quick look at os_log/os_signpost integration in Instruments and what's possible by creating and sharing Custom Instruments Packages with Xcode 10!
