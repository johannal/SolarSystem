## Part 1 -- Asset Catalog and IB

This is Xcode 10 -- gorgeous in dark. In addition to just looking great, Xcode 10 has some  new features that make it easy for you to adopt the new dark look.

One of the first things you'll want to think about is colors. The best thing to do is start by pulling all those colors into an asset catalog. Last year, we introduced named colors, and this year, we've added support for dark, high contrast and vibrant variants.

So all I need to do is specify the colors I want here, and AppKit will pick the right ones to draw with based on the system preferences.

While we're here, I'm going to add one more color, which I'll use as the background for some text. For light, I'll go with a 90% white. In dark, I'll go with a 40% white.

  <rdar://problem/39443829> Justice10A156: Inspector content flickers when toggling new slot for Asset Catalog color

Now I'm going to jump over to my UI and use this color.

My app lets users explore our Solar System. And I've got these two readouts here that show the sunrise and sunset time for the selected planet.

You can see that this rounded rect still looks like it's using the color meant for light UI -- definitley does not look good in dark. So lets change these two views to use that color I just defined.

I'll select each of these boxes, and then pop open the "Fill Color" popup button in the Attributes Inspector. In this list, I can see a whole bunch of colors, a lot of which are system colors that will automatically adapt based on the appearance.

Up at the top of this list are the colors from my asset catalog. I'm going to choose this sunRiseSunSetBackgroundColor that I just created.

Now I want to make sure that things are still looking good in light, so I'm going to pop open the bar here at the bottom of IB. I can toggle my UI between light and dark. It's looking pretty good.

## Part 2 -- Source Editor

I'm going to jump over to source code, and make a few more changes to support the dark appearance.

Let me collapse some of this code. In Xcode 10, we've re-introduced the code-folding ribbon, for all of you that are into that kind of thing. We've also enhanced code folding across all the languages, so you can pretty much collapse anything between two braces.

As I look at this code, I think these methods here that are returning colors should actually be properties. With Xcode 10, thats a really easy change to make. I'll just drop a cursor at the beginning of each line, by holding down Shift and Control and then clicking. If I add a cursor I don't want, I can just click again in the same spot.

Now I'll hold down Shift and Option and press the right arrow to select "func" on each line. I'll replace that with "var".

Now I'll arrow over and get rid of the parens and the right arrow, and add a colon. Easy.

  <rdar://problem/39443933> Justice10A156: Add Documentation action doesn't add documentation for every cursor

I also want to update these colors here. They're hardcoded now, which isn't going to work for dark. 

I'll drop a cursor in front of each property name, holding down Control and Shift and clicking.

Then I'm going to hold down Command and Option and press right arrow to select the property names. I'll copy that by selecting Edit > Copy.

Now I'll move my cursors down onto the next line, over to where the color initializer is. I'm going to delete everything in between the parens -- those are hard-coded values we don't want.

I'll type "NSColor.Name(""), and then paste the color names by selecting Edit > Paste.

We just updated three bits of code all at the same time! And now our colors will update automatically when we change the system appearance.

## Part 3 -- SCM

You may have noticed as I've been making edits, the source editor is showing me which code I've changed, over here in the change bar. This is really helpful when looking through your code for the local edits you've made.

Xcode can also show you the changes that have been made up stream, too (scroll down to some changes Andrew made). Right here, theres a change that I'll get when I pull. 

I really dislike conflicts, which is what I'd get if I started typing here, like this. Now, I can avoid conflicts  altogether by seeing what code is being changed around me. The best kind of conflict, is the one you don't get!

Theres a TODO here to update the comment, but it looks like Andrew already did that. If I want can jump right into the commit view and see the full change. Really fluid experience. 

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
