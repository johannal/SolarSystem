## Part 1 -- Asset Catalog and IB

[Start off an asset catalog file open. Talk about how I'm in the middle of converting my app to adapt to dark.]
  -- System is in dark
  
[Add a new color. In the Inspector, opt it in to "Dark". Also mention that we can provide variants that will be used in high contrast or vibrant contexts. Point out that this all happens automatically -- all I need to do is used the right named color.]
  -- The color we're adding here is one that we'll use when we switch over to IB
  -- <rdar://problem/39443829> Justice10A156: Inspector content flickers when toggling new slot for Asset Catalog color

[Switch over to a storyboard in IB]
  
[Select an NSBox that is being used as a container (the box has a custom border and background color). In the Attributes Inspector, pop the "Fill Color" popup. Mention that I see many system colors here, which will automatically update based on the light and dark. I can also see my owned named colors up at the top of the popup menu. Select whatever color we just added in the asset catalog.]

[I'd like to see how this looks in light, just to make sure I've got it right. Theres a new button down here in the bottom bar, which gives me the ability to change the appearance of my content (toggle to light, then toggle back to dark).]

[I can also bring up a second view onto this UI in the Assistant (toggle to the Assistant editor, then switch to Preview). Down in the bottom bar, I can add a preview of the UI in light. Now, as I make changes, I can see what it will look like in both light and dark (switch the fill color to systemBlue, and then back to the original named color). This is a really nice way to quickly develop your UIs for both modes.]

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
