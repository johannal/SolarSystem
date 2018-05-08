## Part 1 -- Asset Catalog and IB

This is Xcode 10 -- gorgeous in dark. In addition to just looking great, Xcode 10 has some  new features that make it easy for you to adopt the new dark look.

I'm in the middle of converting my Solar System exploration app to support the new dark look. I started by moving all of my hard coded colors into an asset catalog. Xcode 10 adds color variants, so for any color I can have both a light and a dark version, and then AppKit will pick the right one based on the system preference.

I've got one more thing to change here -- this rounded rect behind the sun rise and sun set read-outs is still hard-coded. I'll select both of these views, pop open the "Fill Color" popup button, and choose one of my new asset catalog colors.

As I make all these changes to for dark mode, I want to make sure that things are still looking great in light. I can do that right from IB. I'll open up the layout bar, where I can toggle my UI between light and dark -- this makes it really easy to iterate. Looking pretty good.

## Part 2 -- Source Editor

I'm going to jump over to my source code, and get rid of a few more hard coded colors.

Let me collapse some of this code. I can use the action popover for that. Or, I can use the the code-folding ribbon that we've reintroduced in Xcode 10. Code folding has been enhanced too -- you can fold pretty much anything between two braces across any language.

As I look at this code, I think these methods here that are returning colors should actually be properties. With Xcode 10, thats a really easy change to make. I'll just drop a cursor at the beginning of each line, by holding down Shift and Control and then clicking. If I add a cursor I don't want, I can just click the same spot again to get rid of it.

Now I'll select "func" on each line, and I'll replace that with "var".

Now I'll jump to the end of the word here, which I can do by holding Option and pressing the right arrow. I'll get rid of these parens along with the arrow, and add a colon. Easy.

  <rdar://problem/39443933> Justice10A156: Add Documentation action doesn't add documentation for every cursor

Now I also want to update these colors here. They're hardcoded , which isn't going to work for dark. 

So, I'm going to select each of these property names -- they are conviently also the names of the colors in the asset catalog. I'll select backwards to the beginning of the word, then I'll copy it by selecting Edit > Copy.

I'll arrow down to the next line here, and arrow forward to the beginning of the RGB initializer, and then I'll select all of it.

I'll delete that and type 'named: NSColor.Name(""))!', and then paste the color names here between the quotes. Done! Three changes all at one -- trippled my productivity!

## Part 3 -- SCM

You may have noticed as I've been making edits, the source editor is showing me exactly which code I've changed, over here in the change bar. These are my local, uncommited edits.

Xcode can also show me the changes that have been made up stream, too. So right here, theres a change that I'll get when I pull. 

Now I really dislike conflicts, which is what I'd get if I started typing here, like this. Xcode 10 helps me avoid conflicts showing me the code that has changed out from underneath me. The best kind of conflict, is the one you don't get!

I can get more details on the commit if I want. Looks like Andrew has taken care of this TODO by adding some comments, so I don't have to -- my changes are complete!

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
