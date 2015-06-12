umask 022

if ($?prompt) then
    # crt	same as echoe echoctl echoke
    # isig	enable interrupt, quit, and suspend special characters, ^c, ^\, ^z.
    # crterase	echo erase characters as backspace-space-backspace, ^?.
    # tabs	do not expand tabs to spaces
    # tandem	same as ixoff
    #
    # echoe	same as crterase
    # echoctl	echo control characters in hat notation ('^c')
    # echoke	kill all line by obeying the echoctl and echok settings
    # echok	echo a newline after a kill character (typically ^u)
    # ixoff	enable sending of start/stop characters, ^q, ^s.
    stty crt isig crterase tabs tandem
endif

#
# set misc environment variables
#
setenv ORGANIZATION "NetApp Inc."

setenv MANPATH "/usr/software/man:/usr/man:/usr/man/X11:/usr/openwin/man:/usr/dt/man"
setenv CVSROOT /r/cvs      # where is the CVS repository.
setenv CVSREAD true        # make non-modified files read-only like RCS.

setenv FMHOME /r/frame

set host=`hostname`

# start of real .cshrc

set cdpath=(~ / .. ../.. )

setenv ARCH `arch`

set path = ( ~/.local/bin ~/bin/bin.$ARCH ~/bin \
	    /usr/openwin/bin/xview /usr/openwin/bin /usr/dt/bin \
	    /netapp/bin /netapp/gnu/bin \
	    /usr/software/bin /usr/software/utils/bin \
	    /usr/software/rats/bin /usr/software/test/bin \
	    /usr/local /usr/local/bin /usr/ucb /bin /usr/bin \
	    /usr/etc /usr/games /usr/lib/uucp \
	    /etc /usr/lib /usr/sccs/bin  \
            /usr/local/X11/$ARCH/bin \
	    /usr/bin/X11 $FMHOME/bin \
	    /opt/lotus/bin ~/notes . )

# Don't logout on ^D
set ignoreeof

# rdp - pron - add local RedHat binaries
setenv RHEL_VERSION `uname -r | sed 's/.*\(el[0-9]\).*/\1/'`
setenv RHEL_PATH $HOME/local/$RHEL_VERSION-$ARCH/bin
if (-d $RHEL_PATH ) then
	setenv path = ($path $RHEL_PATH)
endif

if (! $?WINPATH) then
	setenv WINPATH ""

	if( -f ~/.openwinhome ) then
	    foreach D (`cat ~/.openwinhome`)
                if (-d $D) then
                        setenv OPENWINHOME $D
                        setenv WINPATH "$D/bin $D/bin/xview"
                        setenv WINLIBPATH $D/lib
                        set path = ($path $WINPATH)
                        break
                endif
	    end
	endif
endif

        if ($?LD_LIBRARY_PATH) then
                setenv LD_LIBRARY_PATH  "/usr/local/X11R5/sun4c/lib:"$LD_LIBRARY_PATH
        else
                setenv LD_LIBRARY_PATH  "/usr/local/X11R5/sun4c/lib"
        endif


if ($?WINLIBPATH) then
        if ($?LD_LIBRARY_PATH) then
                setenv LD_LIBRARY_PATH  $WINLIBPATH":"$LD_LIBRARY_PATH
        else
                setenv LD_LIBRARY_PATH  $WINLIBPATH
        endif
endif

        if ($?LD_LIBRARY_PATH) then
		setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/netapp/gnu/lib:/usr/openwin/lib:/opt/lotus/common/lel/r100/sunspa41:/usr/local/X11R5/sun4c/lib:/usr/lib
	else
		setenv LD_LIBRARY_PATH /netapp/gnu/lib:/usr/openwin/lib:/opt/lotus/common/lel/r100/sunspa41:/usr/local/X11R5/sun4c/lib:/usr/lib
	endif

if (! $?TERM) then
	setenv TERM unknown
endif

if ($?prompt) then
	alias a alias
	set history=50 savehist=0
	set filec

