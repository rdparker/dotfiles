# Personal bash aliases  -*- mode: sh; -*-
#
# Ron Parker 13-May-2015
#
# 22-May-2015 - Add aliases for toggling between Dvorak and US layouts
#		Add color and ls aliases

# Editor
[ -n "$DISPLAY" ] && SWITCH=-c || SWITCH=-t
alias e='emacsclient -a ""'" $SWITCH"
unset SWITCH

# Keyboard layout switching.  This allows me to hit the for home row
# characters under the left hand to switch keyboard layouts, even if
# the computer has been set to Dvorak and a Dvorak keyboard is
# plugged in.
if [ -n "$DISPLAY" ]; then
    alias aoeu='setxkbmap us'
    alias ar.g='setxkbmap us'
    alias asdf='setxkbmap dvorak'
fi

# Colorize things
alias less='less -r'                          # raw control characters
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              # column-wise

# tmux
TMUX_CMD='\tmux -L '"$USER"
TMUX_CONF=`find_file .tmux.conf`
[ -n "$TMUX_CONF" ] && TMUX_CMD="$TMUX_CMD"\ -f\ "$TMUX_CONF"
alias tmux="$TMUX_CMD attach || $TMUX_CMD"
unset TMUX_CMD TMUX_CONF
