System Configuration Files
==========================

Essential configuration files are tracked in git.  Use

	git ls-files

to see which ones.

To install this on a new machine:

	git clone https://github.com/rdparker/dotfiles ~/.home
	cd ~/.home
	./setup.csh

The setup script will configure the cloned repository to checkout files into
the home directory and will configure the home directory to use the cloned
repository.  Then it will safely checkout the files without overwriting any
preexisting ones and will report all files that differ.