a wlabel 'echo -n "\!*" > /dev/null'
if ($TERM =~ sun*) then
	if ($TERM == "sun" || $TERM == "sun-cmd" || $TERM == "sun-34") then

		# set name stripe of tool
		a header 'echo -n "]l\!*\"'
		# set label on tool iconic form
		a iheader 'echo -n "]L\!*\"'
		# set icon image of tool
		a icon 'echo -n "]I\!*\"'
	
		a   ilabel	'echo -n "]L\!*\"'
		a   wlabel 	'echo -n "]l\!*\"'
		a   	stretch	'echo "[8;\!*;80t"'
		a	close	'echo "[2t"'
		a	cl	'close;clear'
		a	hide	'echo "[6t"'
		a	expose	'echo "[5t"'
		a	wl	'wlabel `who am i` --- `dirs`'
	
	else
		a wlabel 'echo -n "\!*" > /dev/null'
	endif

	if (`tty` == /dev/console) then
		a wlabel 'echo -n "\!*" > /dev/null'
	endif

endif
# rdp - pron - handle xterms
# Doesn't quite work - rdp
# if ($TERM =~ xterm*) then
    # a wlabel 'echo -n "]2;\!*]1;\!*"'
# endif
endif

if ! $?PERL_MB_OPT setenv PERL_MB_OPT '';
setenv PERL_MB_OPT "--install_base "\""$HOME/perl5"\""";
if ! $?PERL_MM_OPT setenv PERL_MM_OPT '';
setenv PERL_MM_OPT "INSTALL_BASE=$HOME/perl5";
if ! $?PERL5LIB setenv PERL5LIB '';
setenv PERL5LIB $HOME/perl5/lib/perl5:$PERL5LIB;

#setenv XAUTHORITY ~/.xauth/XAuthority-`hostname -s`
setenv POWERLINE_DIR /u/pron/.local/lib/python2.7/site-packages/powerline

if ( ! $?prompt ) exit
if ! $?DOMAIN setenv DOMAIN `domainname`
if ( -f ~/.aliases ) source ~/.aliases
if ( -f ~/.private/$DOMAIN/.aliases ) source ~/.private/$DOMAIN/.aliases

# rdp - pron - remove non-existent stuff from path and update it
set newpath =()
foreach D ( $path )
    # Do not allow . in the path, this is a security risk.  You can
    # wind up running scripts and programs that others have placed in
    # a directory you have cd'd to, such as one of their
    # personal directories.
    if (x$D =~ x\.) continue
    if (-d $D) set newpath = ($newpath $D)
end
set path = ($newpath)
unset newpath

# rdp - pron -
# Find man directories corresponding to path entries inserting them
# before the current MANPATH and removing any non-existent entries.
set manpath=""
foreach D ($path)
    set M=`dirname $D`/man
    if (-d $M) then
	if (x$manpath =~ x) then
	    set manpath=$M
	else
	    set manpath=${manpath}:$M
	endif
    endif
    set M=`dirname $D`/share/man
    if (-d $M) then
	if (x$manpath =~ x) then
	    set manpath=$M
	else
	    set manpath=${manpath}:$M
	endif
    endif
end
foreach D ( `echo $MANPATH | tr '[:]' '[ ]'` )
    if (-d $D) then
	if (x$manpath =~ x) then
	    set manpath=$D
	else
	    set manpath=${manpath}:$D
	endif
    endif
end
setenv MANPATH $manpath
# Uniquify MANPATH
setenv MANPATH `manpath`
unset manpath
unset D
unset M

# Setup editor and alias, preferring emacsclient with a new frame or terminal.
which emacsclient > /dev/null && setenv EDITOR emacsclient || setenv EDITOR vi
if ( x$EDITOR =~ xemacsclient ) then
    if( $?DISPLAY ) then
	setenv EDITOR "emacsclient -c -a ''"
    else
	setenv EDITOR "emacsclient -t -a ''"
    endif
endif
a e "$EDITOR \!*"

top -b -n 1 | head -1 | egrep --color '([1-9][0-9]\.[0-9][0-9]|[3-9]\.[0-9][0-9])' || \
	top -b -n 1 | head -1
