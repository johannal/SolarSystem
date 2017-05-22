Thanks Matthew.

Xcode 9 includes a brand new source editor written from the ground up to be super fast. In fact, I think the editor's speed is the first thing you'll notice.

    [scroll down and then up in SolarSystemView.swift]

It's fully layer backed and opts in to responsive scrolling. It lays out only as much text as it needs, so I can grab the scroll thumb in this 8000+ line file and drag it around like there were only 100 lines. And because of that optimized text layout strategy, I can jump instantly to bottom of this file and right back to the top.

In case you can’t read that code, let me just bump up the font size using Command plus — thats one of my favorite new features. Surprisingly handy for a code review, or a even a demo. It’s the little things, right?

    [press Command-plus a few times]
    
Interacting with your code is nicer, but there are also some new issues and fix-its to help you make your code better and write it more quickly. 

Let me show you. I’ll type some code that is using new iOS 11 API.

    [type "demo1"]
    
We've brought the too-new-API issue to Objective-C. Xcode's warning me that my app deploys back to iOS 10, where this is going to crash. By the way, you'll notice that the fix-it's now, they show up on the right, below the issue. I'll accept the fix-it here, which will wrap the call in the new Objective-C **@available** keyword. Catching this kind of problem at compile time is a huge win for your apps quality.
    
My favorite new fix it, though, is for missing protocol methods.

    [navigate to Moon.swift]
    
I'm going to conform to PhysicsBody here, which has a few properties I need to implement.
    
    [type ", PhysicsBody" after "Equatable" on line 11]
    
New in Xcode 9, I get a single fix-it that will implement **all** of the methods in one go. This one is going to save so much typing.

----------------------------------------

The last thing I want to show you is one of the most exciting new things, something we brought back from Swift Playgrounds. Xcode has always known a lot about the structure of your code -- the different constructs, like methods, expressions and if statements. But none of that information has ever really been surfaced in a way you can use it. Until now.

If I hold down the Command key, and mouse around, I Xcode highlights the structure of my code. And when I click, I get a set of options that are specific for that thing.

    [Command click on the class around line 11]
    
For this class here, I can add a method or property. For an if, I can add an else or an else-if.

    [Command click on the if statement around line 58]
    
But I can do more than just add code, I can transform what I've already got. I can simple things, like add an item to an array or dictionary.
    
    [Command click on the trailing "]" around line 48 and select "Add Item…"]
    
Or extract a sub-expression out into it's own variable, so I can provide a more descriptive name about what it is.

    [Command click on "Moon" around line 51 and select "Extract Expression…"]
    
Down here I've got a big chunk of code that adds all 67 of Jupiter's moons, which would probably be better in it's own method, so I can extract that out.

    [Command click on the trailing "}" around line 56 and select "Extract Method…"]
    
It's really quick and easy to change the shape of your code.
    
Now those are all local transformations -- but what happens when we want to rename something that spans files. Let's rename << some method >>. I'll hold down Command and click on it and choose rename.

    [Command-Control click on << ?? >> on line <<??>> and choose "Rename…"]
    
When I do that, Xcode collapses the file I'm in and shows me just the  slices of code that will be affected by this change, specifically in this file and across my entire project. When I start typing a new name, I'll see it reflected in all of those call sites, including this one down here in Objective-C. I can change the parameter name too.

I'll click "Rename" and thats it.

Let me rename one more thing here, just to show you how deep the support goes. I'll rename << ?? >>, which has a file name that corresponds to it, it's used in an IB document, and it also shows up in my Info.plist. Xcode identifies all of those scenarios and offers to make the right changes. Really powerful.

And thats the new source editor and refactoring in Xcode 9.
 
