## Part 1 — os_log/os_signpost

Xcode and Instruments have some great new features that make it easier than ever to understand how your app is performing. Let me show you.

I've recently noticed some pretty serious stutters in my Solar System exploration app.

  *Show stuttering app*

Definitley something I want to fix this.

I've got plenty of logging in my code, but for a for a performance issue like this, I really want to see time intervals to understand how long things like my network requests and data parsing are taking.

Xcode 10 introduces new API that lets me surface my own performance metrics. I'm going to start by using that to see how long my JSON data parsing is taking.

This class uses our networking framework to fetch data and then I parse it down here.

I'll add a call to the new os_signpost function here, right before I start parsing.

  *Add os_signpost_interval_begin call*

And then I'll add a call to mark the end of parsing down here.

  *Add os_signpost_interval_end call*

The system is going to automatically insert timestamps and calculate the delta for me, I don't have to worry about that.

So where is this information going to show up? My log handle, defined up here is configured to use the new .pointsOfInterest category, which will automatically surface the data in Instruments.

Lets see what kind of data we get in Instruments. I'll go to Product > Profile, which will launch Instruments and my app.

Up here you can see the Points of Interest track, with all my logs and signposts. So these blue bars, those are the intervals I just added that show long it takes to parse the data.

Each time I'm parsing the data, I can see the main thread's CPU usage spik, which is probably causing that stutter. I should really move that to a background thread.

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
