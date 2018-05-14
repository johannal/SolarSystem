## Part 1 -- IB and Asset Catalog

This is Xcode 10 -- gorgeous in dark. And it's got some great new features that make it easy for you to adopt the dark look. Let me show you.

So here, I'm in the middle of converting my Solar System exploration app to support the new dark look. The first thing I did, which you can see right here, was to pull all of the colors I had hard coded in my IB file into an asset catalog. In Xcode 10, I can add color variants, both a light and dark version, and then AppKit will pick the right one to use.

I still need to update the fill color for these two views here -- lets do that now. I'll select them both, pop open the "Fill Color" popup button, and type "badge". I want to use badgeBackgroundColor, which you can see comes from my asset catlog here. I'll select that, and it looks pretty good.

Now as I make all these changes to for dark mode, I want to be careful and make sure that things still look great in light. I can do that all right from IB. I'll open up the layout bar, where I can toggle my UI between light and dark. This looks good.

## Part 2 -- SCM + Source Editor

I've updated all my user inrterface files, not I've got just a couple more hard coded colors to change over here in my source code.

Now before I even start editing here, I can see that Xcode is telling me something. Rigth here, there are change bars, which is letting me know that someone committed and pushed a change, which I don't have yet. I'll click the change, and I can see that it looks like Andrew has been going through and adding some comments to our code.

I reallly like having this information, because it helps me avoid conflicts. If I started editing here, I'd end up with a conflict to deal with later.

So before I start making changes, I'll go to Source Control > Pull… to get the latest updates.

Looks like Andrew has added some pretty substantial comments here! I'm just going to fold those out of the way. I'll use the code folding ribbon, which is back in Xcode 10. And by the way, code folding got a really nice upgrade this year -- you can fold pretty much anything between two braces across any language.

Alright, now I can see what I'm doing. So these are the three methods I was talking about -- I want to use named colors instead of the hardcoded RGB values.

While I'm at it, I'm going to convert these to be properties instead of methods, just to be a good Swift citizen.

With Xcode 10, I can make all three changes at the same time. I'll just drop a cursor at the beginning of each line, by holding down Shift and Control and then clicking.

Now I'll select "func" on each line -- as I select with my cursors, they all do the same thing and behave just like a single cursor. I'll type "var".

Now I'll jump to the end of the word here, which I can do by holding Option and pressing the right arrow. I'll get rid of these parens along with the arrow, and add a colon. Done -- three edits all at once.

You may have noticed as I was making edits that Xcode is showing me a different kind of change bar, this time for my own uncommitted changes. I find this really handy for picking out my edits in a file.

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
