## Part 1 -- Asset Catalog and IB

Xcode 10 makes it easy to adopt the new dark look in your app. I'm in the middle of doing that here in my app called "Solar System".

I use a lot of custom colors, and I want those colors to adapt to the system appearance. To do that I can use the new color slots in asset catlog. I've added a bunch of colors already, and you can see that I've specified light and dark variants for each. I can even add variants for high contrast and vibrant contexts.

I'm going to add one more color. I'm going to use this color behind my sunrise and sunset indicators -- lets change the light one to be blah[some color], and the dark one to be blah[some color].

  <rdar://problem/39443829> Justice10A156: Inspector content flickers when toggling new slot for Asset Catalog color

Now I'm going to jump over to my storyboard file, where I'm working on this bit of planet inspector UI. 

It's all looking pretty good, but the text behind the sunrise and sunset indicators is hard to read, so I want this background color to adapt.

I'll select each of these boxes, and then pop open the "Fill Color" popup button in the Attributes Inspector. In this list, I can see a whole bunch of colors, a lot of which are system colors that will automatically adapt based on the appearance.

Up at the top of this list are the colors from my asset catalog. I'm going to choose this readoutBackgroundColor that I just created.

That looks good. Now I want to make sure that things are still looking good in light, so I'm goign to pop open the bar here at the bottom of IB. I can toggle my UI between light and dark. It's looking mostly good, but it looks like I may have broken this other location readout up here.

One really handy way to work is to open up the Preview. Now I can see my UI in light and dark at the same time. Let's make that location readout use the same color.

## Part 2 -- Source Editor

Thats looking good. I'm jump over to source code, and make a few more changes to support the dark appearance.

Let me collapse some of this code. In Xcode 10, we've re-introduced the code-folding ribbon, for all of you that are into that kind of thing. We've also enhanced code folding across all the languages, so you can pretty much collapse anything between two braces.

As I look at this code, I think these methods here that are returning colors should actually be properties. With Xcode 10, thats a really easy change to make. I'll just drop a cursor at the beginning of each line, by holding down Shift and Control and then clicking. If I add a cursor I don't want, I can just click again in the same spot.

Now I'll hold down Command and Option and press the right arrow to select "func" on each line. I'll replace that with "var".

Now I'll arrow over and get rid of the parens and the right arrow, and add a colon. Easy.

  <rdar://problem/39443933> Justice10A156: Add Documentation action doesn't add documentation for every cursor

I also want to update these colors here. They're hardcoded now, which isn't going to work for dark. 

I'll drop a cursor in front of each property name, holding down Control and Shift and clicking.

Then I'm going to hold down Command and Option and press right arrow to select the property names. I'll copy that by selecting Edit > Copy.

Now I'll move my cursors down onto the next line, over to where the color initializer is. I'm going to delete everything in between the parens -- those are hard-coded values we don't want.

I'll type "NSColor.Name(""), and then paste the color names by selecting Edit > Paste.

We just updated three bits of code all at the same time! And now our colors will update automatically when we change the system appearance.

## Part 3 -- SCM

[You may have noticed as I've been making edits, the source editor is showing me which code I've changed, over here in the change bar. This is really helpful when looking through your code for the local edits you've made.]

[Xcode can also show you the changes that have been made up stream, too (scroll down to some changes Andrew made). Right here, I can see that Andrew has been making changes. If I start typing there, Xcode tells me that I'll have a conflict when I go to commit. This is great information to have -- now I know to pull before I start making edits here -- I really prefer to not have to resolve conflicts!]

[[ DO SOMETHING WITH THE CHANGE, MAYBE LOOK AT IT?]

## Wrap Up
** [Lots of small improvements to the editor that help make you even more productive] **

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
