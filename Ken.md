## Part 1 -- IB and Asset Catalog

Xcode 10 -- gorgeous in dark. And it's got some great new features that make it easy to adopt the dark look. Let me show you.

So here, I'm in the middle of converting my Solar System exploration app to support the new dark look. The first thing I did, was to pull all of the colors I had hard coded across my app into this asset catalog here. In Xcode 10, I can add color variants, so I can have both a light and dark version, and then AppKit will pick the right one to use.

In my planet details UI here, I still need to update the fill color for these two views that sit behind the sunrise and sunset readouts. I'll select them both, then click on the "Fill Color" popup button, and type "badge". I want to use badgeBackgroundColor, which you can see comes from my asset catlog here. I'll select that, and it looks pretty good.

Now as I make all these changes for dark mode, I want to be careful and make sure that things still look great in light. I can do that all right from IB. I'll open up the layout bar, where I can toggle my UI between light and dark. Really quick and easy to itereate without ever running.

## Part 2 -- SCM + Source Editor

That takes care of my user inrterface files, but I've got just a few more hard coded colors to change over in my source code -- these colors here are specified as RGB values, which won't change with the appearance.

Now before I even start editing, I can see that Xcode is telling me something. Right here, the new change bars are telling me someone committed and pushed a change, which I don't have yet. I'll click the change, and I can see that it looks like Andrew has been going through and adding some comments to our code.

If I started editing here, like this, I'd end up with a conflict later. I want to avoid that, so I'm going to get the latest changes by selecing Source Control > Pull….

Looks like Andrew has added some pretty hefty comments! I'm just going to fold those out of the way. I'll use the code folding ribbon, which is back in Xcode 10. And by the way, code folding got a really nice upgrade this year -- you can fold pretty much anything between two braces across any language.

Alright, now I can see what I'm doing. Here are the methods returning hardcoded RGB values.

But I think I'll actualy start by doing a little cleanup here. I'm going to be a good citizen and convert these methods to properties instead.

With Xcode 10, I can make all three changes at the same time. I'll just drop a second cursor at the beginning of this line, by holding down Shift and Control and then clicking. And then a third cursor here.

Now I'll select "func" on each line -- as I select with my cursors, they all do the same thing and behave just like a single cursor. I'll type "var".

Now I'll jump to the end of the word here, which I can do by holding Option and pressing the right arrow. I'll get rid of these parens along with the arrow, and add a colon. Done -- three edits all at once.

By the way, as I was making those edits you may have noticed that Xcode is showing me those change bars, this time for my own uncommitted changes.

Let's finish up here by converting over to named colors.

I'm going to select each of these property names -- they are conviently also the names of the colors in the asset catalog. I'll select backwards to the beginning of the word, then I'll copy it by selecting Edit > Copy.

I'll arrow down to the next line here, and arrow forward to the beginning of the RGB initializer, and then I'll select all of it.

I'll delete that and type 'named: NSColor.Name(""))!', and then paste the color names here between the quotes. Done! One, two, three changes all at the same time with Xcode's new multi-cursor feature.

## Wrap Up
And my app is now ready for dark. Those are some of the new editing experiences in Xcode 10.
