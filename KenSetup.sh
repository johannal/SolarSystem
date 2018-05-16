#! /bin/sh

# Comments changing instructions:

# git checkout andrew_color_comments — checks out this tag
# Make changes in comments in SolarSystemSceneViewController
# git add .
# git commit --amend

# [OPTIONAL] To change author, run: git commit --amend --author "AuthorName <email>"

# After amending, tag is broken, so remove old one and recreate new one in this place
# Remove old tag: git tag -d andrew_color_comments
# Create new tag: git tag -a andrew_color_comments -m "Andrew color comments for Ken's demo"

# Remember to push tag to origin again: git push --force origin andrew_color_comments

# Finished, checkout back to your branch.


# Now script.
# Remember: after running this, your remote will be set to release.
# To fix it, just run ./Script cleanup

if [ -z "$1" ] && [$1 == "cleanup"]; then
    git branch --set-upstream-to=origin/master
    exit 0;
fi

if [[ -z $(git status -s) ]]
then
  echo "Running Ken's preparation script"
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    if [[ "$BRANCH" != "master" ]]; then
        echo 'Your current branch has to be master';
        exit 1;
    fi
    git branch --set-upstream-to=origin/master
    git branch -D release
    git checkout -b release
    COMMIT_HASH=$(git rev-parse andrew_color_comments)
    git cherry-pick $COMMIT_HASH
    # Come back to master
    git checkout master
    git branch --set-upstream-to=release
else
  echo "Please commit or discard your changes before running this script"
  exit
fi


