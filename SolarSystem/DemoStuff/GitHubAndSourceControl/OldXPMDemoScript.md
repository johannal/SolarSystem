#SOTU Package/GitHub Demo
_WWDC 2017_

## Step-by-step with Radars
- _Random bugs_
	- <rdar://problem/31757497> Should have a context menu and + button command for adding a remote 
	- <rdar://problem/29911644> Branch actions in menu for the new history view and navigator
	- <rdar://problem/29911645> Tag actions for the new history view and navigator
	- <rdar://problem/29911639> Commit actions for the new history view and navigator
	- <rdar://problem/31757622> In the Clone window, default sort should take ownership into account
	- <rdar://problem/31757658> Define some conventions/best practices to recommend to people putting packages on github to aid in searching through the Clone workflow.
	- <rdar://problem/31757966> Adding a package dependency on a git@ URL just hangs in Fetching activity
	- <rdar://???> When an auth error shows up, the fetching activity stays forever
	- <rdar://???> Deleting package ref in worspace does not cancel fecthing activity
	- <rdar://problem/31761469> Account detail for GitHub accounts should have a "Clone..." button to go right to the clone workflow
	- <rdar://problem/31836592> New packages should have a "dependencies: []" stubbed in to make it easier to know how to add dependencies
	- <rdar://problem/31836630> Consider some comments in new package manifest to explain how to proceed
	- <rdar://problem/31816461> Opening a package gives me "is locked" ... even though I'm not trying to edit it
	- <rdar://problem/31914679> CrashTracer: [USER] Xcode at libsystem_kernel.dylib: __pthread_kill + 10 :: NSInternalInconsistencyException at com.apple.dt.DVTFoundation: __DVTFailureHintExceptionPreprocessor_block_invoke + 199
	- <rdar://problem/31936779> Creating a git repo for a new package should not be optional
	- <rdar://problem/31936812> When a blue folder resorts (reloads) we lose selection within it
	- <rdar://problem/31936837> After adding SwiftyJSON to a project, it does not seem to get pre-build/indexed (cannot code complete import SwiftyJSON until after building once)
	- <rdar://problem/31936877> Consider whether clicking a package issue icon in structure navigator should take me to the issue navigator
	- <rdar://problem/31936890> Manifest issues should show up in the source editor as annotations
	- <rdar://problem/31936923> Awkward issue text for missing source folders
	- <rdar://problem/31936990> SCM navigator should have Branches and Tags groups even if there aren't any
	- <rdar://problem/31937004> Creating a new branch does not cuase the new branch to show up immediately in the navigator
	- <rdar://problem/31937038> Should have alternate New Group commands for specifically creating a green/non-green group
	- <rdar://problem/8886899> Autodelete provisional schemes when their targets go away

	- Discuss single convention for Sources/Tests?
	- If we ghost in missing target folders, what about the errors
	- products, dependencies, targets order feels off

#### Set-up
- _Initial set-up_
	- Create a workspace at DemoStartingPoint/Demo.xcworkspace
	- Create a project: DemoApp
		- iOS Single view app, Swift, no CoreData
	- Have a github account configured
		- <rdar://problem/31758582> Want demo feature to allow a GitHub Enterprise account to masquerade as GitHub.com
- _Set-up_
	- Make a copy of DemoStartingPoint, named Demo
	- Open Demo workspace
- _Todo_
	- Settle on 3rd party package (SwiftyJSON?) make sure to fork it and clean it up
	- Find interesting branches or tags or commits to view

#### Use a third-party package
	
- _Github_
	- **Preferences is already open, showing accounts, with GitHub account selected.**
		- <rdar://problem/31937721> The GitHub account detail needs an HI pass
		- <rdar://problem/31761450> Account details for GitHub accounts should show list of organizations I belong to
	- Xcode 9 integrates directly with GitHub and the chances are that if there's an open source package you want to use, tha's where it is.
	- I have already added my GitHub account to Xcode and I can see it in the Accounts pane of Xcode's preferences.
	- I can see here what organizations I belong to on GitHub and I can see that I have an ssh key set up with GitHub.
	- Adding your GitHub acount is easy, just supply your name and password. Xcode will even handle 2 factor authentication for you if your account needs it.
	- Since I have my account all set up, let's jump right into making use of an open source package to make my app better.
	- **Close the preferences window**
