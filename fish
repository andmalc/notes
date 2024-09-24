Glob with inverted match
rm -r (string match -v '*.micro' *)

`eval (ssh-agent -c)`

Interactive {{{1

Movement {{{2

^b/^f		move one char back/forward
^d			delete char righ
^e			go to line end
^h			backspace
Ctrl l/r	move one word 
Alt arrows/f	word forward
Shift l/r	move Word, skip punctuation and whole paths

Autosuggestion {{{2

r-arrow, ^f		accept all 

Completion {{{2

tab/shift-tab/^i/arrows
	display & choose completions

Misc {{{2

Alt-s		prepend sudo
Alt e/v	edit command line
Alt h		man page for current cmd
Alt l		ls current dir or dir under cursor
Alt o		page file under cursor
Alt p		page output of cmd under cursor
Alt-.		insert-last arg
Alt Enter	insert newline
Alt BS	delete previous word

^l			clear screen

^-x		copy whole line to sys clipboard
^-y		paste from sys clipboard

Kill ring
	^k			kill to line end
	^w	q		kill prev. word or segment
	Alt d		kill next word
	^y			restore
	^u			kill to line beginning

Clipboard
	^x			copy line to clipboard
	^v			paste (s^v Zellij)

Delete (not Kill)
	Alt BS	delete previous word

History {{{1

^r			recent history search
			repeat for older, ^s for newer
			supports subsequence matches (i.e. mutiple terms) - space between terms not needed
Alt /		history search 
Alt u/d	enhanced searh - how?	
^n/p u/d-arrows 
	search cmd history for entered string

Directory cd history
	dirh		dir history
	cdh		select dir to change to
	nextd/prevd	forward back - (Alt l/r)

history management
	clear
		delete all
	delete <contains pat>
		delete all or some matching pat
	search <glob>
	
	options
		 --reverse - oldest first

	preceed line with space to avoid saving to history

history sessions
	set -x fish_history "session_name"
	set -x fish_history default (i.e. "fish")



# Config {{{1

PATH
	set fish_add_path <paths>

	fish_add_path in config
	https://fishshell.com/docs/current/cmds/fish_add_path.html


# Key bindings {{{1
Customize {{{2

https://fishshell.com/docs/current/cmds/bind.html

fish_key_reader - outputs bind statement for key bind

bind <sequence> <comd>
	Adds bindings using fish_user_key_bindings function
	-f			show function names
	-k <term>	search for existing binding
	-K/--key-names	show special key names

	Spec sequence using escapes + key
		\e		Alt
		\c		Cmd

	bind <seq>
		returns binding for <seq>
	
	bind -k <key-name>
		bind to special key (e.g .F12), not a sequence


man bind
	list of special input names e.g. beginning-of-line

bind \x7F 'backward-kill-bigword'

fish_user_key_bindings function
	can edit to add custom keybinding statements

# Data Types {{{1

All variables are lists of strings
Can interate over and slice

Expand variables
     ~ (tilde) expanded only when unquoted
    Separate from surrounding text {$var} or "$var"

Spaces in var preserved - quotes not needed
    set mydir 'My Docs'
    mkdir $mydir

Undefined var $var or {$var} is an empty list (-q status = 0)
Undefined double quoted var "$var" length is 0

Separate from surrounding text {$var} or "$var"
    If var is not defined or empty list, surrounding text is eliminated

Spaces in var preserved - quotes not needed
    set mydir 'My Docs'
    mkdir $mydir

$$ to reference enclosed var
    set fish trout
    set animals fish
    echo $$animals[1]
    => trout

Array
set myarray a b c
echo $myarray[1]

 Variables {{{1

https://fishshell.com/docs/current/#variables

set
 set <options> <var name> <value>

scope options
	-g		global, unexported (default)
	-U		Universal - Immediately available to all sessions. Saved in fish_variables file
	-l		local within current block and children but not child functions
	-f		current function

how vars operate
	-x		exported 
			default scope is local and exported to child processes
	-gx	exported global 
			use for environment vars in cofig.fish

other options
	-a --append
	-e --erase
	--path
	  treat as path var
	  set -gx --path XDG_DATA_DIRS ~/.local/share/flatpak/exports/share.....


	-q --query <var> ...
		return status = 0 if var initialized, 1 for each not
		set -q var (not $var)
	-S --show
		show var value and status
		set -S <string><TAB>	- shows vars with <string> in name or value
		
	no var or value
		list all vars or limit to var type with scope option
		e.g. show exported global    -xg
	  

# Abbreviations {{{1

word that expands to a phrase when Space pressed

abbr 
	-a	add / save in .config/fish/fish_variables 
    -g  global 
				current session scope
				use in config.fish, e.g. abbr --add --global gpl 'git pull'
	-r	rename
	-e	erase
	-s	show (default)


# Alias {{{1

function that wraps a command
alias
	no-arg	list saved aliases
	-s		save

alias [-s] name 'cmd arg arg'

 function <alias name>
	  <alias command>
 end

Logic (And, Or, Not) {{{1

Operators
	&&, ||, !
	and, or, not - job modifiers - have lower precedence

short circuit - do 2 only if 1 succeeds
    cmd1; and cmd2
ex
   cat nothing; and echo done; or echo 'not done';


Conditionals (If, Else, Switch) {{{1

If, else if, and else don't take a condition but execute code and act based on on its exit status 

if cat thing
  echo found
else
  echo not found
end

Tests {{{1

test command 
	boolean expression, returns 0 for true, 1 for false
	see man test
	invert: not test

	test $myname = andrew
	test (count one two ) -lt 3  => returns 0

	-e		file exists
	-d		directory exits
	-n		true if "$var" expands to non-empty string
	-z		true if empty string
	
	operators
		eq			numeric equivalence
		=/!=	string equivalence

Variable checking: set -q vs test -z
	set -q	return status adds 1 for each arg not initialized
				return 0 means set to value or empty

	set GIT_STATUS (git status --porcelain)
	if set -q $GIT_STATUS ; echo "No changes in repo" ; end
	if test -z "$GIT_STATUS" ; echo "No changes in repo" ; end

is var set (including set to empty string)?
	  set -q myvar  ($ not needed)
is first element of list var set?  Is false if var is not a list.
        set -q var[1]

Other test expressions
	is item in list?
		contains item $list





Functions {{{1

function
	Define a function
		function <func name>
          ...
		end
	options
		erase function from curent session but not function file   
		--erase | -e

funced [--save]
	Edit a function

funcsave <function name>

Show function location      -D <func name>
Show source     functions <func name>

Arguments: $argv list

Exit status of last command $status
    0 = true, 1 = false


Parameter Expansion {{{2

Wildcards
    Any characters including / or empty
        ***
    Any characters including empty but not /
        *
    Any single character 
        ?

set foos *.foo
if count $foos >/dev/null
    ls $foos
end


Command Substitutions {{{2

output of one command as an argument to another

Brace expansion {{{2

A comma separated list of characters enclosed in curly braces will be expanded so each element of the list becomes a new parameter.
    echo input.{c,h,txt}
    # Outputs 'input.c input.h input.txt'


Loops {{{1

For, while

Redirection {{{1

Pipes {{{1

echo hello |
read foo


Other Builtins {{{1

cdh

contains
	test if a word is present in a list
	returns 0 on true, 1 on false

count
    status false if 0

echo
    -n  no newline

exec
read
string
    join
    match <pat> <str>
        -v      inverse - show not matching
    split
test


Plugins {{{1

Fisher and Oh My Fish plugin managers {{{2

Fisher https://github.com/jorgebucaran/fisher
    records installed plugins in fish_config_dir/fish_plugins
    In fish config
        $fisher_path = .local/share/fisher

    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    list
    update


FZF
    environment variablefzf
    launch      Ctrl + T

    With fzf_key_bindings.fish
    Ctrl + T with multi select
    Ctrl + R history
    Alt + C cd into dir

Plugins {{{2

In use {{{3

https://github.com/danhper/fish-fastdir

Not in use {{{3

Virtual Env helper
https://riptutorial.com/python/example/9956/using-virtualenv-with-fish-shell

Nix plugin
    https://github.com/lilyball/nix-env.fish

Bang Bang
    https://github.com/oh-my-fish/plugin-bang-bang
    !! replaced by last command
    !$ replaced by last arg

Session maanger
https://github.com/farzadghanei/fishion


vim:ts=3 sw=3 sts=3 fdm=marker

Fish_config {{{1

fish_config prompt
	show
	choose no-arg or <prompt name>

	
fish_prompt function
	https://fishshell.com/docs/current/cmds/fish_prompt.html#cmd-fish-prompt

fish_config theme
	show				- show all themes
	choose None		- disable all colors
	choose fish default	- track terminal's palatte

Spacefish shell prompt
	https://github.com/matchai/spacefish/

