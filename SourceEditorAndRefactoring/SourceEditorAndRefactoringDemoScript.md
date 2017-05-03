## Intro

As developers, we spend almost all of our day writing code, which means the source editor needs to be awesome.

In Xcode 9, we've re-written the editor from the ground up, and we did that with performance and stability as one of our main focuses.

## Editor Presentation

### Scrolling and Editing Performance

And you'll see that right away -- scrolling, is super smooth.

    [scroll down in ChartView.swift]

The new source editor is fully layer backed, and is opted in to responsive scrolling.

### Theme Adjustment

In addition to a cleaner and fresher look, it's easier to control how you want the editor look, too. You can increase or decrease the font size with Command-plus and Command-minus.

    [press Command-plus a couple of times]

I find this super useful when I sit down with someone to do a code review. I can also change the entire theme really easily now, too.

    [go to Editor > Theme menu and choose "Default (tweaked)"]

In this variant of the default theme that I tweaked, I've made the keywords semi-bold and  the comments kinda tiny, which I think looks really nice. To those of you who may have tried using fonts of varying size and weight, I want point out just how well this works now.

## Editor Performance

So I mentioned that performance is better -- let me show you a little bit of a worst case scenario to demonstrate that. I've got a data file here -- just a text file with some sample data -- and it's about 20MB, which is a lot of text.

    [navigate to GraphSampleData.txt]

Let me make that a little smaller so it doesn't wrap:

    [press Command-minus twice]

You'll see that I can scroll through it no problem:

    [momentum scroll, then grab the scroll thumb and drag]

I can grab the scroll thumb and drag it around -- super responsive. I can also instantly jump to the bottom, and then right back to the top.

    [press Command-Down and then Command-Up]

The performance is pretty great.

## Issues

Lets go back over to ViewController.swift -- I want to show you some new issues and fix-its added in Xcode 9.

    [navigate to ViewController.swift, toggle-on issues]

### Too New API Issue

Xcode will now tell you when you're using API that doesn't exist on some of your deployment targets. Here, I'm using the new iOS 11 named UIColors, but my app deploys back to iOS 10. This would have ended up crashing before, now Xcode will tell you abou the issue right away. And of course, there's a nice fix-it to go along with the issue:

    [tap the issue icon and choose the fix-it that wraps the code in #available]

I'll wrap this code in #available so that it only runs when we're on iOS 11.

### Missing Case Statements Issue

Here's a new fix-it for missing case stements in a switch:

    [tap the issue icon and choose Fix]

That'll save you some typing.

### Unimplemented Protocol Methods

And here's my favorite new fix-it…

    [navigate to ViewControllerGraphTouchDelegate.swift]

In this file I've conformed to a protcol, but I haven't actually implemented the methods:

    [tap the issue icon and choose Fix]

This new fix-it will add the method stubs for me -- super useful.

## Markdown Editor

So I mentioned that the new source editor can deal with multiple font sizes and weights really well. We wanted to build on that, so we've added first class support for markdown files.

    [navigate to Basics.md]

Xcode 9 has full support for not only rendering markdown files, but navigating around in them.

    [pop the jump bar]

I can see all the headers in my file, and navigate to them just like I would in a source file. If I hold down the Command key, I can see symbols whose definition I can jump to.

    [press the Command key and mouse over "s" on line 8]

Heres a link thats defined below, I'll jump to that. You can see that Xcode really understands the structure of markdown. In fact, I can even do an edit-all-in-scope to change the name of this link!

    [press Command-Shift-E key with the cursor in front of "s" on line 21, and type "yntax" to spell "syntax"]

## Structured Editing

I want to show you something we brought back from Swift Playgrounds. Xcode has always known a lot about the structure of your code -- the different constructs, like methods and if statements. But none of that information has really been surfaced in a way you can use it. Until now.

    [navigate to Color.swift]

If I hold down the Command and Control keys, and mouse around, you'll see that Xcode is showing me my codes structure. And when I click, you see that I get a set of options that are specifically relavent for this construct.

    [click on the "if" on line 28]

I'll add an "else" block. On my class, I could add a method or property.

    [bring the action popover up on the "Color" class on line 8]

Rather than just interating with raw text, you can now operate at a higher level.

I can also use this new structure menu to initiate refactorings. Down here, I've got a value that's being converted to a CGFloat.

    [Command-Control click on "CGFloat" on line 55]

If I want to pull that out into a local variable to do some other calculation with it, I can do that by selecting "Extract Expression", and I can rename it to something more interesting.

    [double click "Extract Expression…" and change the name]

That brings us to another really important feature in Xcode 9 -- renaming. You've always been able to edit all the variables inside a particular local scope. Like here, I can change this private variables name.

    [put cursor after "ui" on line 10 and initiate a rename; type "Kit"]

But what you haven't been able to do, until now, is rename a symbol across your entire project. So if I wanted to change the method "darker" down here, I can bring up the structure menu, and select "Rename…".

    [scroll down to line 59 and Command-Control click "darker" and select "Rename…"]

I can see all the files across my project that use the method. I'll change this to "makeDarker" and press enter to accept the rename.

    [type "makeD" and delete the lower case "d"; press enter]

I can rename the class, and Xcode will offer to change the file name, comments and even references in XIB files.