- _Add a package dependency_
	- **DemoApp is already open**
	- Adding a new package that my project will use is a little like adding a framework. We'll start in the Project editor in a new tab called "Packages"
	- **Select DemoApp project**
	- **Select project in project editor**
	- **Select Packages tab**
	- To add a new package, just click +.
	- **Click plus button**
		- <rdar://problem/30960652> Package dependency editor adoption of new repository UI
	- I am immediately presented with all my repositories on GitHub. This includes my personal repos, repos from my organizations and any repositories that I have starred. What I want right now is a package that a friend told me about. It's not one of my favorites (yet!), so I will use the search field to look for it.
	- _blocked_
	- **Search github** ("Swift Networking" turns up AlamoFire as #2 hit)
		- (AlamoFire is: https://github.com/Alamofire/Alamofire.git)
		- <rdar://problem/30960546> New repository UI - global repository search by name
	- Oh yeah, I think I remember my friend saying the name was AlamoFire. Here it is, but let me make sure.
	- **Disclose detail area** (if necessary)
		- <rdar://problem/30960488> API to access repository README
	- I can see a bit more detail about this project here, and if that's not enough, I can pull up the README file for the repository.
	- **Show the README**
	- This is definitely what I am looking for. And, I know I'll probably want to find it again for other projects, so I am going to go ahead and star it on GitHub to be sure I'll always see it.
	- **Star the repo**
		- <rdar://problem/30960578> New repository UI - favoriting repos
	- Let's start using it.
	- _unblocked_
	- **Select the repo and click Next**
	- In order to use a package, I need to tell Xcode what version I want. More specifically I want to give Xcode some guidance on choosing an appropriate version. The best way to do this is to keep things as flexible as possible. So usually we want to specify a particular minimum version within a particular major version range and then let the package manager choose to use anything up to the next major version (packages must remain API compatible within a major version.) 
	- **Fill in version info** (Major version, appropriate for package)
	- Now I am ready to add the package dependency to my project. I want you all to watch two things as I do this. First, you'll notice some activity in the activity view at the top of the Xcode window saying that the package manager is resolving the dependency and fecthing the package. Second, when that's done, you'll see the new package appear at the bottom of the project navigator at the left of the Xcode window.
	- **Click Add**
- _Show package_ 
	- What's happened is that Xcode has resolved this new dependency, cloned the repository from GitHub, figured out what version it should use based on the constraints I gave it, and then checked out that version.
	- **Select the package in the navigator**
	- I can now click the package and see it manifest. A package's manifest defines the content of the package. It is like a project file, but for packages, the manifest is written in swift.
	- **Disclose the package sources**
	- This package is now part of my workspace so I can browse it, search for things, and, most importantly, use its products in my own targets.
	- **Tentative: Something that shows how accessible the package content is...**
	- **Tentative: What else might it make sense to demo in terms of package content? ReadMe, maybe?**
- _SCM navigator history browsing_
	- While we're poking around at this package, let me show you another great new feature in Xcode 9. There's a new navgiator that lets me view things from the persepective of source control.
	- **Click SCM navigator**
		- <rdar://problem/31938196> Initial navigaotr state... should some repos be disclosed?
		- <rdar://problem/31938086> Remote package repos have weird hash as part of their name, showing up in SCM nav
	- In the new navigator we can see that there are no two repositories involved with our project. There's the repository for the project itself, and now there's the repository for SwiftyJSON, the package we're using. I can open up SwiftyJSON to see its branches, tags, and remotes.
	- **Disclose the Tags group**
	- **Click on a tag**
	- The navigator gives us quick access to exporing the history of our repositories. If I select a tag, I'll see all the commits that are part of that tag
	- I can easily browse or search the history of any line of development.
	- **Search for a keyword** _(Nested seems to be a posibly interesting one in SwiftyJSON)_
	- These are all the commits with the word <blah> anywhere in them, or I can search for commits by a particular author.
	- **Search for an author** _(Qual is decent in SwiftyJSON)_
	- If I see a commit I am interested in, I can double-click to show the full diffs of the commit.
	- **Double-click a commit**
		- <rdar://problem/31939924> Commit viewer should scroll to first diff in the top file
	- The new commit viewer appears right in the editor area and I can look at all the changes that were part of this commit. When the commit is a merge commit, it shows all the diffs that landed in the current tag via that merge.
	- **Show some diffs**
	- The new SCM navigator, log viewer and commit viewer make it really easy to explore the history of a repository. OK, now let's get back to our project.
	- _TODO: WHat about the inspector?_
- _Depend on product_
	- Now that we have the package, let's use it in our app. To do that we'll add the library product of the package to be part of our application target.
	- **Go back to the project editor**
	- **Select the app target**
	- **Select the General tab**
	- The target editor has a place to add package products that you want a target to depend on. This is similar to setting up a target to depend what another target builds. But in this case we are going to depend on a product that a package builds.
		- <rdar://problem/31550636> Hoist the Package Product Dependencies slice to the General tab of the target editor
	- **Click + in dependencies slice**
		- <rdar://problem/31940542> Outline in add product sheet should be expanded by default
		- <rdar://problem/31940584> Need to show better icon for library products in Add Product workflow
	- **Select SwiftyJSON library**
	- **Add it**
	- Now we can start using the product in our application's code.
	- **Tentative: Go to some (app) source code**
	- **import SwiftyJSON**
	- **Use a code snippet to add some use of the API**
	- When I build my app, the package will be built first and my app will embed the library content.

#### Make a package

- _Create a new package_
	- We've seen how easy it is to use an open source package. Now let's look at how to create one.
	- To get started I'll choose the New Package... command and pick a name.
	- **File -> New -> New Package...**
	- **Name the new package**
	- Now because I want to make sure it's easy to use this package later, I am going to go ahead and create my new package right on GitHib in my persaonl GitHub account.
	- **Show the GitHub choice, turn it on**
		- <rdar://problem/31019822> GitHub on-ramping during project creation
	- That's all there is to it, let's create the package.
	- **Create**
		- <rdar://problem/31036110> When a package is opened for the first time or created , the package node is selected in the navigator, but the Editor is empty
	- Now I have my new package, and I can see the manifest for it.
	- _TODO need to work in editing stuff like_ 
		- Add a dependency to the package (to manifest)
		- Add a source file
		- Drag in a bunch of sources
		- Add a module directory
			- <rdar://problem/31311947> After creating a new file in a Blue Folder, the the view refreshes and the name editing is cancelled | D | ?d
		- Reparent some sources into Utilities
	- _TODO show tests_
		- *maybe do this in first section*
		- <rdar://problem/31947280> Tests from remote packahges not showing up in test navigator
		- Show test nav
		- Maybe don't run tests, but show run destinations
	- _TODO Show SCM navigator (editing)_
		- Commit my changes
		- Tag
		- Push to github
	- _Question: Should we end by committing/pushing and tagging, discussing the tagging and how that works with package versioning?_


###Fixed Bugs
- <rdar://problem/31757488> We should show the Remotes folder under a git repo even if there are no remotes
- <rdar://problem/31758648> The package structure file system watcher is WAY too eager to trigger package graph updating
- <rdar://problem/31836683> Need to deal with header comment in new file in package


## Patter (stale)
I want to show how easy it is to start using the package manager and why I think you'll all want to. I have an iOS application that we've been working on for a while, and I have a few things that need to be done. 

### Use a package
The first thing I need to do is add in the ability to _blah_ (parse JSON, use IBM cloud service, whatever...)

There's a Swift package that Ken told me will really help me solve this problem. So let's use it.

I just need to go to the project editor and add the package as a dependency for my project. Notice that Xcode 9 has a new tab in the project editor called "Packages". In order to use a package, I need to establish a dependency. In the packages tab I will click the plus button.

Notice that I am getting a list of a bunch of repositories. Xcode 9 has added direct integration with GitHub. I have already added my GitHub account to Xcode's preferences (_show prefs?_), so what I am seeing here is all my own repositories, repos from organizations I am a member of, and any repos that I have starred on GitHub.

I haven't used this package before, but Ken said that is is called _blah_, so let me type that in here to search GitHub. I see it appears right there and since it's pretty popular with everyone else on GitHub it's right near the top of the results.

I bet I'll be using this package a lot, so I am going to go ahead and star it on GitHub so it will be easy to find again later.

I'll select this package and the next thing Xcode asks is what my version requirements are. I can set specific version constraints to match whatever requirements I may have. The most common way to specify a version is to just specify a major version. That way I'll be able to get the latest bug fixes or additive changes to the package but won't automatically get bumped to a version that might be source-incompatible.

When I click Add, my project will now depend on this package. This is kind of like adding a project reference so that you can depend on targets from another project, but in this case, what you're depending on is expected to be remote. So when I do this, watch for two things... The first thing you'll see is some activity in the toolbar as Xcode realizes there's new package dependency and starts automatically fetching the repository and resolving the desired version. Next, well see the new package pop in to the Project navigator and, when the clone is complete we'll be able to browse its source.

Great. I am now ready to start using this package. But wait, it seems like a few other things appeared in my project navigator... why is that? Well, it turns out package can themselves depend on other packages and _blah_ has some other dependencies. If I open up the _blah_ package's manifest you can see where it declares them. Packages are defined via a manifest that is written in Swift, so the syntax here may be familiar to a lot of you.

Now that I have the package, I can start using it. In the Target editor, I can add the _blah_ library as a dependency of my application target. This means that before building my app, the library will be built, my application will link against the library, and the library will be embedded in my application.

_Edit some code to use it?_

#### Functionality needed
- Projects use packages
	- Full HI for project editor and target editor
	- Add package workflow
- Github integration
	- GitHub account
	- New checkout workflow
	- Starring
- Project navigator showing remote packages

### Make a package

This is great, there's _number_ packages out there on GitHub to do all kinds of interesting things, and I am sure that that number will be growing soon now that it's becoming so easy to use them in your applications.

The next thing on my todo list is to let my team finally start sharing some code between our apps  for iOS, macOS, tvOS and watchOS. I gotta say, this has been on the todo list for a while. But I think I now have the right tool for the job, so let's dive in. I want to start with a bunch of infrastructure we've developed _to talk to some common services that our apps all use?_.

I need a place to put this shared code. Any suggestions? Yeah, let's try a package!

I'll start by just creating a new package. This is just like creating a project, in fact, the package template appears right alongside the project templates. I'll create a new library package. I just need to give it a name. And I'll select my GitHub Enterprise account here as well.

Now I have my package.

But let's recap what just happened. I made a package, that lives in its own new repository, and I have pushed that repo up to my team's GitHub Enterprise server so that it's available to us all. (_show GitHub Enterprise web page with repo appearing?_)

I am ready to start moving our awesome share-able code in to the package. I can start creating sources as usual in Xcode, or drag them in from somewhere else. I have a bunch of source ready to go, so I'll just drag it in.

Can I tell you another cool thing about packages? To add code to my package, all I have to do is add the files. I just put source files in the Sources directory and tests in the Tests directory. I can drag them in to Xcode, copy them in Finder, or even use Terminal for that matter. The package manager's build system is based on a convention based file layout, so there's no having to make sure you also add things to targets.

#### Functionality needed
- Library Package template
- GitHub new project on-ramp
- Structure editing support for dragging new stuff into blue folders

### Use my package

Let's flash forward a bit. My team and I have been fleshing out this package and others. It's ready to start using in a couple of the apps that I work on.

I have a workspace here that has a few of our apps. Notice that the package I created earlier is already showing up in the project navigator among others. If I select my application project I see that package in the Packages tab. Notice that its "version" constraint is actually set to a branch name. Since my team is pretty close knit and we both develop and use this package, we find it better to just track the master branch instead of formally versioning.

As I look at the different targets, you'll see that my iOS app and its WatchKit extension and my macOS app and my tvOS app all have the same package product listed in their Dependencies.

Remember when we started on all this I said that I wanted to start sharing code between our apps. Well, packages are cross-platform by default. Unless you say otherwise, a package can be used with any of our platforms. You don't need to define separate products for each platform, Xcode knows how to build the single product appropriately for each platform.

When a project uses a package product in targets for different platforms, it just builds that product once for each platform it needs. I'll select a scheme I have that builds all of my applications and build.

Xcode will build the _blah_ library 4 times, once for each platform and use the right one for each app. (_is there a good way to show this? ... showing the build log does not seem like a good way..._)

#### Functionality needed
- Cross-platform build support for packages
- Branch based development

