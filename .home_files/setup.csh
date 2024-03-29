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
# TODO Correct the above command because setup.sh is not in .home.
cd ~
if (x$1 =~ x-i ) set ignore = true
if (! $?ignore) then
    if ( -d .home ) then
	echo "The ~/.home directory already exists."
	exit 1
    else
	git clone --bare https://github.com/rdparker/dotfiles $HOME/.home
    endif
endif

# Define the alias in the current scope.
alias dotgit env git --git-dir=$HOME/.home/ --work-tree=$HOME

# Checkout what we can without overwriting any existing files.
dotgit reset --keep
dotgit status --porcelain | awk '/^ D/{print $2}' | xargs /usr/bin/env git --git-dir=$HOME/.home/ --work-tree=$HOME checkout --

# Report any files that were not checked out.
dotgit status --short

cat - >&2 <<EOF
Either restart the shell or

    source ~/.bash_aliases

to gain access to the ~dotgit~ command.  It may be used in place of git when
dealing with your home directory.
EOF
