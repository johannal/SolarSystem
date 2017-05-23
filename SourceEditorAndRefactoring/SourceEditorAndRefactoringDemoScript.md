Thanks Matthew.

Xcode 9 includes a brand new source editor written from the ground up to be super fast. In fact, speed is the first thing I think you'll notice.

    [scroll down and then up in SolarSystemView.swift]

It's fully layer backed and opts in to responsive scrolling. I can grab the scroll thumb in this 10,000 line file and drag it around like nothing. I can jump instantly to bottom and right back to the top. Really fluid.

In case my code is a bit too small for you to read, let me bump up the font size using Command plus — thats one of my favorite new features.

    [press Command-plus a few times]
    
Really handy for a code review, or a even a demo. It’s the little things, right?

OK, now that you can read my code, I’m going to introduce a little problem.

    [type "demo1"]

I just added some code that is using new iOS 11 API. Now the problem is that my project deploys back to iOS 10, which means this will crash when my users run on an iOS 10 device. But as you probably noticed, Xcode can now warn me when I’m using API in Objective-C, thats too new for my minimum deployment target.

There’s a fix-it which I'll accept. Thats going to wrap my code in the new Objective-C **@available** keyword. So now, this code will only run on iOS 11. This is exactly the kind of thing you want to be told at compile time, and I think it’s a huge win for quality.
    
Let me show you one more new fix-it, this is my favorite new one. I don’t really like to type or click more than I have to…

    [navigate to Moon.swift]
    
Over here in Moon.swift, I’m going to conform to the PhysicsBody protocol, which has a three methods.
    
    [type ", PhysicsBody" after "Equatable" on line 11]
    
I haven't implemented those methods yet, so I get a an issue. New in Xcode 9, I get a single fix-it that will implement **all** of the methods in one go. I like this one.

----------------------------------------

Issues and fix-it’s are great at helping fix code that isn't quite right. But avoiding those bad states in the first place is even better. We brought back a concept from Swift Playgrounds that lets you symbolically manipulate your code.

When I hold down the Command key and mouse around, I see structure under my mouse highlighted in light blue. When I click, I get options and transformations for that statement.

    [Command click on the class around line 11]
    
Siunce this is a class, I can add a method or property. Or if I wanted to jump straight to the definition and short circuit the popover, I could do that by holding down Command and Control and then clicking the symbol.

I can also use the new popover to transform code.
    
Personally, I like code to be self describing with nice variable names and small expressions. I'd prefer if the creation of the Moon here were captured in a variable. I'll Command click Moon and select "Extract Expresssion", and then rename this to "earthsMoon".

    [Command click on "Moon" around line 51 and select "Extract Expression…"]
    
I also like my methods to be small and concise, so I’m going to pull out this big chunk here thats adding Jupiter's moons, into it's own method. And I'll rename that "addJupitersMoons".

    [Command click on the trailing "}" around line 56 and select "Extract Method…"]
    
Changing the shape of my code is really quick and easy.
    
Now those were local some transformations. But often, I want to change the name of something thats used across my entire project.

Here I’ve got this method named “position” — I think I can come up with something more descriptive. I'll hold down Command and click on the method, and choose rename.

    [Command-Control click on “position” around line 68 and choose "Rename…"]
    
When I do that, Xcode collapses down that file and pulls in all the other files across my project that will be affected by this. To help keep things focused, I see just the line that will change and a little context around it. What would be a better name here… how about “orbitalPosition” -- that sounds good. When I start typing, I see my changes reflected across all of the call sites. I'll change the second parameter name too -- how about “momentInTime”.

When I’m done, I click "Rename”, and thats it. Really easy.

Now that was a pretty simple example. Let me change the name of this class which is going to have more impact across my project. This name here, “TransNeptunianObject”, is a mouthful to say the least — lets go with something a little simpler. I’ll Command click on the class and select rename, and let use “MinorPlanet” instead.

Since this is a class name, the name of the file needs to change too. This slice here shows us that the file name is being updated.

Theres also a comment that uses my class name. Comments are bit tricky, so Xcode err’s on the side of caution and will offer the change, but it's only going to rename it if I say that specifically what I want. I do want the comment to change, so I’ll click the token to toggle it on.

Theres a couple of uses of my class in this Storyboard — those will be updated for me.

And all the way down at the bottom we can see my class is used in Objective-C — those will be updated.

That all looks good to me, so I’ll click rename, and I’m done. Really simple. Really powerful.

And thats the new source editor and refactoring in Xcode 9.
 
----------------------------------------

defaults write com.apple.dt.Xcode CodeRollMatchThemeTextSize -bool YES
defaults write com.apple.dt.Xcode SourceEditorTransientStructureColor "0.3 0.5 1 0.75"
