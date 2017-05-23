## SOTU GitHub/SCM Demo
_WWDC 2017_

###TODO
- Investigate no ssh key in demo account
- Get demo project checked out
- Find a repo to use for explore demo
	- Identify filter terms to use
	- Identify commit to show detail on
- Figure out what change I want to make
- Figure out plan for no internet
	- Try this and make sure error message when it first occurs is not embrarrassing
	- Slides for GitHub accounts, Clone..., and Create on GitHub
	- Have the Explore project cloned locally somewhere already
- Should we try to cache the ReadMe?

### Account Setup
- GitHub account:
	- wwdc2017, mfdemo2017
	- Org: Stultus Enterprises
		- MuchRemainsToBeDone
		- RushIn
		- ShameOnMe
	- Starred:
		- swift
		- swift-package-manager
		- swift-corelibs-foundation
- User account:
	- Defaults
		- defaults write com.apple.dt.Xcode IDESourceControlDisableHistoryTooltips YES
		- defaults write com.apple.dt.Xcode IDESourceControlUIPresentationMode YES
	- Get a clone of the demo project, remove its remote

### Pre-Demo Setup
- Make sure no github account configured
- Have my passphrase already in Xcode's keychain
- Make sure disclosure state and log viewer filter is good in explore project (XCTest)
- Make a new copy of demo project

### Github Accounts
- I'm excited to show you some of the great new ways to work with source control in Xcode, and especially how Xcode can work with Github.
- I'll start by setting up my Github account in the Account prefs
- **Choose Preferences, Accounts**
- **Click plus button**
- Xcode has support for both github.com and github enterprise.
- **Choose Github**
- I'll enter my name and password
- **Enter wwdc2017, mfdemo2017**
- Xcode also fully supports Github's 2 factor authentication
- ANd now, my account is all set up

### Clone...
- So, let's go get a repository
- **Close Prefs**
- **Cmd-Shift-1**
- **Welcome window: Clone...**
- Xcode has an all new clone workflow that makes getting content from Github easy
- When I bring it up I see all my repositories. My personal repositories, the ones from my organizations and any that I have marked with a star
- At the bottom of the window I see some details about the selected repository... the project's description, its language, and the number of stars and forks
- For even more information I can view the repository's README
- **Click README**
- **Close it**
- Using the search field I can search for other repos on github
- **Type "swift unit test" in search**
- If I find something I like I can clone it directly or I can star it
- **Star swift-corelibs-xctest**
- **Cancel search**
- Now that it's starred I see it in my main list
- **Select swift-corelibs-xctest**
- **Clone...**
- **Choose save location**

### Explore
- Once the clone completes, Xcode opens the project
- **Go to Source Control navigator**
- Xcode 9 has a new navigator that is devoted to source control
- It shows any repositories that are part of my workspace
- Inside each repository I can see all its branches, tags and remotes
- The master branch is the currently checked out branch
- **Select current branch**
- Selecting it shows its complete history
- There's a lot to see here
- We pull avatars from Github for the authors of commits
- There are annotations to show if a commit is tagged or the head of a branch
- **Point out branch and tag annotations**
- Projects can have a lot of history, so filtering can be important
- I can filter commits based on author or commit message content
- **Type ???, select author filter**
- Let's see just commits that ??? made
- **Type ??? and hit enter**
- I want one related to ???
- Once I find a commit, the inspector shows even more detail
- **Open inspector**
- I can see all the branches that this commit is on
- And all the files that were changed by this commit
- **Close inspector**
- Finally, double-clicking a commit takes me to the new commit viewer, showing me all the source changes
- **Double-click the first commit**
- **Show a file or two**
- Xcode 9 makes it easy to dig through history and really get down to the detailed changes

### Creating branches
- Xcode 9 can also help you manage source control while you're making changes
- I have a project that I want to make some changes to before I share it with the world
- **Close the explore project**
- I'll open it now
- **Cmd-Shift-1**
- **Welcome window: Open second demo project**
- I want to make my changes on a branch
- **Go to Source Control navigator**
- I'll make a new branch from our current branch, master
- **Select master**
- **Use context menu to make a branch**
- Now we are checked out to our new branch and we can start making changes

