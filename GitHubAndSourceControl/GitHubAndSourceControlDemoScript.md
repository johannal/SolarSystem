#SOTU GitHub/SCM Demo
_WWDC 2017_

### Random Radars
- <rdar://problem/31757497> Should have a context menu and + button command for adding a remote 
- <rdar://problem/29911644> Branch actions in menu for the new history view and navigator
- <rdar://problem/29911645> Tag actions for the new history view and navigator
- <rdar://problem/29911639> Commit actions for the new history view and navigator
- <rdar://problem/31757622> In the Clone window, default sort should take ownership into account
- <rdar://problem/31757658> Define some conventions/best practices to recommend to people putting packages on github to aid in searching through the Clone workflow.
- <rdar://problem/31761469> Account detail for GitHub accounts should have a "Clone..." button to go right to the clone workflow
- <rdar://problem/31936812> When a blue folder resorts (reloads) we lose selection within it
- <rdar://problem/31311947> After creating a new file in a Blue Folder, the the view refreshes and the name editing is cancelled
- <rdar://problem/31937004> Creating a new branch does not cuase the new branch to show up immediately in the navigator
- <rdar://problem/31937038> Should have alternate New Group commands for specifically creating a green/non-green group
- <rdar://problem/32015457> Clone window is non-modal but the menu item to show it is disabled if it is visible but not ordered front
- <rdar://problem/32015433> New Clone... window shows up in a werid screen position. It should come up centered
- <rdar://problem/31937721> The GitHub account detail needs an HI pass
- <rdar://problem/31761450> Account details for GitHub accounts should show list of organizations I belong to
- <rdar://problem/30960652> Package dependency editor adoption of new repository UI
- <rdar://problem/30960546> New repository UI - global repository search by name
- <rdar://problem/30960488> API to access repository README
- <rdar://problem/30960578> New repository UI - favoriting repos
- <rdar://problem/31938196> Initial navigaotr state... should some repos be disclosed?
- <rdar://problem/31938086> Remote package repos have weird hash as part of their name, showing up in SCM nav
- <rdar://problem/31019822> GitHub on-ramping during project creation


### Setup
* Make sure no github account configured

### Github Accounts
* I'm excited to show you how Xcode can work with github and some of the new ways to explore and work with you git repositories
* Let's start by getting Xcode hooked up to my github account
* I can do this in Xcode account prefs
* Xcode has support for both github and github enterprise. I'll add a regular github account
* if my account has 2 factor auth enabled, Xcode will automatically request a code and let you enter it. My account just uses simple name and password.
* Now I have my account set up. By default Xcode will make new clones using https, but you can also choose to use ssh and choose what key to use.

### Clone...
* now that I have my account set up, let's get a repository.
* Xcode has a brand new clone window. When I bring it up I immediately see all my github repositories. This includes my personal repos, repos from organizations I belong to and any repos I have starred.
* As I select these I can see more info in the detail view below. And I can pull up the repository's readme to see more detail.
* Using the search field I can search for other repos on github and  github enterprise.
* If I find something I like I can clone it of course, and I can star it right from here to make it easy to find again.
* Finally, if I want to clone from another source, I can enter any URL in the search field and clone it.

### Explore
* once the clone completes, Xcode opens the workspace.
* You may notice that there is a new navigator, this is the source control navigator. In it we see the repositories involved in our workspace.
* In this case there's one repo, but in more complicated workspaces there might be any number of repositories.
* Under each repo we can see branches, tags and remotes.
* We can use the inspector to see more detail. One really useful thing in the inspector for each repository is a place to set your name and email address for commits.
* We can see that currently the master branch is checked out. If I select any branch, tag or remote branch, a log viewer shows the complete history of it.
* Selecting a commit shows more detail in the inspector.
* Filtering in the log viewer is really useful for finding things. I can filter based on text in the commit messages or based on the author.
* When I find a particular commit I am looking for, I can double click on a commit to open a full commit viewer to see all the actual changes from that commit.

### Structure editing
* all this exploring is fascinating. But sooner or later we're going to want to make some changes.
* Now in many projects people like to keep group structure and fiel structure the same. Xcode now makes that easy. When you're working in a project where these structures are the same Xcode will automatically preserve that for you.
* when I make a new group, Xcode will also make a new folder. And when I rename it, the folder follows suit.
* When I move files between groups, they'll also be moved in the file system.
* And, best of all, as Xcode is doing all this it is also making sure that these changes are being registered with your repository.
* When I commit, I can see that Xcode has noticed all the changes I've been making in the file system.

### Working with Branches and Tags
* earlier we saw some of the cool information that can be found in the new source control navigator. But it also lets us perform common source control operations.
* I'll make a new branch before I commit my changes.
* Now I can put my changes on this new branch.
* I can check the master branch out again.
* And I can merge my new branch back into master.
* And finally I can create a new tag

### Push to github
* /how do we do this... need to make a new project at some point above?/

### Fixed bugs
- <rdar://problem/31936990> SCM navigator should have Branches and Tags groups even if there aren't any
- <rdar://problem/31757488> We should show the Remotes folder under a git repo even if there are no remotes
