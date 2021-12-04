
Debugging {{{1

Default shell
    echo $SHELL
Current shell
    echo $0

Show options
    set -o
Test for set option
    [[ -o opt ]]


Docs {{{1

http://reasoniamhere.com/2014/01/11/outrageously-useful-tips-to-master-your-z-shell/


http://www.rayninfo.co.uk/tips/zshtips.html
Man page shortcut: Esc+H

http://reasoniamhere.com/2014/01/11/outrageously-useful-tips-to-master-your-z-shell/

Builtins {{{1

vared
    edit environment variables


Configuration {{{1

Display options in/not in effect:
    setopt
    unsetopt

zprofile: 
    only run by login shells (called with -l) or su -.  Use for env vars used by
    applications, e.g. MAI
zshenv: 
    only startup that is always run.  Best place for environment
variables
zshrc
zlogin: 
    runs after zshrc.  Purpose really just equivalent of Bourne-type
    shells /etc/profile and csh login (?).


Start zsh with no configuration
zsh -f -d
source alternativefile.rc


Keyboard bindings {{{2


bindkey
	noarg	print existing bindings
	-d		delete all keymaps, reset to default
	-m		if binding ESC also bind Alt
	-l/L	list short/long form



Parameters {{{2

set by:
    parameter_name=value - No space before or after '='
    Get value (parameter expansion) with $parameter_name

expansion  - see zshparam


Ctrl+/ to undo an expansion

parameter expansion
    $ character introduces parameter/brace expansion
    ${name} - braces are optional


Command Line Movement & Editing {{{1

(Meta = Alt, ^ = Ctrl+ \e = Escape) 

Move 
    word
        forward/back  Mf/Mb


Delete 
    delete to end of line   ^k    
    char 
        left/right ^h/^d	(^d also lists in menu completion)
    word 
        left:       ^w or \e+backspace
        right:      Md or \ed

Stash current line in buffer stack ( push-line), restores after next command
    ESC q

Commands & arguments {{{1

https://www-s.acm.illinois.edu/workshops/zsh/history/hist_expn.html


last argument - repeat to cycle backwards      
	\e. or M-.	    

prev/next command or search for <cmd> if entered
	[<cmd>] M-p / M-n	

	
event[:word][:modifier] (same as bash)

event designators
	!!			last command 
        may omit 2nd ! if followed by :<word selection> or str search
	!str        last command starting with str
	!?str[?]    last command containing str

word designators
    args
    *   all 
    ^   arg
    $   last 
    x-  args from #x to $
    
examples
!!^      first arg of last command
!!*     cmd + all args except last 
!:2         second param

modifier
    :h  strip level

fc:
	fc -m <pat>    edit most recent command matching <pat>
	fc -l -m <pat> display, dont edit



modifiers {{{1

syntax :<letter>
used with globbing and parameter substitution 

usage: 
    parameter substitution - ${param:<mod>}
    globbing - *(:t)  
        may combine with qualifier (U:t)
        e.g. cd to directory of last path argument
            cd !$:h 

flags:
    h  head (dirname)
    t  tail - filename w/o path
    r  rest (extension removed) 
    e  extension
    l/u - convert letters to lower/upper case
    s   substitute :s/old/new

Globbing {{{1

http://zsh.sourceforge.net/Intro/intro_2.html

set all subdirs group writable & setgid
	chmod g+ws **/*(/)
	 zargs **/*(/) -- chmod -R 750 (avoids too long argument error, requires autoload zargs)

read: http://zsh.sunsite.dk/Guide/zshguide05.html#l137

glob operators {{{2
http://zsh.sourceforge.net/Doc/Release/Expansion.html#Filename-Generation

*   matches string of zero or more characters
    does not match /
    matches all files and dirs but not within them

**/<pat> - recursive globbing
	matches <pat> anywhere in path including in top directory

?    any one character


Braces []
    []  any of enclosed characters

    character classes 
        e.g. [:alpha:] [:digit:]

alternatives
    (alt1|alt2)
        no dir / allowed in pat
        (alt1|) alt1 or nothing
negation
    ^<pat>  - matches anything but pat
        negated part extends to end of string or ) but not past /
        **/^pat/tmp	- echo dir names having a tmp subdir
        
    x~y - match x unless also matches y
        grep thing *~*html(.)


Qualifiers {{{2 

select files & directories by time, size, type, ownership, permissions
syntax: <pat>([file type]<one or more qualifiers>)
    

file types
    .	files
    /	dirs
    *	exec
    @	slinks

timestamp 
    type
        a		access
        m		change/modified
    time
        s	second
        h	hour
        day 	(default - no modifier needed)
        week	w
        month	M
    examples
        **/*(.*m-1)  files and scripts with mod times of one day or less
        mw-1 modified within last week
        mw1 Modified more than one week but less than 2 weeks
        mw+1 modified more than one week ago
        *(amh-5) - accessed within the last 5 hours
        cm-5 - changed in last five minutes
        (mM+36) modified more than 3 years ago

	size
		L i.e. length qualifier
			(L[km][+-]<size>)
			*(Lk+10) - larger than 10k
	combining qualifiers
		files are owned by me and less than 5k or not world writable
			*(ULk-5,^W) 
permissions:
    by ownership (u:<owner>)
        *(u0) - owned by root
        *(u:andmalc:) - owned by me
        *(^u:andmalc:) - no owned by me
    by file spec: (f:<spec>:)
        print **/*(f:o+r:) - print files that are other readable - 
        print *(f:gu+w,o-rx:) - files are writeable by owner ('user') and neither readable nor executable by other.
        print *(f700)
    permission shortforms
        f# or f=#	files with access rights = #
        (r), (w) and (x) readable, writeable and executable by the owner
        (R), (W) and (X) as above, for world permissions
        (A), (I) and (E) as above,  for group permissions
        s	setuid files (04000)
        S	setgid files (02000)
        t   files with the sticky bit (01000)


Globbing Flags {{{2

format: (#f)

(#i) - case insensitive matching within pattern
    in effect until end of pattern or as delimited by ()
    WoRDs = Wo((#i)rd)s

Arrays  {{{1

Multiple 'word' parameters.  
spaces separate words
arrayname=(wordone wordtwo)
	$#array   get array size
	$array[n] get index
	$array[5,8] get slice
Make list from directory listing:
	list=(/usr/bin/*)
	list=(/usr/bin/*:
Multiple word 'words': when expanded, e.g
	a=('first word' 'second word')
	cmd $a[0]
	cmd wllget single argument 'first word' - not true in other shells.
Array Bound (Tied) variables - for making PATH type variables: 
	typeset -TU	<SCALER> <array-name>
	upper case form is for exporting to environment, lower case form is
	easier to manipulate in shell.
	U option ensures unique - not adding if already set
		typeset -TU PYTHONPATH pythonpath
		pythonpath=(/lib/python/site-packages lib/python2.2/site-packages)
		
    typeset -U PATH path
    path+=(blah/blah) #appends 
    path=(~/foo "$path[@]") #foo at beginning of array

eg
	${array:gs/foo/bar} substitute foo for bar throughout array
	${list:#pat} list excluding pat
	$var:t  tail of path


Filesystem {{{1

CD stack
	cp file ~1 - copy file to first dir in stack 

Navigation 
    cd to dir with one word different in path (two variations):
        cd <old> <new>
        cd ${PWD/3.4/2.7} 
Processes {{{1
	Process substitution
		( )		makes file
		<( )	makes fifo

Programming {{{1 

Loops {{{2

for file in `ls -lh` ; do
    echo $file
done

for file in **/*(.); do mv $file{,.sh}; done

Delete zero length files
ls -l  **/*(L0) | while read file; do
    rm $file;
done


Startup Files {{{1
	zprofile: 
		only run by login shells (called with -l) or su -.  Use for env vars used by
		applications, e.g. MAI
	zshenv: 
		only startup that is always run.  Best place for environment
	variables
	zshrc
	zlogin: 
		runs after zshrc.  Purpose really just equivalent of Bourne-type
		shells /etc/profile and csh login (?).

Dynamic Prompt {{{1

Built in prompt feature:
    autoload -U promptinit
    promptinit
    prompt 
        -c  current
        -l  list
        -s  save


vim:ft=
