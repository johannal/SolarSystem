## Part 1 — os_log/os_signpost

Some great new features this year for understanding your apps performance. Let me show you.

I've recently noticed some pretty serious stutters in my Solar System exploration app when it first launches. Looks like it's stuttering when fetching data. Let me press Command-R to request data again. Yeah, definitley looks related to updating the planet data.

I'm going to add some logging and signposts to figure out whats going on. 

This is the file that requests and parses the data. I'm going to create an OSLog handle that uses the new .pointsOfInterest category. Everything I log with this will automatically show up in Instruments.

  *insert snippet 1 -- OSLog handle creation*

I'll add an os_log here when I'm about to go off and do a network request.

  *insert snippet 2 -- os_log, about to do network request*

I'll add a signpost down here, after I've gotten data back, and am just about to parse it.

  *insert snippet 3 -- os_signpost, begin*

And I'll drop another signpost after I've finished parsing the data.

  *insert snippet 4 -- os_signpost, end*

Lets run this under Instruments and see what kind of data we get. I'll go to Product > Profile, which will launch Instruments.

Up here you can see the Points of Interest track. Anything I logged with the .pointsOfInterest category shows up here. These blue bars are showing how long it's taking to parse my data.

Right away I can see that each time I'm parsing data, the main thread spikes, which means I'm probably doing my parsing on the main thread which is causing my stutter. I should really move that to a background thread.

## Part 2 — Custom Instruments

So, some really quick insight in Instruments by adding a log and a couple of signposts in my code. But you can go much further by customizing exactly which data Instruments shows you and how it shows it to you. You'll be using the same powerful core technology we use to create all the included instruments.

Let me show you a Custom Instruments package that my teammate Daniel sent me. It visualizes signposts in the networking framework that he built for our app.

I'll install it by double clicking the icon. I can see details about the package. I'll install it, and it shows up in right here in the template chooser. I'll select it, and click record, which will launch the app.

I can still see the JSON parsing intervals that I added, but now I can also see much more detailed information about the network requets I'm making to get that data.

Daniel's surfacing a couple of things to me here, like the average number of requests I'm making per second. The second track is showing me every single request I'm making, and how long each one took. He's even providing insight here about times that I've made unnecessary duplicate requests, which are highlighted in red.

The new signposts made it easy to improve the performance of my own code, and Custom Instruments gave me new insight into Daniel's framework.