### Structure editing
- **Go to Project navigator**
- In my projects I like to keep group structure and file structure the same
- Xcode 9 makes this easy
- When I'm working in a project where these structures are the same Xcode will automatically keep them the same
- **Select a couple files**
- Making a new group makes a new folder
- **Context Menu->New Group from Selection**
- ...and, the files that I grouped are moved into that folder
- **Rename group**
- When I rename the group, it renames the folder as well
- And, when I move files between groups, they are moved to the new group's folder
- **Move some files from one group to another**
- Best of all, as I am doing all of this these changes are being registered with source control.
- **Source Control->Commit...**
- When I commit, I can see that Xcode knows about all the changes I've been making in the file system as well as in the project
- **Type a comment and commit**

### Working with Branches and Tags
- Now I am ready to land my branch
- **Go to Source Control navigator**
- I just need to merge my working branch back to master
- **Select master branch**
- **Use context menu Merge from working branch into master**
- And finally I will create a new tag
- **Use context menu to choose New Tag...**

### Create on github
- Now I am ready to share this work. But this project isn't on Github yet
- Let's put it there
- **Select repo**
- **Use gear menu to create a new github project and push**
- My project is now hosted on Github and I can start sharing it
- **Open remotes group**
- **Right click origin and choose Show in GitHub**
- Here's my project on github.com, ready for the world

### Conclusion
- Xcode 9 has some great new source control features to help you understand your project's history, implement new features, and to use GitHub to collaborate with all the other developers out there.
- I hope you'll give it a try and let us know what you think!
- Thank you.


### Random Radars

##### Unscreened
- <rdar://problem/31936812> When a blue folder resorts (reloads) we lose selection within it

##### Demo Blocker
- <rdar://problem/32111289> Presentation mode dwrite for bigger fonts in the history viewer
- <rdar://problem/30620743> After renaming a file, UI reverts, then corrects (and when creating a new group, the new group's name is not selected for editing)

##### Beta 1
- <rdar://problem/32034809> CrashTracer: [USER] Xcode at com.apple.dt.IDE.IDESourceControlUI: _T018IDESourceControlUI20CommitEditorDocumentC11displayNameSQySSGfgTo + 207
- <rdar://problem/30291887> New commit view could be more discoverable: add a button to go from the history view to the commit details view

##### Punted, may need to bring back?
- <rdar://problem/32017088> I am getting 'Always allow' dialog when adding a github account when Xcode already has my SSH passphrase in its keychain (from an earlier account addition)

##### Post WWDC
- <rdar://problem/31761450> Account details for GitHub accounts should show list of organizations I belong to
- <rdar://problem/32157549> Unstarring a repo does not remove it from my list
- <rdar://problem/31939924> Commit viewer should scroll to first diff in the top file
- <rdar://problem/32039243> Links in the repo window detail view should get the finger cursor
- <rdar://problem/32039300> Commit summary at the bottom of the commit viewer doesn't show the same merge icon in the hash as the log viewer
- <rdar://problem/32156411> In the GitHub 2FA token field, paste should work
- <rdar://problem/32157658> When showing a renamed file in commit viewer, there should be some indication in the detail area of what the old and new locations are
- <rdar://problem/32157760> No files placeholder should be No Files (capital F) in the commit sheet navigator
- <rdar://problem/32157788> Merge from, into menu items are confusing

##### XPM
- <rdar://problem/30960652> Package dependency editor adoption of new repository UI
- <rdar://problem/31757658> Define some conventions/best practices to recommend to people putting packages on github to aid in searching through the Clone workflow.

##### Post Tioga
- <rdar://problem/30310230> Opening history editor from a working copy node doesn't display commit details in the inspector
- <rdar://problem/32039182> Should we have an indication of current branch without having to twist open Branches?

