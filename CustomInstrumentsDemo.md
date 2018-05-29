I'm working on my Solar System exploration app here. When it's updating the planetrary data, I've noticed the UI is pretty choppy -- the planets kind of stutter around their orbits.

I want to figure out whats going.

PlanetUpdateService.swift here, is the class that does all the work for the update. I'm going to start by adding some logging and signposts. I'll need an OSLog handle, and I"m going to use the new .pointsOfInterest category. Everything I log using that category  will automatically show up in Instruments.

  *insert snippet 1 -- OSLog handle creation*

I'll add an os_log here just before I do the network request.

  *insert snippet 2 -- os_log, about to do network request*

I'll add a pair of signposts down here, where I parse the data.

  *insert snippet 3 -- os_signpost, begin*
  *insert snippet 4 -- os_signpost, end*

So I've got one log and two signposts. Lets run this under Instruments and see how the data shows up. I'll go to Product > Profile, which will launch Instruments.

Up here you can see the Points of Interest track. Anything I logged with the .pointsOfInterest category shows up here. This little flag, that was the first log I added. And these blue bars are the two signposts I added -- they show up as a time interval.

Right away I can see that when I'm parsing data, the main thread's activity spikes. My guess is that I'm doing the parsing on the main thread which is not a receipe for a smooth UI. I should really move that to a background thread.

So with just a log and a couple of signposts, I got some quick insight into my performance issue. 

But, with the new tools, you can do way more. Let me show you a Custom Instruments package that my teammate Daniel sent me. So this visualizes signposts that he put in our networking framework.

I can see details about the package. I'll click install, and it shows up in right here in the template chooser. I'll select it, and click record, which launches my app.

I can still see the JSON parsing intervals that I added in the Points of Interest track, but now I can also see much more detailed information about the network requets I'm making to get that data.

Daniel's surfacing a couple of things to me here, like the average number of requests I'm making per second. And he's showing me every single request I'm making, and exactly how long each one took. He's even providing me insight into times that I've made unnecessary duplicate requests, which are highlighted in red -- I'm leaving a lot of performance on the table.

This Custom Instruments package gives me insight into my usage of the networking framework. Ultimatley, thats going to help me use the framework more effectively.

signposts and Custom Instruments are two great ways to surface your own data in Instruments. And thats a look at the new performance tools.
