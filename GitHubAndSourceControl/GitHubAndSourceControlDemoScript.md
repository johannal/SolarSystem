# SOTU GitHub/SCM Demo
_WWDC 2017_


### Random Radars
- <rdar://problem/31757622> In the Clone window, default sort should take ownership into account
- <rdar://problem/31757658> Define some conventions/best practices to recommend to people putting packages on github to aid in searching through the Clone workflow.
- <rdar://problem/31936812> When a blue folder resorts (reloads) we lose selection within it
- <rdar://problem/31311947> After creating a new file in a Blue Folder, the the view refreshes and the name editing is cancelled
- <rdar://problem/31937038> Should have alternate New Group commands for specifically creating a green/non-green group
- <rdar://problem/32015457> Clone window is non-modal but the menu item to show it is disabled if it is visible but not ordered front
- <rdar://problem/32015433> New Clone... window shows up in a werid screen position. It should come up centered
- <rdar://problem/30960652> Package dependency editor adoption of new repository UI
- <rdar://problem/31019822> GitHub on-ramping during project creation
- <rdar://problem/32017088> I am getting 'Always allow' dialog when adding a github account when Xcode already has my SSH passphrase in its keychain (from an earlier account addition)
- <rdar://problem/32039214> Up and down arrow should move selection in the repo list up and down when focus is in the search field
- <rdar://problem/32039240> Sorting by repo name should use 'sort like Finder' style sorting
- <rdar://problem/32039243> Links in the repo window detail view should get the finger cursor
- <rdar://problem/32039272> Context menu for log viewer should have an 'email author' item
- <rdar://problem/30834362> GitHub avatar API and caching
- <rdar://problem/30960716> SCM history adoption of avatar API
- <rdar://problem/32039300> Commit summary at the bottom of the commit viewer doesn't show the same merge icon in the hash as the log viewer
- <rdar://problem/32049321> Commit sheet/commit viewer should show renamed files as renamed instead of deleted/added
- <rdar://problem/32157658> When showing a renamed file in commit viewer, there should be some indication in the detail area of what the old and new locations are
- <rdar://problem/32034809> CrashTracer: [USER] Xcode at com.apple.dt.IDE.IDESourceControlUI: _T018IDESourceControlUI20CommitEditorDocumentC11displayNameSQySSGfgTo + 207
- <rdar://problem/31939924> Commit viewer should scroll to first diff in the top file
- <rdar://problem/32051476> Look at presentation of the auto-complete popup tokens in the SCM editor
- <rdar://problem/32057225> After adding account through prefs, the clone window did not notice
- <rdar://problem/28873684> SCM: Remote icon
- <rdar://problem/32050962> Clone Window: Remove the “V" button in the footer that toggles the detail view
- <rdar://problem/32050964> Clone window: Add a “Done" button to the footer of the window next to "Clone" button
- <rdar://problem/30310230> Opening history editor from a working copy node doesn't display commit details in the inspector
- <rdar://problem/32111289> Presentation mode dwrite for bigger fonts in the history viewer
- <rdar://problem/32156339> CrashTracer: [USER] Xcode at com.apple.dt.DVTFoundation: ___DVTAsyncPerformBlockOnMainRunLoop_block_invoke + 1232 :: NSInvalidArgumentException at com.apple.dt.DVTFoundation: __DVTFailureHintExceptionPreprocessor_block_invoke + 199
- <rdar://problem/32157429> The new Clone... button is sandwiched in the middle of the detail view
- <rdar://problem/32157476> Should have a default (or a modifier I can hold) to make the Accounts window Clone... button dismiss the accounts window
- <rdar://problem/32157549> Unstarring a repo does not remove it from my list
- <rdar://problem/32157583> Detail view still shows detail for last selected item when a search starts
- <rdar://problem/32157722> Commit sheet flashes No files in navigator briefly after commit finishes but before sheet rolls up
- <rdar://problem/32157760> No files placeholder should be No Files (capital F) in the commit sheet navigator
- <rdar://problem/32157788> Merge from, into menu items are confusing
- <rdar://problem/32121361> SCM: Polish the presentation of the table group rows in the repositories window
- <rdar://problem/32156368> Date formatter for repositories window last modified column should be "Today, Time" and "Yesterday, Time"
- <rdar://problem/32156411> In the GitHub 2FA token field, paste should work
- <rdar://problem/32156451> HI polish for the GitHub README sheet
- <rdar://problem/32156674> Tweak repositories window selection / keyboard behavior
- <rdar://problem/32156969> The repositories window needs to honor my GitHub clone preference
- <rdar://problem/32157077> Revise the sorting rules for the unsearched window state
- <rdar://problem/32157114> The default repositories view shows me duplicates
- <rdar://problem/32157156> Repositories window should update live when GitHub accounts change
- <rdar://problem/32157201> Search field has the wrong placeholder string
- <rdar://problem/32121294> Tweak the table headers in the GitHub repository view
- <rdar://problem/32158071> When a repository is not starred, we should show it as an empty star and add the (+) on rollover
- <rdar://problem/30291887> New commit view could be more discoverable: add a button to go from the history view to the commit details view

##### Post WWDC
- <rdar://problem/32039182> Should we have an indication of current branch without having to twist open Branches?
- <rdar://problem/31761450> Account details for GitHub accounts should show list of organizations I belong to


