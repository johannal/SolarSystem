## Setup
defaults write com.apple.dt.Xcode EnableBatchEditing -bool false

## Part 1: IB and Asset Catalog

Xcode 10 -- gorgeous in dark. And it's got some great new features that make it easy to adopt the dark look. Let me show you.

I'm in the middle of updating my Solar System exploration app to support the new dark look. The first thing I did, was to pull all of the colors I had hard coded across my project into this asset catalog here. In Xcode 10, I can add color variants, so I can have both a light and dark version, and then AppKit will pick the right one to use.

In my planet details UI here, I still need to update the fill color for these two views that sit behind the sunrise and sunset readouts. I'll select them both, then click on the "Fill Color" popup button, and type "badge". I want to use badgeBackgroundColor, which you can see comes from my asset catalog here. I'll select that, and now I can read the text.

As I make all these changes for dark mode, I want to make sure that things still look great in light. I can do that without ever leaving IB. I'll open up the layout bar, where I can toggle my UI between light and dark. Really quick and easy to itereate.

## Part 2: SCM + Source Editor

That takes care of my user interface files, but know I've got just a few more hard coded colors in my source code. I'll jump to SolarSystemSceneViewController, where I've got these hard codeded RGB values, which won't automatically change with the appearance.

Before I start editing, I can see that Xcode is telling me someone committed and pushed a change, which I don't have yet. It looks like Andrew has been going through and adding some comments to our code.

I want to avoid merge conflicts later, so I'm going to get the latest version by selecing Source Control > Pull….

Wow -- those are seom serious comments! I'm going to use the code folding ribbon, which is back in Xcode 10, to fold these out of the way. By the way, code folding got a really nice upgrade this year -- you can fold pretty much anything between two braces across any language.

Alright, now I can see what I'm doing. Here are the methods returning hardcoded RGB values.

I'm going to start with a little code cleanup. Rather than methods, I think these would be better as properties.

With Xcode 10, I can change all three of these at once. I'll hold down Shift and Control and click here to drop another cursor, and then one more down here.

These cursors behave just like you'd expect, I can select, and type, and jump by word. I'll delete these parens and this arrow. One, two, three methods changed to properties all at the same time.

By the way, as I was making those edits you may have noticed that Xcode is showing me those change bars, this time for my own uncommitted changes.

Let's finish up here and convert these RGB colors to named colors.

I'm going to select each of these property names. Conviently, my proprety names match the asset catalog color names.

I'll arrow down to the next line here, and move forward to the beginning of the initializer. I'll select the RGB initializer and replace that with the named color version.

Done! One, two, three changes all at the same time with Xcode's new multi-cursor feature.

## Wrap Up
And with that, I think my app is now ready for dark. 

(Those are some of the new editing experiences in Xcode 10.)
