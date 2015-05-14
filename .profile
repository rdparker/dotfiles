#
# @(#)local.profile 1.4 93/09/15 SMI
#
set -ha
umask 022
stty istrip
PATH=/bin:/usr/bin:/usr/sbin:/usr/ucb:/etc:/netapp/bin:/netapp/gnu/bin:/usr/ccs/bin:/usr/software/bin:/usr/software/utils/bin:/usr/software/rats/bin:/usr/software/test/bin:.
LD_LIBRARY_PATH=/usr/lib:/netapp/gnu/lib:/usr/ucblib:/usr/local/lib
ENV=$HOME/.kshrc
EDITOR=vi
stty erase '^H'
export PATH ENV EDITOR LD_LIBRARY_PATH

. ${ENV}
