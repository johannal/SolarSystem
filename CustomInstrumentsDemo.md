We've got some great new features for analyzing your apps performance. Let me show you.

I'm working on my Solar System exploration app here. When it first launches, I've noticed some stutters as it's fetching planet data. Let me press Command-R to fetch the data again so you can see that stutter.

I'm going to add some logging and signposts to see if I can figure out whats going on. 

This file here requests and parses the planet data. First thing I'm going to do is create an OSLog handle. I'll use the new .pointsOfInterest category. That means everything I log will automatically show up in Instruments.

  *insert snippet 1 -- OSLog handle creation*

I'll add an os_log here just before I do the network request.

  *insert snippet 2 -- os_log, about to do network request*

I'll add a pair of signposts down here, where I parse the data.

  *insert snippet 3 -- os_signpost, begin*
  *insert snippet 4 -- os_signpost, end*

So I've got one log and two signposts. Lets run this under Instruments and see how the data shows up. I'll go to Product > Profile, which will launch Instruments.

Up here you can see the Points of Interest track. Anything I logged with the .pointsOfInterest category shows up here. This little flag, that was the first log I added. And these blue bars are the two signposts I added -- they show up as a time interval.

Right away I can see that when I'm parsing data, the main thread's activity spikes. My guess is that I'm doing the parsing on the main thread which is not a receipe for a smooth UI. I should really move that to a background thread.

So some really quick insight in Instruments by just adding a log and a couple of signposts in my code. 

But, with the new tools, you can also create Custom Intruments. You'll be using the exact same technology all of the bundled instruments are built with.

Let me show you a Custom Instruments package that my teammate Daniel sent me. It visualizes signposts that he put in our networking framework.

I can see details about the package. I'll click install, and it shows up in right here in the template chooser. I'll select it, and click record, which launches my app.

I can still see the JSON parsing intervals that I added in the Points of Interest track, but now I can also see much more detailed information about the network requets I'm making to get that data.

Daniel's surfacing a couple of things to me here, like the average number of requests I'm making per second. And he's showing me every single request I'm making, and exactly how long each one took. He's even providing me insight into times that I've made unnecessary duplicate requests, which are highlighted in red -- I'm leaving a lot of performance on the table. Daniel's crafted a picture of whats going on in this networking framework, and thats going to help me use this framework better.

signposts and Custom Instruments are two great ways to surface your data in Instruments. And thats a look at the new performance tools.
