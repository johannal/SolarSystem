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


# Now script:
if [[ -z $(git status -s) ]]
then
  echo "Running Ken's preparation script"
else
  echo "Please commit or discard your changes before running this script"
  exit
fi


