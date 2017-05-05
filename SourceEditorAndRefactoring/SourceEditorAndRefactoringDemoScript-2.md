Thanks Matthew.

Xcode 9 includes a new source editor written from the ground up to be super fast. In fact, the editor's speed is the first thing I think you'll notice about Xcode 9.

    [scroll down and then up in ViewController.swift]

It's fully layer backed and opts in to responsive scrolling -- super smooth.

The UI has a fresh new look, deferring a little more to your code.  It's also easier for to control the way your code looks. You can use Command-plus and minus just like you'd expect, and you can change the theme now, right from the Editor menu.

    [show Command-plus, then go back to "default", then show choose different theme]

This theme here is a little more fun. It uses fonts of different sizes and weights, which works really, really well with the new text layout engine.

Let's be boring again and switch back to the default theme.

    [switch back to Default theme]
 
Built on top of the great support for varying fonts, is full markdown editing. Not only will you see complete syntax highlighting, but Xcode a also understands the structure of markdown.

    [click on Basics.md and pop the jump bar]
    
I can see the all of the headings and get an outline of my document. It doesn't end there though. When I hold down the Command key and mouse over this link in the text, Xcode highlights it, and I can click it to jump to it's definition, just like it does in regular source code. I can even click on this link, and do an edit-all-in-scope to change it's name throughout my document.

Of course, you'll probably be spending most of your time in source code, so lets jump over to a source file.

    [navigate to BackgroundView.m]

First off, there are a some new issues and fix-it's in Xcode 9. We've brought the too-new-API issue to Objective-C. In Swift, you've been able to see if you're using API that isn't available on all the deployment targets you support. Now you'll get the same issue in Objective-C code.

Here I'm going to use some API that's new in iOS 11, but my app deploys back to iOS 10. This would crash, so it's important that I use it conditionally.

    [type "demo1"]
    
Theres also a new fix-it for missing case statements, which works in both Swift and Objective-C. I'll add a switch statement here, and then I immediately get a fix it offering to add the missing case statements. Save me a little typing.

    [type "demo2"]
    
My favorite new fix it, though, is for missing protocol methods.

    [navigate to Color.swift]
    
I want this Color class to implement Equatable, so I'll conform to that protocol.
    
    [type ", Equatable" after "_ExpressibleByColorLiteral" on line 8]
    
When I do, I get a fix it that offers to implement the missing methods! This one is going to save so much typing.

    [type "demo3" in the method implementation]

The last thing I want to show you is one of the most exciting new things. Xcode has always known a lot about the structure of your code -- the different constructs, like methods, expressions and if statements. But none of that information has ever really been surfaced in a way you can use it. Until now.

If I hold down the Command and Control keys, and mouse around, you'll see that Xcode is showing me the structure of my code. And when I click, I get a set of options that are specfic for this construct.

    [Command-Control click on the if statement around line 29, select "Add else"]
    
If do the same thing again, on the same if, you'll see that now I'm only offer "Add else/if" as an option, since Xcode knows that I already have an "else".

I can Command-Control click on other things, like this class, and I get different options -- add method or property in this case.

Those are all local transformations, but it's a bit more interesting when I want to make a something like rename, which spans files. I want to rename this method named "darker". I'll hold down Command-Control and click on it, then choose rename.

    [Command-Control click on "darker" on line XX and choose "Rename…"]
    
When I do that, Xcode collapses things down and shows me all the slices of code that will be affected by this name change across my project. When I start typing a new name, I'll see it reflected in all of those call sites, including this one down here in Objective-C. I can change the paraemter name too, but I think what I've got is working.

I'll click "Rename" and thats it.

Lets rename one more thing here -- I want to change the class name. I'll Command-Control "Color" and select "Rename…". In this case, the class name matches the file name, so Xcode's offering to change that for us too. If we scroll down, I can see all the places in my code that will be affected, including this call from Objective-C here -- renaming works great across languages.

I'll type in a new name, lets call it "GraphColor", and click "Rename". That's it! Really fluid, really simple.

And thats the new source editor and refactoring in Xcode 9.
 
