Thanks Matthew.

Xcode 9 includes a brand new source editor written from the ground up to be super fast. In fact, I think the editor's speed is the first thing you'll notice.

    [scroll down and then up in SolarSystemView.swift]

It's fully layer backed and opts in to responsive scrolling. It lays out only as much text as it needs, so I can grab the scroll thumb in this 8000+ line file and drag it around like there were only 100 lines. And because of that optimized text layout strategy, I can jump instantly to bottom of this file and right back to the top.

In case you can’t read that code, let me just bump up the font size using Command plus — thats one of my favorite new features. Surprisingly handy for a code review, or a even a demo. It’s the little things, right?

    [press Command-plus a few times]
    
Interacting with your code is nicer, but there are also some new issues and fix-its to help you make your code better and write it more quickly. 

Let me show you. I’ll type some code that is using new iOS 11 API.

    [type "demo1"]
    
We've brought the too-new-API issue to Objective-C. Xcode's warning me here that my app deploys back to iOS 10, where this is going to crash. There’s a fix-it I'll accept, which will wrap the call in the new Objective-C **@available** keyword. Catching this kind of problem at compile time is a huge win for quality.
    
My favorite new fix it, though, is for missing protocol methods.

    [navigate to Moon.swift]
    
I'm going to conform to PhysicsBody here, which has a few properties I need to implement.
    
    [type ", PhysicsBody" after "Equatable" on line 11]
    
New in Xcode 9, I get a single fix-it that will implement **all** of the methods in one go, which is a real time saver.

----------------------------------------

The last thing I want to show you is something I’m really excited about, something we brought back from Swift Playgrounds. Xcode has always known a lot about the structure of your code -- the classes, methods and expressions. But it’s never been surfaced in a way that you can use for editing.

Now, when I hold down the Command key, and mouse around, I Xcode highlights the structure of my code. And when I click, I get a set of options that are specific for that thing.

    [Command click on the class around line 11]
    
For this class here, I can add a method or property. And I can do more than just additive operations, I can also transform what I've already got.
    
I like my code to be self describing with small expressions and well named variables. So I can extract this sub-expression that pulls the moon into it’s own variable.

    [Command click on "Moon" around line 51 and select "Extract Expression…"]
    
Down here I've got a big chunk of code that adds all 67 of Jupiter's moons. This would probably be better in it's own method, so I can extract that out.

    [Command click on the trailing "}" around line 56 and select "Extract Method…"]
    
It's really quick and easy to change the shape of your code.
    
Now those are all local transformations -- what does it look like to do rename something that spans across files. 

Down here I’ve got this method named position — it could probably be a bit more descriptive. Let change the name. I'll hold down Command and click on it and choose rename.

    [Command-Control click on << ?? >> on line <<??>> and choose "Rename…"]
    
When I do that, Xcode collapses down the file I'm in and shows me just the  slices of code that will be affected by this change, in this file and across my entire project. When I start typing a new name, I see it reflected in all of those call sites. I can change parameter names too. The first parameter name is good, but the second one could be a bit more descriptive.

When I’m done, I click "Rename”, and thats it.

That was a pretty simple example. Let me change the name of this class up here which reaches out into more of my code. The name “SmallPlanet” isn’t technically accurate, it should really be “MinorPlanet”, so lets change the name. I’ll Command click on the symbol and select rename. A couple things to notice here. Since this is a class name, it has a back file that needs it’s name changed too. We can see that the file name will be adjusted for us. 

The name “SmallPlanet” is used in a comment here too. Now comments are tricky, so Xcode err’s on the side of caution and will point these out, but won’t rename them unless you specifically say you want that change. I do want this comment to change, so I’ll click the token to toggle it on.

As I scroll down through the changes, you can see that there are some uses of this class in IB — those will be changed for me.

And all the way down at the bottom we can see some uses of this class in Objective-C — those will be updated too.

That all looks good to me, so I’ll click rename, and I’m done. Really simple. Really powerful.

And thats the new source editor and refactoring in Xcode 9.
 
