#! /bin/csh
#
# Setup the home directory to use this git repo for its config files
#
# Author: Ron Parker <rdparker@gmail.com>
if ( -f ./setup.csh && -o ./setup.csh ) then
    echo >/dev/null
else
    echo "Run this script from directory where it was checked out."
    exit 1
endif

if ( -e ~/.git ) then
    echo "~/.git already exists."
    exit 2
endif

# Tell the home directory to use this cloned repository.
echo gitdir: `pwd`/.git > ~/.git


# Tell git to check things out to the home directory.
if ( x`git config core.worktree` =~ x ) git config core.worktree "../../"
if ( x`git config core.worktree`x !~ x\.\./\.\./x ) then
    echo "The git config core.worktree is not set correctly."
    exit 3
endif
