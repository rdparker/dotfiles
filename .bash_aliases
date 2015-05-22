# Personal bash aliases  -*- mode: sh; -*-
#
# Ron Parker 13-May-2015
#
# 22-May-2015 - Add aliases for toggling between Dvorak and US layouts
#		Add color and ls aliases
#
alias aoeu='setxkbmap us'
alias ar.g='setxkbmap us'
alias asdf='setxkbmap dvorak'

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
