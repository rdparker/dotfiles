#! /bin/csh
#
# Setup the home directory to use this git repo for its config files
#
# Author: Ron Parker <rdparker@gmail.com>
#
# Clone the repository, but don't overwrite anything
#
# Usage: setup.csh [-i]
#
#    -i Ignore the existence of the .home directory.  This is useful for
#       running setup on machines that do not have Internet access for
#       doing a direct checkout from github.  Rather copy the .home
#       directory to them and run '.home/setup.csh -i'.
#
cd ~
if (x$1 =~ x-i ) set ignore = true
if (! $?ignore) then
    if ( -d .home ) then
	echo "The ~/.home directory already exists."
	exit 1
    else
	git clone --no-checkout --config core.workdir=../../ https://github.com/rdparker/dotfiles .home
    endif
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
