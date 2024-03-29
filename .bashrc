# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

# Make Flatpak apps visible to launcher
export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"

if [[ $- != *i* ]]
then
    # We are being invoked from a non-interactive shell.  If this
    # is an SSH session (as in "ssh host command"), source
    # /etc/profile so we get PATH and other essential variables.
    [[ -n "$SSH_CLIENT" ]] && source /etc/profile

    # Don't do anything else.
    return
fi

# Source the system-wide file.
source /etc/bashrc

source ~/.kshrc

# Set a default prompt of: user@host and current_directory
#
# In bash, characters between \[ and \] are treated as non-printing
# and consume no horizontal space on the screen as far as the shell is
# concerned.  The rest of the codes should be explained in the "Xterm
# Control Sequences" document.
# Adjust the prompt depending on whether we're in 'guix environment'.
if [ -n "$GUIX_ENVIRONMENT" ]
then
    GUIXENV=" [env]"
fi

# If we are not in Emacs, set the window and icon title.
if [ -z "$INSIDE_EMACS" ]; then
    TITLE="\[\e]0;\w\a\]"
fi
PS1="$TITLE"'\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]'"$GUIXENV"'\n\$ '
unset TITLE GUIXENV

alias ls='ls -p --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Machine specific file loading functionality
#
# Get operating system and machine name values for looking up
# system-specific scripts.
case `uname` in
    MINGW32*) SYSTEM=mingw32 ;;	# git bash's mingw32 does not support uname -o
    *) SYSTEM=${SYSTEM:-`uname -o | tr [A-Z/] [a-z-]`} ;;
esac
if type domainname > /dev/null 2>&1 ; then
    DOMAIN=${DOMAIN:-`domainname | tr [A-Z/] [a-z-]`}
    MACHINE=${MACHINE:-`domainname -s | tr [A-Z/] [a-z-]`}
    FQDN=${FQDN:-`domainname -f | tr [A-Z/] [a-z-]`}
elif [ x"$SYSTEM"x == xmingw32x ] ; then
    DOMAIN=${USERDNSDOMAIN}
    MACHINE=${COMPUTERNAME}
    FQDN=${MACHINE}.${DOMAIN}
fi

# If a file exists, source it.
function maybe_source() {
    [ -f "$1" ] && source "$1"
}

# Source any public and private versions of the given file.
function source_some() {
    local file="$1"

    if [ "`basename $file`" != ".bashrc" ]; then
	maybe_source "$HOME/$file"
    fi
    maybe_source "$HOME/.home/$file"
    maybe_source "$HOME/.private/$file"
}

# Source all versions of the file including domain- and machine-specific ones.
function source_all() {
    local file="$1"

    source_some "$file"
    [ -n "$SYSTEM" ] && source_some "$SYSTEM/$file"
    [ -n "$DOMAIN" ] && source_some "$DOMAIN/$file"
    [ -n "$MACHINE" ] && source_some "$MACHINE/$file"
    [ -n "$MACHINE" ] && source_some "$MACHINE/$file"
}

function find_file() {
    local file="$1"
    RESULT=""

    for f in $HOME/{.private/,.home/,}{$MACHINE/,$DOMAIN/,$SYSTEM/,}$file; do
	if [ -f "$f" ]; then
	    echo "$f"
	    break;
	fi
    done
}

# Pickup system-specific .bashrc files
source_all .bashrc

# Aliases
#
# Some people use a different file for aliases
source_all .bash_aliases

#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
# alias df='df -h'
# alias du='du -h'
#
# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
# alias grep='grep --color'                     # show differences in colour
# alias egrep='egrep --color=auto'              # show differences in colour
# alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
# alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
# alias ll='ls -l'                              # long list
# alias la='ls -A'                              # all but . and ..
# alias l='ls -CF'                              #

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
# settitle ()
# {
#   echo -ne "\e]2;$@\a\e]1;$@\a";
# }
#
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
# cd_func ()
# {
#   local x2 the_new_dir adir index
#   local -i cnt
#
#   if [[ $1 ==  "--" ]]; then
#     dirs -v
#     return 0
#   fi
#
#   the_new_dir=$1
#   [[ -z $1 ]] && the_new_dir=$HOME
#
#   if [[ ${the_new_dir:0:1} == '-' ]]; then
#     #
#     # Extract dir N from dirs
#     index=${the_new_dir:1}
#     [[ -z $index ]] && index=1
#     adir=$(dirs +$index)
#     [[ -z $adir ]] && return 1
#     the_new_dir=$adir
#   fi
#
#   #
#   # '~' has to be substituted by ${HOME}
#   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
#
#   #
#   # Now change to the new dir and add to the top of the stack
#   pushd "${the_new_dir}" > /dev/null
#   [[ $? -ne 0 ]] && return 1
#   the_new_dir=$(pwd)
#
#   #
#   # Trim down everything beyond 11th entry
#   popd -n +11 2>/dev/null 1>/dev/null
#
#   #
#   # Remove any other occurence of this dir, skipping the top of the stack
#   for ((cnt=1; cnt <= 10; cnt++)); do
#     x2=$(dirs +${cnt} 2>/dev/null)
#     [[ $? -ne 0 ]] && return 0
#     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
#     if [[ "${x2}" == "${the_new_dir}" ]]; then
#       popd -n +$cnt 2>/dev/null 1>/dev/null
#       cnt=cnt-1
#     fi
#   done
#
#   return 0
# }
#
# alias cd=cd_func
if [ -z "$TMUX" -a "$TERM" = "xterm" ]; then
    export TERM=xterm-256color
fi

# Enable powerline, if found.
if test -z "$POWERLINE_DIR" && powerline-daemon -q -r > /dev/null 2>&1; then
    POWERLINE=`which powerline 2>/dev/null`
    PYTHON_VER=$(python -V 2>&1 | sed 's/[^0-9]*\([0-9]*\.[0-9]*\).*/\1/')
    POWERLINE_DIR=$(dirname $(dirname $POWERLINE))
    POWERLINE_CONFIG_COMMAND=$POWERLINE_DIR/bin/powerline-config
    POWERLINE_DIR=$POWERLINE_DIR/lib/python${PYTHON_VER}/site-packages/powerline
    POWERLINE_SCRIPT=$POWERLINE_DIR/bindings/bash/powerline.sh
    if [ -f $POWERLINE_SCRIPT ]; then
	. $POWERLINE_SCRIPT
    fi
    unset PYTHON_VER POWERLINE_SCRIPT
    export POWERLINE_CONFIG_COMMAND POWERLINE_DIR
fi
unset POWERLINE

# If running the Windows Subsystem for Linux (WSL), assume there is an separate
# X Windows Server running.  I typically use MobaXterm Personal.
case `uname -r` in
    *-Microsoft) export DISPLAY=:0;;
esac

# Enable git subrepo, if available
if [ -r ~/lib/git-subrepo/.rc ]; then
    source ~/lib/git-subrepo/.rc
fi

# Load Nix environment
if [ -f /run/current-system/profile/etc/profile.d/nix.sh ]; then
  . /run/current-system/profile/etc/profile.d/nix.sh
fi

#  Enable direnv, if present
if command -v direnv &> /dev/null
then
    eval "$(direnv hook bash)"
fi
