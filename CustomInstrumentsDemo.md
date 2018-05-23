## Part 1 — os_log/os_signpost

Xcode and Instruments have some great new features that make it easier than ever to understand how your app is performing. Let me show you.

I've recently noticed some pretty serious stutters in my Solar System exploration app.

  *Show stuttering app*

Definitley want to fix this. Now I've been pretty good about adding great logging in my code, which you can actually see flying by here. I see a lot of data requests in there, which doesn't seem right.

But this logging by itself isn't going to be quite enough to help understand whats going on here. What I really want to see intervals of time to know how long things like parsing my data are taking.

To help me out with that, theres some new API in Xcode 10, that lets me surface performance metrics for my own code. 

Here in PlanetDataFetcher, I'm using our own networking framework, but I handle the JSON parsing. I've also got some logging sprinkled throughout to surface important events.

I want to know how long the data parsing is taking, so I'll add a call to the new os_signpost function here, right before I start parsing. This is marking the beginning of the interval.

  *Add os_signpost_interval_begin call*

And then I'll add a call to mark the end of parsing down here.

  *Add os_signpost_interval_end call*

The system is going to automatically insert timestamps and calculate the delta for me, I don't have to worry about that.

Next question though, where is this information going be shown? Each of these log statements is using a custom OSLog handle, that I created up here, which uses the new PointsOfInterest category. Thats a special category, and any logs or signposts will automatically show up in Instruments.

Lets see what this looks like in Instruments. I'll go to Product > Profile, which will launch Instruments and my app.

Up here you can see the Points of Interest track, which surfaces all of my log and signpost calls. So these blue bars, those are the intervals I just added that show long it takes to parse the data.

First off, I think I'm requesting data way too often. Then when I get the data, it looks like the main threads CPU usage spikes when we're parsing, which is probably whats causing the stutter -- should really move that to a background thread.

So some quick insight, without needing to do a whole lot.

## Part 2 — Custom Instruments

And if these simple visualizations aren't enough, you can go much further by customizing the way Instruments presents your own data, using the same powerful core technology we use to create all the included instruments.

And it's not just about your own developement. If you ship a framework or an engine, this is a great way for you to provide tools for those using your APIs.

Now I've got a Custom Instruments package here that Daniel, one of my teammates, sent me. It visualizes the networking framework that he built for our app.

I'll install it by double clicking the icon, and then I'll click Install.

I'll choose the template, and I'll click record, which will launch the app.

I can see data start streaming in. In addition to the parsing visualization, now I can see much more detailed information about how I'm requesting that data in the first place.

Daniel's Custom Instrument takes the simple data he gets from trace points, and then models that and defines these expressive graphs showing me very contextual information.

Like this track here, which is showing me every single network request that I'm making. The red indicates where I've requested the same data twice, so I should definitley fix that. This Custom Instruments package is really going to help me get the most out of this framework.

Thats a look at the powerful new extensibility in Instruments.
