## Part 1 — os_log/os_signpost

Xcode and Instruments have some great new features that make it easier than ever to understand how your app is performing. Let me show you.

I've recently noticed some pretty serious stutters in my Solar System exploration app.

  *Show stuttering app*

Let's figure out whats going on. I want to use the new os_signpost API in Xcode 10 to surface some time intervals in my code. I'll start in my class here that handles networking and JSON parsing.

Right here before I parse the JSON data, I'll begin the interval:

  *Add os_signpost_interval_begin call*

And then after I'm done parsing, I'll end the interval down here.

  *Add os_signpost_interval_end call*

The system will automatically insert timestamps and calculate the delta for me, I don't have to worry about that.

Now my data, thats going to automatically show up in Instruments. I'm using a log handle, defined up here, that's configured to use the new .pointsOfInterest category, which Instruments watches for.

Lets run this under Instruments and see what kind of data we get. I'll go to Product > Profile, which will launch Instruments and my app.

Up here you can see the Points of Interest track. That has all my logs and signposts. These blue bars are showing how long it's taking to parse my data.

I can immediatley see something I can see that each time I'm parsing data, the main thread's CPU usage spik, which is probably causing that stutter. I should really move that to a background thread.

So, some really quick insight in Instruments just by adding logging and signposts.

## Part 2 — Custom Instruments

Now if these simple visualizations aren't enough, you can go much further by customizing the way Instruments presents your data. You'll be using the same powerful core technology we use to create all the included instruments.

And it's not just about your own personal developement. If you ship a framework or an engine, this is a great way for you to provide tools for your developers.

I've got a Custom Instruments package here that my teammate Daniel sent me. It visualizes signposts in the networking framework that he built for our app.

I'll install it by double clicking the icon, and then I'll click Install.

I'll choose the template, and I'll click record, which will launch the app.

I can see data start streaming in. In addition to the JSON parsing intervals that I added, now I can see much more detailed information about the network requets I'm making to get that data.

Daniel's Custom Instruments model the trace point data, and defines these expressive graphs.

Like this track here, which is showing me the average number of requests per 100 miliseconds. And then this track here which is showing me the time interval for each and every request, and highlighting duplicate requests in red. So, some really customized deep insight into this framework.

Thats a look at the powerful new extensibility in Instruments.