### Setup
- Defaults
	- defaults write com.apple.dt.Xcode IDESourceControlDisableHistoryTooltips YES
- Make sure no github account configured.
- Have my passphrase already in Xcode's keychain
- Will use a demo github account (MikeFerrisDemo)
    - Have some repos starred
    - !!! Find a project with some good history that I can push up as a personal repo for the Clone part below
- Make sure disclosure state and log viewer filter is good in explore project (XCTest)
- Make a new copy of Jogr
- Open a Finder window shwoing it in outline

### Github Accounts
- I'm excited to show you some of the great new ways to work with source control in Xcode, including how Xcode can work with Github.
- Let's start by setting up my Github account in Xcode's Accounts prefs
- **Choose Preferences, Accounts**
- **Click plus button**
- Xcode has support for both github.com and github enterprise. I'll add my github.com account.
- **Choose Github**
- For my account I just need my name and password
- Xcode also fully supports Github's 2 factor authentication
- **Enter MikeFerrisDemo, wwdc2017**
- I can choose the default method for cloning new repositories
- And I can set an ssh key to use when needed
- Now, my account is all set up

### Clone...
- So, let's clone a repository
- **Welcome window: Clone...**
- Xcode has an all new clone window that makes cloning from Github easy
- When I bring it up I see all my repositories. My personal repositories, the ones from my organizations and any that I have starred
- At the bottom of the window I see some details about the selected repository... the project's description, its language, the number of forks and stars and a link to the README if you want even more info
- _SKIP_
    - And for even more information I can view the repository's README
    - **Click README**
    - **Scroll a bit, then close it**
- Using the search field I can search for other repos on github
- **Type Swift Networking in search**
- If I find something I like I can clone it
- _SKIP_
    - and I can star it right from here to make it easy to find again
    - **Star AlamoFire**
- For things not on GitHub, I can enter the URL for a repository on any server in the search field
- _SKIP_: I already have the project I want cloned, so I am just going to open it
    - But for now, I want to clone one of my own GitHub repositories
    - **Cancel search**
    - **Select demo project**
    - **Clone...**
    - **Choose save location**

### Explore
- _SKIP_
    - Once the clone completes, Xcode opens the workspace
- **Go to SCM nav**
- Xcode 9 has a new navigator that is devoted to source control
- It shows any repositories that are part of my workspace
- Inside the repo I can see all the branches, tags and remotes
- **Select current branch**
- The master branch is the currently checked out branch
- Selecting it shows its complete history in the editor area
- There's a lot to see here
- _SKIP_
    - We pull avatars from Github for the authors of commits
- There are annotations to show if a commit is tagged or the head of a branch
- **Point out branch and tag annotations**
- _SKIP_ (remove unless I can figure out how to motivate this)
    - Merge commits are called out with a special icon on the commit hash
    - **Point out a merge commit**
- Projects can have a lot of history, so filtering can be important
- I can filter commits based on author or commit message content
- **Type ferris, select author filter**
- Let's see just commits that I made
- **Type Swift3 and hit enter**
- I want to find one that I know had to do with Swift3 API updates
- Once I find a commit, The inspector shows even more detail about a commit
- **Open inspector**
- I can see all the branches that this commit is on
- And all the files that were changed by this commit
- **Show these, then close inspector**
- Finally, double-clicking a commit takes me to the new commit viewer, showing me all the source changes
- **Double-click the first commit**
- **Show a file or two**
- Xcode 9 makes it easy to dig through history and really get down to the detailed changes

### Creating branches
- But now let's make some changes
- I have another project here that needs a bit of cleanup
- **Close the explore project**
- I'll open it now
- **Welcome window: Open second demo project**
- _SKIP_
    - Before I start making changes, let's make a branch to work on
    - **Go to SCM nav**
    - I'll make a new branch from our current branch, master
    - **Select master**
    - **Use gear menu to make a branch**
    - Now we are checked out to our new branch and we can start making changes

### Structure editing
- **Go to Project nav**
- In my projects I like to keep group structure and file structure the same
- This used to take some work, but Xcode 9 makes it easy
- When you're working in a project where these structures are the same Xcode will automatically keep them the same
- **Select a couple files**
- Making a new group makes a new folder
- **Context Menu->New Group from Selection**
- And, the files that I grouped are moved into that folder
- **Rename group**
- When I rename the group, it updates the folder name as well
- And, when I move files between groups, it will move them between folders as well
- **Move some files from one group to another**
- And, best of all, as Xcode is doing all this it is also making sure that these changes are being registered with source control.
- **Source Control->Commit...**
- When I commit, I can see that Xcode knows about all the changes I've been making in the file system as well as in the project
- **Type a comment and commit**

### Working with Branches and Tags
- _SKIP_
    - Now I am ready to land my branch
    - **Go to SCM nav**
    - I'll check the master branch out again
    - **Select master**
    - **Use gear menu to check out**
    - And I will merge my new branch back into master
    - **Use gear menu to select Merge into master**
    - And finally I will create a new tag
    - **Use gear menu to choose New Tag...**

### Create on github
- _SKIP_
    - I think I am ready to share this work. But this project isn't on Github yet
    - Let's put it there
    - **Select repo**
    - **Use gear menu to create a new github project and push**
    - My project is now hosted on Github and I can start sharing it


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

