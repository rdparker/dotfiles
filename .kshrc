# Define environment variables
if [ -x /bin/whoami ]; then
	WHOAMI=/bin/whoami
elif [ -x /usr/software/bin/whoami ]; then
	WHOAMI=/usr/software/bin/whoami
else
	WHOAMI=whoami
fi

# Set up the command line prompt
PS1="`uname -n`{${USERNAME:-`$WHOAMI`}}: "

# Alias definitions

alias lf="/bin/ls -aCF"
alias l="/bin/ls -lau"
alias df="/bin/df -a"
alias whois="ypcat passwd | grep "
alias pushd="export PUSHD=`pwd`"
alias popd="cd $PUSHD"
alias lf="/bin/ls -aCF"
alias l="/bin/ls -alg"

# rdp/pron changes
#XAUTHORITY=$HOME/.xauth/.XAuthority-`hostname -s`
#export XAUTHORITY

if [ "$TERM" == "xterm" ]; then
    case `uname` in
	CYGWIN*)
	    TERM=xterm-256color
	    export TERM
	    ;;
    esac
fi
P4EDITOR=emacsclient
P4DIFF="diff -dupU8"
P4MERGE=~/bin/emerge
export P4EDITOR P4DIFF P4MERGE
