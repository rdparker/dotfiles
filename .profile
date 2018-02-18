#
# @(#)local.profile 1.4 93/09/15 SMI
#
set -h
umask 022
which stty > /dev/null && stty istrip
PATH=/bin:/usr/bin:/usr/sbin:/usr/ucb:/etc:/netapp/bin:/netapp/gnu/bin:/usr/ccs/bin:/usr/software/bin:/usr/software/utils/bin:/usr/software/rats/bin:/usr/software/test/bin:.
LD_LIBRARY_PATH=/usr/lib:/netapp/gnu/lib:/usr/ucblib:/usr/local/lib
ENV=$HOME/.kshrc
EDITOR=vi
which stty > /dev/null && stty erase '^H'

# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.2-3

# ~/.profile: executed by the command interpreter for login shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.profile

# Modifying /etc/skel/.profile directly will prevent
# setup from updating it.

# The copy in your home directory (~/.profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benificial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .profile file

# Set user-defined locale
#
# Some locale commands have a -uU switch, others do not. Handle both cases.
which locale > /dev/null && export LANG=$(locale -uU 2>/dev/null || locale | grep LANG=)

# Powerline setup
if [ -d ~/.local/bin ]; then
    PATH="$PATH:~/.local/bin"
fi

# Add RVM to PATH for scripting
if [ -d ~/.rvm/bin ]; then
    PATH="$PATH:$HOME/.rvm/bin"
fi

# Add local user bin path
#
# This is a somewhat strange configuration, but it's how things were
# pre-configured at an employer, with there being a ~/bin/bin.<ARCH>
# directory for specific architectures and it worked since your home
# directory was shared between Windows, Linux, Mac, and other systems.
#
# Basically it's like using ~/bin as the GNU --prefix and
# ~/bin/(s)bin.<ARCH> as the --(s)bindir.
case `uname` in
    CYGWIN_*-WOW) ARCH=cygwin.x86 ;;

    *) ARCH=x86_64 ;;
esac
if [ -d ~/bin/bin.$ARCH ]; then
    PATH="~/bin/bin.$ARCH:$PATH"
fi

# This file is not read by bash(1) if ~/.bash_profile or ~/.bash_login
# exists.
#
# if running bash
if [ -n "${BASH_VERSION}" ]; then
  if [ -f "${HOME}/.bashrc" ]; then
    ENV="${HOME}/.bashrc"
  fi
fi

export PATH ENV EDITOR LD_LIBRARY_PATH
. ${ENV}
