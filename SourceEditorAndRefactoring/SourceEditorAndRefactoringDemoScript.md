Thanks Matthew.

Xcode 9 includes a brand new source editor written from the ground up to be super fast. In fact, I think the editor's speed is the first thing you'll notice.

    [scroll down and then up in SolarSystemView.swift]

It's fully layer backed and opts in to responsive scrolling. I can grab the scroll thumb in this 10,000+ line file and drag it around like it was nothing. I can jump instantly to bottom and right back to the top -- really responsive and fluid.

In case you can’t read that code, let me just bump up the font size using Command plus — thats one of my favorite new features. Really handy for a code review, or a even a demo.

    [press Command-plus a few times]
    
It’s the little things, right?

OK, now that you can read my code, I’m going to introduce a little problem.

    [type "demo1"]

I just added some code that is using new iOS 11 API. The problem is, my project deploys back to iOS 10, so this will crash when I run on an iOS 10 device. Xcode can now warn me when I’m using too-new-API in Objective-C.

There’s a fix-it which I'll accept. Thats going to wrap my code in the new Objective-C **@available** keyword, so now, this code will only run on iOS 11. This is exactly the kind of thing you want to be told at compile time, and I think it’s a huge win for quality.
    
Let me show you one more new fix-it, this is my favorite new one. I don’t really like to type or click more than I have to…

    [navigate to Moon.swift]
    
Over here in Moon.swift, I’m going to conform to PhysicsBody, which has a three methods I need to implement.
    
    [type ", PhysicsBody" after "Equatable" on line 11]
    
Xcode notices that I need to implement some methods, and now it offers me a single fix-it that will implement **all** of the methods in one go. I like that one.

----------------------------------------

Issues and fix-it’s are great at helping you fix code thats not quite right. Avoiding getting into those bad states in the first place, is even better. We brought back a concept from Swift Playgrounds, that will let you edit your code without actually typing.

When I hold down the Command key and mouse around, I and can see the structure of my code. When I click, I get a set of options and transformations that are specific for that thing.

    [Command click on the class around line 11]
    
Here I clicked on a class. First off, if I wanted to jump this symbols definition and short circuit the popover, I could do that by holding down Command and Control and then clicking the symbol. If want to modify the class, though, I can choose one of the other options, like add method or add property. 

I can also transform code.
    
I like my code to be self describing with small expressions and well named variables. So I can extract this sub-expression that pulls the moon into it’s own variable.

    [Command click on "Moon" around line 51 and select "Extract Expression…"]
    
And I like my methods to be small and to the point, so I’m going to pull out this big chunk of code thats adding a bunch of moons to Jupiter.

    [Command click on the trailing "}" around line 56 and select "Extract Method…"]
    
It’s really quick and easy to change the shape of my code.
    
Now those were local transformations. Often, I want to change the name of something thats used across my project.

Here I’ve got this method named “position” — it could probably be a little more descriptive, so let me change it’s name. I'll hold down Command and click on it and choose rename.

    [Command-Control click on “position” around line 68 and choose "Rename…"]
    
When I do that, Xcode collapses down that file and pulls in all the other files across my project that will be affected by changing this name. To help keep things focused, I see just the slices of code that will be affected in each of those files. I’m going to pick a new name thats a little more descriptive, how about “orbitalPosition”. When I start typing, I see my changes reflected across all of the call sites. I can change parameter names too. The first parameter name looks good, but lets change the second one to “momentInTime”.

When I’m done, I click "Rename”, and thats it. Really easy.

That was a simple example. Let me change the name of this class which is going to have more impact across my project. The name “TransNeptunianObject” is a mouthful to say the least — lets go with something a little simpler. I’ll Command click on the symbol and select rename, and type in “MinorPlanet”. 

A couple things to notice here. Since this is a class name, it has a backing file that needs to change too. This slice shows us that the file name is being updated.

Theres also a comment here that has the name. Comments are bit tricky, so Xcode err’s on the side of caution and will offer the change, but it won’t rename them unless you specifically say thats what you want. I do want this comment to change, so I’ll click the token to toggle it on.

Theres a couple of uses of the class in this Storyboard — those will be updated for me.

And all the way down at the bottom we can see some uses of this class in Objective-C — those will be updated too.

That all looks good to me, so I’ll click rename, and I’m done. Really simple. Really powerful.

And thats the new source editor and refactoring in Xcode 9.
 
----------------------------------------

defaults write com.apple.dt.Xcode CodeRollMatchThemeTextSize -bool YES
defaults write com.apple.dt.Xcode SourceEditorTransientStructureColor "0.3 0.5 1 0.75"
