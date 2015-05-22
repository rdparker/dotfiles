#! /bin/csh
#
# Setup the home directory to use this git repo for its config files
#
# Author: Ron Parker <rdparker@gmail.com>

# Clone the repository, but don't overwrite anything
cd ~
if ( -d .home ) then
    echo "The ~/.home directory already exists."
    exit 1
else
    git clone --no-checkout --config core.workdir=../../ https://github.com/rdparker/dotfiles .home
endif

# Tell the home directory to use this cloned repository.
cd .home/
echo gitdir: `pwd`/.git > ~/.git
cd ~

# Checkout what we can without overwriting any existing files.
git reset --keep
git status --porcelain | awk '/^ D/{print $2}' | xargs git checkout --

# Report any files that were not checked out.
git status --short
