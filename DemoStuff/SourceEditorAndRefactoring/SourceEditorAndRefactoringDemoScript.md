Thanks Matthew.

Xcode 9 includes a brand new source editor written from the ground up to be super fast. And I think speed is the first thing you'll notice when you start scrolling around in your code.

    [scroll down and then up in SolarSystemView.swift]

I can scroll around in this 10,000 line file like nothing — all the way to the bottom, and I can jump instantly back to the top. Really fluid.

And the code looks beautiful too. Let hit Command-plus a few times to make that a little bigger for you — thats one of my favorite new features by the way. It’s the little things, right?

    [press Command-plus a few times]
    
Let’s jump over to this Objective-C file, where I’m going to add some code.

    [type "demo1"]

You can see the new issues presentation, with fix-its built right in. This issue is new, and warns me that I’m using iOS 11 API, but I deploy back to iOS 10. I’ll accept the fix, which wraps my code in the new Objective-C **@available** keyword. So now, the code I just added will only run on iOS 11. 

Great to be able to catch this kinda thing at compile time. 

Fix-it’s can also help me out by adding new code.

    [navigate to Moon.swift]
    
Over here in Moon.swift, I’m going to adopt the PhysicsBody protocol, which has three methods.
    
    [type ", PhysicsBody" after "Equatable" on line 11]
    
I haven't implemented those methods, so I get an issue. New in Xcode 9, I get a single fix-it that will implement **all** of the methods at once. I really like this one.

----------------------------------------

Issues and fix-it’s are great at helping fix code that isn't quite right — ideally we’d avoid that state to begin with.

When I hold down the Command key and mouse around, I see the structure of my code highlighted in light blue. When I click, I get options and transformations for that bit of structure.

    [Command click on the class around line 11]
    
Since this is a class, I can do things like add a method or property.

I can also use this new popover to transform code.
    
I like descriptive variable names and small expressions. I’d rather have this Moon object captured in a variable. So I'll Command click Moon and select "Extract Expression", and then rename this to “luna”. Easy.

    [Command click on "Moon" around line 51 and select "Extract Expression…"]
    
I also like my methods to be small and concise. I’m going to pull out this big if block, into it's own method. You can see that Xcode pulled the method out and put it up above, here and left me with a call to the method where the code was originally sitting. Let’s give that a good name — how about "addJupitersMoons" since thats what it’s doing.

    [Command click on the trailing "}" around line 56 and select "Extract Method…"]
    
Changing the shape of my code is really quick and easy.
    
Now those were local some transformations. Often though, I want to change the name of something thats used across my entire project.

Here I’ve got this method named “position” — now I think I can come up with something more descriptive than that. I'll hold down Command and click on the method, and choose rename.

    [Command-Control click on “position” around line 68 and choose "Rename…"]
    
When I do that, Xcode collapses down that file we were looking at and pulls in all the other files across my project that call this method. So what would be a better name here… how about “orbitalPosition” -- that sounds good. When I start typing, I see my changes reflected across all of the call sites. I can change parameter names too — I’ll change the second parameter name to “momentInTime”.

When I’m done, I click "Rename” - thats it. Really easy.

Renaming can works across Storyboards, and Objective-C too. Let me make another change that will have a bigger impact across my project. This class name here, “TransNeptunianObject”, sure is a mouthful to say — lets go with something a little simpler. I’ll Command click on the class and select rename. Instead of this name, lets go with “MinorPlanet” instead.

This class has a file of the same name — that’ll be updated.

Here theres a matching comment. Comments are opted out by default, but I can opt it back in to click the token.

Here are a couple in this Storyboard — those will be updated for me.

And all the way down at the bottom we can see I’m using the class in Objective-C — those will be updated too. Renaming works great across languages.

That all looks good to me, so I’ll click rename, and I’m done. Really simple. Really powerful.

And thats the new source editor and refactoring in Xcode 9.
 
----------------------------------------

Turn off line highlighting
Turn off code completion
defaults write com.apple.dt.Xcode CodeRollMatchThemeTextSize -bool YES
defaults write com.apple.dt.Xcode SourceEditorTransientStructureColor "0.3 0.5 1 0.75"
