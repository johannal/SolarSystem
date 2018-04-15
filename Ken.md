## Part 1 -- Asset Catalog and IB

[Start off an asset catalog file open. Talk about how I'm in the middle of converting my app to adapt to dark.]
  -- System is in dark
  
[Add a new color. In the Inspector, opt it inot "Dark". Also mention that we can provide variants that will be used in high contrast or vibrant contexts. Point out that this all happens automatically -- all I need to do is used the right named color.]
  -- The color we're adding here is one that we'll use when we switch over to IB

[Switch over to a storyboard in IB]
  
[Select an NSBox that is being used as a container (the box has a custom border and background color). In the Attributes Inspector, pop the "Fill Color" popup. Mention that I see many system colors here, which will automatically update based on the light and dark. I can also see my owned named colors up at the top of the popup menu. Select whatever color we just added in the asset catalog.]

[I'd like to see how this looks in light, just to make sure I've got it right. Theres a new button down here in the bottom bar, which gives me the ability to change the appearance of my content (toggle to light, then toggle back to dark).]

[I can also bring up a second view onto this UI in the Assistant (toggle to the Assistant editor, then switch to Preview). Down in the bottom bar, I can add a preview of the UI in light. Now, as I make changes, I can see what it will look like in both light and dark (switch the fill color to systemBlue, and then back to the original named color). This is a really nice way to quickly develop your UIs for both modes.]

## Part 2 -- Source Editor & SCM

[Let's jump over to my source code, where I want to make a few changes.]

[First off, I want to make these methods public, since I'm going to use them through my project.]

[That's really easy to do in Xcode 10, I'll just drop a cursor in front of each method by holding Shift and Control and then clicking. I'll type "public". While I'm at it, I should add some documentation -- I'll just press the up arrow, and then select the Editor > Structure > Add Documentation action. I'll fill that in later.]

  -- <rdar://problem/39443933> Justice10A156: Add Documentation action doesn't add documentation for every cursor

[]

[The method we jump to is at the bottom of the file. Scroll all the way down to show overscroll.]

[simpler example here to start -- maybe editing method modifiers?]

[In that method, there are a bunch of hard-coded colors]

[Switch over to asset catlog to show that I've already added entries for these colors, including both a light and a dark version]
  -- Maybe add one color?
  -- Mabye talk about the different slots (dark, vibrant, high contrast)?
  -- Should I mention images here?

[Go back over to the source file, where we're going to change hard-coded colors to named colors]
  -- Maybe fold some code here to bring a few of the colors I want to switch to named colors into view? Also could fold something that wasn't fold-able before.
  -- Maybe switch the cursor to the block cursor

[Use mutltiple cursors to do something like the following transformation]

  1) starting state
    let orbitPathColor = NSColor(red:1.0 green:1.0 blue:1.0 alpha:1.0)
    let orbitPathSelectedColor = NSColor(red:1.0 green:1.0 blue:1.0 alpha:1.0)

  2) multi-cursor word-select color names
      let orbitPathColor = NSColor(red:1.0 green:1.0 blue:1.0 alpha:1.0)
          ^------------^
      let orbitPathSelectedColor = NSColor(red:1.0 green:1.0 blue:1.0 alpha:1.0)
          ^--------------------^
      
  3) multi-cursor select old initializer
      let orbitPathColor = NSColor(red:1.0 green:1.0 blue:1.0 alpha:1.0)
                                   ^----------------------------------^
      let orbitPathSelectedColor = NSColor(red:1.0 green:1.0 blue:1.0 alpha:1.0)
                                           ^----------------------------------^
                                           
  4) multi-cursor type named color initializer
      let orbitPathColor = NSColor(NSColor.Name(rawValue: ""))
                                                           ^
      let orbitPathSelectedColor = NSColor(NSColor.Name(rawValue: ""))
                                                                   ^
                                                                   
  5) multi-cursor paste color names
      let orbitPathColor = NSColor(NSColor.Name(rawValue: "orbitPathColor"))
                                                                         ^
      let orbitPathSelectedColor = NSColor(NSColor.Name(rawValue: "orbitPathSelectedColor"))
                                                                                         ^

[I've got a couple more changes I want to make down here.]
  -- Describe the change, and start making it.

[But you know, before I do, I want to be able to see upstream changes, as well. So just like I can see lines of code I've changed over here in the change bar, if I want, I can also see code that is being changed by other people.]
  -- Open Preferences > Source Control, toggle "Include upstream changes"
  
[Back in the source code, notice that we now have a conflict -- I was changing code that Andrew was also modifiying.]
  -- Click the change bar and discard my change
  -- Click Andrew's change to see what he was doing
  -- Mention/point out that I could view Andrew's full change in the Version editor

** [Lots of small improvements to the editor that help make you even more productive] **



---------------------------

1. Using the new source editor features make changes
   * multi-cursor editing
   * code-folding
   * over-scroll
   * Jump to definition enhancments
   * Callers in action popover

2. Using the SCM annotations to view changes
   * showing local changes
   * showing upstream changes
   * related SCM actions (jump to version editor)?
      * Discard change
      * Show log info for upstream changes
      * Show last change for line
      * Show in versions editor
         * Version editor re-theme, even awesomer
      * Jump to next/previous change, local/upstream/locally committed

3. Design tools for Dark Mode
   * asset catalog support
      * New color slots (vibrancy/dark/high contrast)
      * New image slots (vibrancy/dark/high contrast)
      * Performance improvements for large catalogs
   * interface builder support
      * Trait bar (switch between light and dark)
      * Assistant editor preview of light and dark
      * Color selection in Inspector (shows active color set based on canvas)
         * Refactor to named color (not in yet)
      * Designables (maybe show this and how it adapts to appearnace changes)
      * Object library in toolbar
      * 

-- OTHER -- 
      * ARKit 2D/3D assets (asset detection)
