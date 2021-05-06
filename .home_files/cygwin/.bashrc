# Cygwin-specific bash settings  -*- mode: sh; -*-
#
# Ron Parker 09-June-2015
#

# Disable core files.  These are a frequent occurrence on Cygwin and
# tend to clutter up my directories.
ulimit -c 0
