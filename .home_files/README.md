System Configuration Files
==========================

Essential configuration files are tracked in git using a method similar to
[The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles).

Once it has been setup, use

	cd
	dotgit ls-files

to see which files are being tracked.

To install this on a new machine:

	curl https://raw.githubusercontent.com/rdparker/dotfiles/master/.home_files/setup.csh | csh

or

	wget -O -https://raw.githubusercontent.com/rdparker/dotfiles/master/.home_files/setup.csh | csh

On Guix ~csh~ and ~curl~ are not installed by default, so create an
alias and use ~wget~:

    alias csh='guix shell tcsh -- csh'
    wget -O - https://raw.githubusercontent.com/rdparker/dotfiles/master/.home_files/setup.csh | csh

The script will create a bare clone of the repository and use an alias to check
files out into the home directory.  The files will define the `dotgit` alias
which is configured to use the cloned repository with $HOME as its working
directory.  Then the script will checkout any nonexistent files and report any
preexisting files that differ from the repo.

It is up to the user to merge files which differ, to check in the
merged files, and to push the changes to the original repository.

There are more details in [dotfiles.org](./dotfiles.org) or
[.home_files/dotfiles.org](.home_files/dotfiles.org). One or the other should
work depending upon which directory you are reading this from. It contains the
notes an other info from when I updated my configuration to use a bare
repository.
