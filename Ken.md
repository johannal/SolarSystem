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

[Let's jump over to my source code, where I want to continue my adotion of dark.]

[First off, I want to make these methods public, since I'm going to use them through my project.]

[That's really easy to do in Xcode 10, I'll just drop a cursor in front of each method by holding Shift and Control and then clicking. I'll type "public". While I'm at it, I should add some documentation -- I'll just press the up arrow, and then select the Editor > Structure > Add Documentation action. I'll fill that in later.]

  -- <rdar://problem/39443933> Justice10A156: Add Documentation action doesn't add documentation for every cursor

[Each of these methods is handing back a color, but those colors are all hard coded. Thats not going to work for dark. What I need to do is convert each of these to instead return a named color. Remember that those named colors will automatically switch based on the system appearance for me.]

[I'm going to edit all of these at once, using multiple cursors. I'll drop a cursor in front of each variable name -- those names are also the names of the colors in my asset catalog.]

    let someColor = NSColor(red:1.0 green:1.0 blue:1.0 alpha:1.0)
        ^

[Now I'll hold down Command and Option and then press the right arrow to select all of the variable names. ]

    let someColor = NSColor(red:1.0 green:1.0 blue:1.0 alpha:1.0)
        ^-------^

[I'll copy those (select Edit > Copy). Now I'll select the code between the parens, thats using the NSColor initializer that takes hard coded values.]

    let someColor = NSColor(red:1.0 green:1.0 blue:1.0 alpha:1.0)
                            ^----------------------------------^

[I'll delete that, and use the named color initializer.]

    let someColor = NSColor(NSColor.Name(rawValue: ""))
                                                    ^

[Now, I'll paste in the names of the colors.]

    let someColor = NSColor(NSColor.Name(rawValue: "someColor"))

[There we go! Now we're using colors from our asset catalog, which will automatically update as when the system appearance changes.]

## Part 3 -- SCM

[You may have noticed as I've been making edits, the source editor is showing me which code I've changed, over here in the change bar. This is really helpful when looking through your code for the local edits you've made.]

[Xcode can also show you the changes that have been made up stream, too (scroll down to some changes Andrew made). Right here, I can see that Andrew has been making changes. If I start typing there, Xcode tells me that I'll have a conflict when I go to commit. This is great information to have -- now I know to pull before I start making edits here -- I really prefer to not have to resolve conflicts!]

[[ DO SOMETHING WITH THE CHANGE, MAYBE LOOK AT IT?]

## Wrap Up
** [Lots of small improvements to the editor that help make you even more productive] **

## Appendix

### Code Change 1

**Start:**
    func orbitPathColor() -> NSColor {
        return NSColor(red: 0.34, green: 0.532, blue: 0.541, alpha: 0.75)
    }

    func orbitSelectedPathColor() -> NSColor {
        return NSColor(red: 0.28, green: 0.49, blue: 0.14, alpha: 0.9)
    }

    func orbitHaloColor() -> NSColor {
        return NSColor(red: 0.74, green: 0.74, blue: 1.0, alpha: 0.3)
    }

**End:**
    var orbitPathColor: NSColor {
        return NSColor(red: 0.34, green: 0.532, blue: 0.541, alpha: 0.75)
    }
    
    var orbitSelectedPathColor: NSColor {
        return NSColor(red: 0.28, green: 0.49, blue: 0.14, alpha: 0.9)
    }
    
    var orbitHaloColor: NSColor {
        return NSColor(red: 0.74, green: 0.74, blue: 1.0, alpha: 0.3)
    }
