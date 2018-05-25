## Part 1 — os_log/os_signpost

Xcode and Instruments have some great new features that make it easier than ever to understand how your app is performing. Let me show you.

I've recently noticed some pretty serious stutters in my Solar System exploration app.

  *Show stuttering app*

Let's figure out whats going on. I want to use the new os_signpost API in Xcode 10 to surface some time intervals in my code. I'll start in my class here that handles networking and JSON parsing.

I'm going to measure how long the JSON parsing is taking, so I'll drop the first signpost right before I start parsing:

  *Add os_signpost_interval_begin call*

And I'll drop the second signpost after I'm done parsing.

  *Add os_signpost_interval_end call*

The system will automatically insert timestamps and calculate the delta for me, I don't have to worry about any of that.

Now my data, thats going to automatically show up in Instruments. I'm using a log handle, defined up here, that's configured to use the new .pointsOfInterest category, which Instruments monitors.

Lets run this under Instruments and see what kind of data we get. I'll go to Product > Profile, which will launch Instruments.

Up here you can see the Points of Interest track. Anything I logged with the .pointsOfInterest category shows up here. These blue bars are showing how long it's taking to parse my data.

Right away I can see that each time I'm parsing data, the main thread spikes, which means I'm probably doing my parsing on the main thread which is causing my stutter. I should really move that to a background thread.

So, some really quick insight in Instruments just by adding signposts in my code.

## Part 2 — Custom Instruments

Now if these simple visualizations aren't enough, you can go much further by customizing the way Instruments presents your data, using the same powerful core technology we use to create all the included instruments.

I've got a Custom Instruments package here that my teammate Daniel sent me, that visualizes signposts in the networking framework that he built for our app.

I'll install it by double clicking the icon, and I can see details about the package. I'll click Install. And it shows up in the template chooserl. I'll choose the Solar System template, and click record, which will launch the app.

In addition to the JSON parsing intervals that I already added, which I can still see up in the Points of Interest track, now I can see much more detailed information about the network requets I'm making to get that data.

Daniel's surfacing a couple of things to me, like the average number of requests I'm making per second. This track here is showing me every single request I'm making, and how long it took. He's even providing insight here about times that I've made unnecessary duplicate requests, which are highlighted in red. 

Daniel's Custom Instruments package really gives me some great insight into my use of his framework.

Thats a look at the powerful new extensibility in Instruments.
