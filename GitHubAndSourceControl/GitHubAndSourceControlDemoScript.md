## SOTU GitHub/SCM Demo
_WWDC 2017_

###TODO
- Audit "No editor"
- Figure out what change I want to make
- Figure out plan for no internet
	- Try this and make sure error message when it first occurs is not embrarrassing
	- Slides for GitHub accounts, Clone..., and Create on GitHub
	- Have the Explore project cloned locally somewhere already
- Should we try to cache the ReadMe?

### Account Setup
- GitHub account:
	- WWDC2017, mfdemo2017
	- Personal repos
		- NotessAndIdeas
		- AwesomeNewGame
	- Org: Stultus Enterprises
		- MuchRemainsToBeDone
		- RushIn
		- ShameOnMe
	- Starred:
		- swift
		- swift-package-manager
		- swift-corelibs-foundation
- No AppleID, enable Siri
- Make WWDC2017 folder in ~/Documents
- Make Demo folder in ~/Documents
- Configure AppleConnect (or have another way to get the SolorSystem repo and be able to sync it)
- Defaults
	- defaults write com.apple.dt.Xcode IDESourceControlDisableHistoryTooltips YES
	- defaults write com.apple.dt.Xcode IDESourceControlUIPresentationMode YES
	- defaults write com.apple.dt.Xcode IDESourceControlClonePrefersToOpenProjects YES
- Safari
	- Pin github.com
	- log in (WWDC2017, mfdemo2017) and save login info
	- Pin stash.sd.apple.com
	- log in and save login info
- Xcode
	- Add AppleID account (mferris)
	- Confiugure a key equivalent for refresh scm status
- Clone into the WWDC2017 folder
	- https://mferris@stash.sd.apple.com/scm/~kenneth_orr/dt-wwdc-2017-sotu-demos.git (to SolarSystem)
	- swift-corelibs-foundation (as a backup)

### Pre-Demo Setup
- Make sure no github account configured
- Make sure disclosure state and log viewer filter is good in explore project (XCTest)
- Make a new copy of demo project
- Remove avatar cache
	- ~/Library/Caches/xcavatar.cache and ~/Library/Caches/XCAvatarImages (???)
- Make sure avatar cache is heated up
- Copy pristine SolarSystem repo from WWDC2017 to Demo and remove its remote
- Unstar Foundation
- Open SolarSystem and minimize window
- Xcode prefs on Accounts

### Github Accounts
- Thanks, Matthew!  Good afternoon, everyone! Today I want to show you some of the great new ways to work with source control in Xcode, and especially how Xcode can work with Github.
- Getting started with GitHub is easy.
- **Choose Preferences -> Accounts**
- **Click plus button**
- Xcode supports both github.com and github enterprise.
- **Choose Github**
- I just enter my name and password, 
- **Enter WWDC2017, mfdemo2017**
- ...and my account is all set up.

### Clone...
- So, let's go get a repository
- **Close Prefs**
- **Cmd-Shift-1**
- **Welcome window: Clone...**
- Xcode has an all new clone workflow that makes getting content from Github easy.
- All my GitHub repositories are front and center. My personal repositories, any I have marked with a star, and repositories from my organizations.
- There are details for the selected repository... its description, primary language, and the number of stars and forks.
- For more information I can view the repository's README.
- **Click README**
- **Close it**
- Using the search field I can search GitHub.
- **Type "corelibs project" in search**
- When I find something I can clone it directly or I can star it.
- **Star swift-corelibs-foundation**
- **Cancel search**
- Now that it's starred I see it in my main list.
- **Select swift-corelibs-foundation**
- **Clone...**
- **Choose save location**

### Explore
- Once the clone completes, Xcode opens the project.
- **Go to Source Control navigator**
- Xcode 9 has a new navigator that is devoted to source control.
- I see the repositories in workspace.
- Inside a repository I see its branches, tags and remotes.
- **Select current branch**
- Selecting a branch shows its complete history.
- We pull avatars from Github for the authors of commits.
- And there are annotations showing tags
- **Select a commit that has a tag**
- ... and branches.
- **Select a commit that is a branch head**
- I can filter the history by author or commit message.
- I'll find the commits that Philippe made,
- **Type "hausler", select author filter**
- ... and I'll narrow it down a little more.
- **Type "value" and hit enter**
- Once I find a commit, the inspector shows even more detail.
- **Open inspector**
- including all the files that were changed by this commit. This looks like the one I was looking for.
- **Close inspector**
- Double-clicking a commit takes me to the new commit viewer, where I can see all the source changes.
- **Double-click the "value types" commit**
- **!!!Show a file or two**
- Xcode 9 makes it easy to browse history and really get down to detailed changes.

### Creating branches
- Xcode can also help you manage source control while you're making changes.
- I have a project that that needs some changes before I share it with the world
- **Close the explore project**
- **Window -> SolarSystem**
- When I start working, it's easy to create a new branch.
- **Go to Source Control navigator**
- **Select master**
- **Use context menu to make a branch**
- OK, I am checked out on my new branch and ready to make changes.

### Structure editing
- **Go to Project navigator**
- In my projects I like to keep the group structure and Finder structure the same.
- Xcode 9 makes this easy.
- In projects where these structures _are_ the same Xcode will automatically _keep_ them the same.
- When I move files between groups, they move in Finder too.
- **Move some files from one group to another**
- When I rename the group, it the folder is renamed as well.
- **Rename group**
- Best of all, as I am doing all of this these changes are being registered with source control.
- **Source Control->Commit...**
- When I commit, I can see that Xcode knows about all the changes I've been making in the file system as well as in the project
- **Type a comment and commit**

### Working with Branches and Tags
- When I am ready to land my branch, the source control navigator makes it easy.
- **Go to Source Control navigator**
- I select the destination branch, 
- **Select master branch**
- ... and do the merge
- **Use context menu Merge from working branch into master**
- I can also easily create new tags from any commit.
- **Select new commit in log view**
- **Use context menu to choose New Tag...**

### Create on github
- Now I am ready to share my app. 
- This project isn't on Github yet, but I can easily put it there.
- **Select repo**
- **Use gear menu to create a new github project and push**
- My project is now hosted on Github.
- I can jump right to Github to see it from the new origin remote.
- **Open remotes group**
- **Right click origin and choose Show in GitHub**
- And here it is.

### Conclusion
- Xcode 9 has some great new source control features to help you understand your project's history, implement new features, and to use GitHub to collaborate with all the other developers out there.
- I hope you'll give it a try and let us know what you think!
- Thank you.


### Random Radars

##### Beta 1
- <rdar://problem/30291887> New commit view could be more discoverable: add a button to go from the history view to the commit details view
- <rdar://problem/32332306> Add a "View on GitHub…" contextual menu for a GitHub-hosted remote
- <rdar://problem/32390457> [SOTU] When the SCM history view loads for the first time after launching Xcode and you have a cache, we don't read the cache
- <rdar://problem/32390829> [SOTU] After you commit changes on a branch and merge to another branch, the history view doesn’t refresh
- <rdar://problem/32390411> [SOTU] When you star from a search result we should reflect the star back in the reachable list
- <rdar://problem/32039210> Repositories Window: When the window first comes up, the first repo in the list should be selected
- <rdar://problem/32390407> [SOTU] We need to finder sort in the buckets for the reachable repositories
- <rdar://problem/32391218> [SOTU] Can we make the "R" / rename indicators show up faster
- <rdar://problem/32402123> [SotU] Default to suppress the Merge comparison sheet
