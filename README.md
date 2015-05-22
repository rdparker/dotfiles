System Configuration Files
==========================

Essential configuration files are tracked in git.  Use

	git ls-files

to see which ones.

To install this on a new machine:

	curl https://raw.githubusercontent.com/rdparker/dotfiles/master/.home/setup.csh | csh

or

	wget -O -https://raw.githubusercontent.com/rdparker/dotfiles/master/.home/setup.csh | csh


The script will clone the repository ,configuring it to check files
out into the home directory, which will be configured to use the
cloned repository.  Then any nonexistent files will be checked out and
any preexisting ones which differ will be reported.

It is up to the user to merge files which differ, to check in the
merged files, and to push the changes to the original repository.
