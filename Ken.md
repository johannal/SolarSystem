## Part 1 -- IB and Asset Catalog

This is Xcode 10 -- gorgeous in dark. In addition to just looking great, Xcode 10 has some  new features that make it easy for you to adopt the new dark look.

I'm in the middle of converting my Solar System exploration app to support the new dark look. I started by moving all of my hard coded colors into an asset catalog. Xcode 10 adds color variants, so for any color I can have both a light and a dark version, and then AppKit will pick the right one based on the system preference.

I've got one more thing to change here -- this rounded rect behind the sun rise and sun set read-outs is still hard-coded. I'll select both of these views, pop open the "Fill Color" popup button, and choose one of my new asset catalog colors.

As I make all these changes to for dark mode, I want to make sure that things are still looking great in light. I can do that right from IB. I'll open up the layout bar, where I can toggle my UI between light and dark -- this makes it really easy to iterate. Looking pretty good.

## Part 2 -- SCM + Source Editor

I've got a couple more changes to make. Over here in my source code, there are still a few hard coded colors.

Before I even start editing here, I can see that Xcode is telling me something. In the gutter I see these change bars. This particular change bar is letting me know that there have been changes to this file upstream -- someone committed and pushed a change that I havne't pulled yet. I can click on the change bar to see more detail about the change -- looks like Andrew has added some comments to these methods.

If I started editing here, I'd end up with a conflict later -- I don't like conflicts, so I love being able to see this.

So before I start making changes, I'll go to Source Control > Pull… to get the latest updates.

Sure enough, Andrew has added some pretty substantial comments for these color methods! I'm just going to fold those out of the way. I'll use the code folding ribbon, which is back in Xcode 10. And by the way, code folding got a really nice upgrade this year -- you can fold pretty much anything between two braces across any language.

OK, now I can see what I'm doing. I want these three methods to use named colors instead of the hardcoded colors they are returning now.

And you know, as I look at these methods, I think they should really be Swift properties instead. Let me start there.

With Xcode 10, thats a really easy change to make. I'll just drop a cursor at the beginning of each line, by holding down Shift and Control and then clicking. If I add a cursor I don't want, I can just click the same spot again to get rid of it.

Now I'll select "func" on each line -- as I select with my cursors, they all do the same thing. I'll type "var".

Now I'll jump to the end of the word here, which I can do by holding Option and pressing the right arrow. I'll get rid of these parens along with the arrow, and add a colon. Easy!

You may have noticed as I was making edits that Xcode is showing me change bars, this time for my own uncommitted changes. I find this really handy for picking out my edits in a file.

I came here to update these colors, so let me finish doing that. I'll convert these to use named colors so that they automatically switch as the appearance changes.

I'm going to select each of these property names -- they are conviently also the names of the colors in the asset catalog. I'll select backwards to the beginning of the word, then I'll copy it by selecting Edit > Copy.

I'll arrow down to the next line here, and arrow forward to the beginning of the RGB initializer, and then I'll select all of it.

I'll delete that and type 'named: NSColor.Name(""))!', and then paste the color names here between the quotes. Done! Three changes all at once -- trippled my productivity!

## Wrap Up
And those are some of the new editing experiences in Xcode 10.

## Appendix

### Pre Code Change

    func orbitPathColor() -> NSColor {
        return NSColor(red: 0.34, green: 0.532, blue: 0.541, alpha: 0.75)
    }

    func orbitSelectedPathColor() -> NSColor {
        return NSColor(red: 0.28, green: 0.49, blue: 0.14, alpha: 0.9)
    }

    func orbitHaloColor() -> NSColor {
        return NSColor(red: 0.74, green: 0.74, blue: 1.0, alpha: 0.3)
    }

### Post Code Change

    var orbitPathColor: NSColor {
        return NSColor(NSColor.Name("orbitPathColor"))
    }
    
    var orbitSelectedPathColor: NSColor {
        return NSColor(NSColor.Name("orbitSelectedPathColor"))
    }
    
    var orbitHaloColor: NSColor {
        return NSColor(NSColor.Name("orbitHaloColor"))
    }
