## Part 1 — os_log/os_signpost

Xcode and Instruments have some great new features that make it easier than ever to understand how your app is performing. Let me show you.

I've recently noticed some pretty serious stutters in our Solar System exploration app.

    *Run app and show stutter (or maybe app is already running)*

I've got basic logging in my code, which I can see flying by here -- it's pretty obvious to me that there are a ton of data requests, which doesn't seem right.

But I really want more insight into why my UI is stuttering. What is taking so long and blocking the main thread?

The first thing I'm going to do is figure out how long my data parsing is taking -- thats been pretty problematic for us.

I'm going to use some new API in Xcode 10, thats going to help me surface performance metrics for my own code. 

I'll add a call to the new "interval begin" function here.

  *Add os_signpost_interval_begin call*

And then a call to "interval end" down here.

  *Add os_signpost_interval_end call*

This brackets my data parsing work, and the system is going to insert timestamps and calculate the delta for me.

The real magic is up here, where I've converted my OSLog to use this new .PointsOfInterest category. This is a way for me to declare that I want this logs to show up as a little flag in Instruments, and intervals will show up as filled bars.

Lets see what this looks like in Instruments. I'll go to Product > Profile, which will launch Instruments and my app.

As the data comes in, I can see all those time ranges where I'm parsing data. First of all, I think I'm  requesting data way too often. But even if I were just asking for it once, you can see that my parsing is taking a good long time, and it looks like it's blocking the main thread -- I'm just visually correlating that parsing bar here, with the activity on the main thread here.

You can start to imagine all the different kinds of activities you could start to surface in Instruments.

## Part 2 — Custom Instruments

Now if these simple visualizations aren't enough, you can go way further by customizing the way Instruments presents your own data to you. You'll be using the same powerful core technology we use to create all the included instruments.

If you're framework or game engine developer, this is a great way for you to give insight in a curated way to the developers using your APIs.

Our app actually has all of the networking logic factored into a framework, which Daniel owns. He's built a Custom Instruments package to help the team visualize how we're using his APIs. Let's take a look at what hes built.

I've got the Instruments package he sent me here. By the way, there's a new Xcode template to help you create one of these.

I'll install it by double clicking the icon.

Then I'll choose the template, which shows up right here in the template chooser.

I'll click record, and that will launch the app. I can see data start streaming in. So in addition to the simple data parsing visualization I added with my own logging, now I can see much more detailed information about how I'm requesting that data in the first place.

Daniel's Custom Instrument takes the simple data he gets from trace points, and then models that and defines these expressive graphs showing me very contextual information.

Like this track here, which is showing me every single network request I'm making. The red is places where I've actually requested the same data twice, so I should definitley fix that. Daniel's Custom Instrument is really going to help me make sure I'm using using his framework as intended.

Thats a look at the powerful new extensibility in Instruments.

## Setup

Code snippets:

os_signpost_interval_begin(solarSystemLog, request.identifier, "JSONParsing", "Started parsing data of size \(responseData.count)")

os_signpost_interval_end(solarSystemLog, request.identifier, "JSONParsing", "Finished parsing")

*******************************

Instruments Packages allow you to customize the modeling and define the presentation of your trace points. This lets you create expressive graphs and rich summaries. _person_ included a summary view to show what the min/max/average durations were, and with just a few lines of XML described this useful in-flight view showing only activity intersecting my inspection point.

Whether you're authoring an App or a Framework, we're excited Custom Instruments Packages will let you share your tools with the developers you work with.

## Wrap Up
That's a quick look at os_log/os_signpost integration in Instruments and what's possible by creating and sharing Custom Instruments Packages with Xcode 10!