### Fixed bugs
- <rdar://problem/31936990> SCM navigator should have Branches and Tags groups even if there aren't any
- <rdar://problem/31757488> We should show the Remotes folder under a git repo even if there are no remotes
- <rdar://problem/30960546> New repository UI - global repository search by name
- <rdar://problem/29911644> Branch actions in menu for the new history view and navigator
- <rdar://problem/29911645> Tag actions for the new history view and navigator
- <rdar://problem/29911639> Commit actions for the new history view and navigator
- <rdar://problem/30960488> API to access repository README
- <rdar://problem/30960578> New repository UI - favoriting repos
- <rdar://problem/31757497> Should have a context menu and + button command for adding a remote
- <rdar://problem/31761469> Account detail for GitHub accounts should have a "Clone..." button to go right to the clone workflow
- <rdar://problem/31937004> Creating a new branch does not cuase the new branch to show up immediately in the navigator
- <rdar://problem/31937721> The GitHub account detail needs an HI pass
- <rdar://problem/31938196> Initial navigaotr state... should some repos be disclosed?
- <rdar://problem/32017884> Typing a new search string in Clone window while a search is still active seems not to search again
- <rdar://problem/32039204> Focus should be in search field when clone window comes up
- <rdar://problem/32039210> When the window first comes up, the first repo in the list should be selected
- <rdar://problem/32050969> Clone window: The list of repos and the info panel should have the same margin
- <rdar://problem/32050966> Clone window: Name (font size) of repository in detail view is too large
- <rdar://problem/32051106> The welcome window needs to say Clone… not Check Out…
- <rdar://problem/32051198> Need a user default to turn off huge tooltips for commit messages in history view
- <rdar://problem/28873684> SCM: Remote icon
- <rdar://problem/30834362> GitHub avatar API and caching
- <rdar://problem/30960716> SCM history adoption of avatar API
- <rdar://problem/31019822> GitHub on-ramping during project creation
- <rdar://problem/30698325> Creating groups is automatically creating folders on the disk
- <rdar://problem/31937038> Should have alternate New Group commands for specifically creating a green/non-green group
- <rdar://problem/32015433> New Clone... window shows up in a werid screen position. It should come up centered
- <rdar://problem/32015457> Clone window is non-modal but the menu item to show it is disabled if it is visible but not ordered front
- <rdar://problem/32039272> Context menu for log viewer should have an 'email author' item
- <rdar://problem/32049321> Commit sheet/commit viewer should show renamed files as renamed instead of deleted/added
- <rdar://problem/32051476> Look at presentation of the auto-complete popup tokens in the SCM editor
- <rdar://problem/32121294> Tweak the table headers in the GitHub repository view
- <rdar://problem/32121361> SCM: Polish the presentation of the table group rows in the repositories window
- <rdar://problem/32156339> CrashTracer: [USER] Xcode at com.apple.dt.DVTFoundation: ___DVTAsyncPerformBlockOnMainRunLoop_block_invoke + 1232 :: NSInvalidArgumentException at com.apple.dt.DVTFoundation: __DVTFailureHintExceptionPreprocessor_block_invoke + 199
- <rdar://problem/32156451> HI polish for the GitHub README sheet
- <rdar://problem/32156674> Tweak repositories window selection / keyboard behavior
- <rdar://problem/32156969> The repositories window needs to honor my GitHub clone preference
- <rdar://problem/32157156> Repositories window should update live when GitHub accounts change
- <rdar://problem/32157201> Search field has the wrong placeholder string
- <rdar://problem/32157583> Detail view still shows detail for last selected item when a search starts
- <rdar://problem/32157722> Commit sheet flashes No files in navigator briefly after commit finishes but before sheet rolls up
- <rdar://problem/32158071> When a repository is not starred, we should show it as an empty star and add the (+) on rollover
- <rdar://problem/32039214> Up and down arrow should move selection in the repo list up and down when focus is in the search field
- <rdar://problem/32050962> Clone Window: Remove the “V" button in the footer that toggles the detail view
- <rdar://problem/32050964> Clone window: Add a “Done" button to the footer of the window next to "Clone" button
- <rdar://problem/32051476> Look at presentation of the auto-complete popup tokens in the SCM editor
- <rdar://problem/32156368> Date formatter for repositories window last modified column should be "Today, Time" and "Yesterday, Time"
- <rdar://problem/32157077> Revise the sorting rules for the unsearched window state
- <rdar://problem/32157114> The default repositories view shows me duplicates
