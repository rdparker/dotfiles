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

echo gitdir: `pwd`/.git > ~/.git
