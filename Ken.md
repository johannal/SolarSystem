
[Start off in a "arbitrary" file.]

[Use jump to definition on a symbol to show off the new disambiguating UI. Mention that we want to update our app for Skyglow.]
-- Probably want the symbol to have ambiguous results?

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
