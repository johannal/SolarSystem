## Part 1 — os_log/os_signpost

Xcode and Instruments have some great new features that make it easier than ever to understand how your app is performing. Let me show you.

I've recently noticed some pretty serious stutters in my Solar System exploration app when it first launches and is udpating the planet data.

  *Show stuttering app*

Let's figure out whats going on. I want to use the new os_signpost API to surface some time intervals in my code. I'll start in my class here that handles networking and JSON parsing.

First off, I want to measure how long the JSON parsing is taking, so I'll drop the first signpost right before I start parsing:

  *Add os_signpost_interval_begin call*

And I'll drop the second signpost after I'm done parsing.

  *Add os_signpost_interval_end call*

I'm using a log handle, defined up here, that's configured to use the new .pointsOfInterest category. This is a special new cateogry that Instruments is always watching.

Lets run this under Instruments and see what kind of data we get. I'll go to Product > Profile, which will launch Instruments.

Up here you can see the Points of Interest track. Anything I logged with the .pointsOfInterest category shows up here. These blue bars are showing how long it's taking to parse my data.

Right away I can see that each time I'm parsing data, the main thread spikes, which means I'm probably doing my parsing on the main thread which is causing my stutter. I should really move that to a background thread.

So, some really quick insight in Instruments by adding just a couple of signposts in my code.

## Part 2 — Custom Instruments

Now if these simple visualizations aren't enough, you can go much further by customizing exactly which data Instruments shows you and how it shows it to you. You'll be using the same powerful core technology we use to create all the included instruments.

Let me show you a Custom Instruments package that my teammate Daniel sent me. It visualizes signposts in the networking framework that he built for our app.

I'll install it by double clicking the icon. I can see details about the package. I'll install it, and it shows up in right here in the template chooser. I'll select it, and click record, which will launch the app.

I can still see the JSON parsing intervals that I added, but now I can also see much more detailed information about the network requets I'm making to get that data.

Daniel's surfacing a couple of things to me here, like the average number of requests I'm making per second. The second track is showing me every single request I'm making, and how long each one took. He's even providing insight here about times that I've made unnecessary duplicate requests, which are highlighted in red.

The new signposts made it easy to improve the performance of my own code, and Custom Instruments gave me new insight into Daniel's framework.
