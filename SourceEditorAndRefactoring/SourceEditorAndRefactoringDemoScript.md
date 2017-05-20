Thanks Matthew.

Xcode 9 includes a brand new source editor written from the ground up to be super fast. In fact, the editor's speed is the first thing I think you'll notice.

    [scroll down and then up in SolarSystemView.swift]

It's fully layer backed and opts in to responsive scrolling. Momentum scrolling -- super smooth. I can grab the scroll thumb and drag that up and down in this 8000+ line file, and it tracks my mouse like it's stuck to it. I can jump instantly to any line, including the very bottom of the file.

And typing responsiveness, well thats better too.

One of my favorite features: a couple of Command-pluses to increase the font size, which is really handy for a code review, or a demo!

    [press Command-plus a few times]
    
In addition to the speed boost, Xcode 9 adds some new issues and fix-its. I'll type some code that is using new iOS 11 API.

    [type "demo1"]
    
We've brought the too-new-API issue to Objective-C. Xcode's warning me that I deploy back to iOS 10, where this will crash. I'll accept the fix-it, which will wrap the call using the new Objective-C @available keyword. Catching this kind of problem in at compile time is a huge win.
    
My favorite new fix it, though, is for missing protocol methods.

    [navigate to Moon.swift]
    
I'm going to conform to PhysicsBody here, which has a few properties I need to implement.
    
    [type ", PhysicsBody" after "Equatable" on line 11]
    
New in Xcode 9, I get a single fix-it that will implement **all** of the methods in one go. This one is going to save so much typing.

----------------------------------------

The last thing I want to show you is one of the most exciting new things, something we brought back from Swift Playgrounds. Xcode has always known a lot about the structure of your code -- the different constructs, like methods, expressions and if statements. But none of that information has ever really been surfaced in a way you can use it. Until now.

If I hold down the Command key, and mouse around, I Xcode highlights the structure of my code. And when I click, I get a set of options that are specific for that thing.

    [Command click on the if statement around line 41]
    
Command-clicking on this class, gives me different options, like adding a method or property.

    [Command click on the class around line 11]
    
I can do more than just add code, though, I can transform code too. So here where I'm adding Earth's moon, I'll Command-click on the Moon class, and choose "Extract Expression…" and create a local variable to use.

    [Command click on "Moon" around line 31 and select "Extract Expression…"]
    
I can add items to an array.

    [Command click on the trailing "]" around line 59 and select "Add Item…"]
    
Looks like I was missing "venus" here.

I can even extract out a chunk of code into it's own method.

    [Command click on the trailing "}" around line 56 and select "Extract Method…"]

Those are all local transformations -- it's even more interesting when I want to do something that spans files, like a rename. Let's rename << some method >>. I'll hold down Command and click on it, then choose rename.

    [Command-Control click on << ?? >> on line <<??>> and choose "Rename…"]
    
When I do that, Xcode collapses things down and shows me all the slices of code that will be affected by this name change across my entire project. When I start typing a new name, I'll see it reflected in all of those call sites, including this one down here in Objective-C. I can change the parameter name too.

I'll click "Rename" and thats it.

Let me rename one more thing here, just to show you how deep the support goes. I'll rename << ?? >>, which has a file name that corresponds to it, it's used in an IB document, and it also shows up in my Info.plist. Xcode identifies all of those scenarios and offers to make the right changes. Really powerful.

And thats the new source editor and refactoring in Xcode 9.
 
