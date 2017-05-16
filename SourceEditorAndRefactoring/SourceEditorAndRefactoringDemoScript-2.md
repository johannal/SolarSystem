Thanks Matthew.

Xcode 9 includes a new source editor written from the ground up to be super fast. In fact, the editor's speed is the first thing I think you'll notice about Xcode 9.

    [scroll down and then up in README.md]

It's fully layer backed and opts in to responsive scrolling -- super smooth.

Along with the fresh new UI and it's now easier to control the way your code looks. One of my favorite features: a couple of Command-pluses to increase the font size, which is really handny for a code review, or a demo!

    [show Command-plus, then go back to "default", then show choose different theme]
    
Xcode 9 also adds first class support for markdown. We know a lot of developers use markdown for their READMEs or other artifcats in their projects.

This is my project's README here, and you can see that Xcode uses fonts of different sizes and weights. The new text layout engine handles varying fonts really, really well.
 
Now not only will you see complete syntax highlighting, but Xcode a also understands the structure of markdown.

    [click on Basics.md and pop the jump bar]
    
I can see the all of the headings and get an outline of my document. I can also use the structure to navigate. When I hold down the Command key and mouse over this link in the text, Xcode highlights it, and I can click it to jump to it's definition, just like it does in regular source code. I can even click on this link, and do an edit-all-in-scope to change it's name throughout my document.

Of course, you'll probably be spending most of your time in source code, so lets jump over to a source file.

    [navigate to BackgroundView.m]

Issues have a brand new look, along with some improvements to the way you interact with them.

    [type "demo1"]
    
I've got an issue here, I forgot to add the semi-colon. The issue icon shows up on the right, and when I click it, I get a popover with more details, and in this case a fix-in. If you've got multiple fix-its, they'll all show up right here, which makes applying multiple fixes really easy.

There's some new issues and fix-it's in Xcode 9. We've brought the too-new-API issue back to Objective-C. If you're using API that isn't available on all the deployment targets you support, Xcode will warn you.

Here I'm going to use some API that's new in iOS 11, but my app deploys back to iOS 10. This would crash, so it's important that I use it conditionally.

    [type "demo2"]
    
Theres also a new fix-it for missing case statements, which works in both Swift and Objective-C. I'll add a switch statement here, and then I immediately get a fix it offering to add the missing case statements. Save me a little typing.

    [type "demo3"]
    
My favorite new fix it, though, is for missing protocol methods.

    [navigate to Color.swift]
    
I want this Color class to implement Equatable, so I'll conform to that protocol.
    
    [type ", Equatable" after "_ExpressibleByColorLiteral" on line 8]
    
When I do, I get a fix it that offers to implement the missing methods! This one is going to save so much typing.

    [type "demo4" in the method implementation]

The last thing I want to show you is one of the most exciting new things, something we brought back from Swift Playgrounds. Xcode has always known a lot about the structure of your code -- the different constructs, like methods, expressions and if statements. But none of that information has ever really been surfaced in a way you can use it. Until now.

If I hold down the Command and Control keys, and mouse around, you'll see that Xcode is showing me the structure of my code. And when I click, I get a set of options that are specfic for this construct.

    [Command-Control click on the if statement around line 29, select "Add else"]
    
And the menu updates based on the structure of my code, so now when I bring up the menu on the if block I'm only offered "Add else/if", since Xcode knows that I already have an "else".

I can Command-Control click on other things, like this class, and I get different options -- add method or property in this case.

Those are all local transformations, but it's a bit more interesting when I want to make a something like rename, which spans files. I want to rename this method named "darker". I'll hold down Command-Control and click on it, then choose rename.

    [Command-Control click on "darker" on line XX and choose "Rename…"]
    
When I do that, Xcode collapses things down and shows me all the slices of code that will be affected by this name change across my project. When I start typing a new name, I'll see it reflected in all of those call sites, including this one down here in Objective-C. I can change the paraemter name too, but I think what I've got is working.

I'll click "Rename" and thats it.

Lets rename one more thing here -- I want to change the class name. I'll Command-Control "Color" and select "Rename…". In this case, the class name matches the file name, so Xcode's offering to change that for us too. If we scroll down, I can see all the places in my code that will be affected, including this call from Objective-C here -- renaming works great across languages.

I'll type in a new name, lets call it "GraphColor", and click "Rename". That's it! Really fluid, really simple.

And thats the new source editor and refactoring in Xcode 9.
 
