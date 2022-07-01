
https://developerlife.com/2021/01/19/fish-scripting-manual/


`eval (ssh-agent -c)`

Kill ring
	Ctrl K	kill to line end
	Ctrl Y	restore line
	Alt Y		restores more from history


# History {{{1

Insert previous last arg: Alt up

History file location: ~/.local/share/fish/fish_history

History
    <term>+ Alt u/d     search history for term in command

history - shows events newest first
	clear
		delete all
	delete <contains pat>
		delete all or some matching pat
	search <glob>
	
	options
		 --reverse - oldest first

	history sessions
		set -x fish_history "session_name"
		set -x fish_history default (i.e. "fish")

    cdh                 dir history list


# Config {{{1


First time setup 
	cp /usr/share/fish/config.fish ~/.config/fish

PATH
    set fish_user_paths <paths>

## Keybinding {{{2

Key Bindings
https://fishshell.com/docs/current/cmds/bind.html

fish_key_reader - outputs bind statement for key bind
	-k <term>	search for existing binding
	-K		show special key names

bind cmd
	bind <sequence> <comd>
	Adds bindings using fish_user_key_bindings function

	Spec sequence using escapes + key
		\e		Alt
		\c		Cmd

man bind
	list of special input names e.g. beginning-of-line

bind \x7F 'backward-kill-bigword'

# Ctrl H = backspace
bind \b backward-delete-char 


# Tab Completion {{{1

Accept      
	all         Ctrl + F
	one word    Alt right arrow


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

# Variables {{{1

https://fishshell.com/docs/current/#variables

set
 set <options> <var name> <value>

 options
	 -a --append
	 --path
		  treat as path var
		  set -gx --path XDG_DATA_DIRS ~/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

	-q --query <var> ...
		return status = 0 if var initialized, 1 for each not
		set -q var (not $var)

	-x  exported 
		default scope is local and exported to child processes

	scope options
		-g  global outside block.  This is default outside function or block
		-U Universal - saved in fish_variables file
		-l  local within current block and children but not child functions
		-gx exported global 
			use for environment vars in cofig.fish

	var name but not value
		show var value

	no var or value
		list all vars or limit to var type with scope option
		e.g. show exported global    -xg
        
PATH
	fish_add_path in config
	https://fishshell.com/docs/current/cmds/fish_add_path.html

# Abbreviations {{{1

word that expands to a phrase
are universal variables saved in .config/fish/fish_variables 

abbr -a	add
    -U  universal auto-saved in config (default)
    -g  global 
				current session but not saved
				use in config.fish
	-r	rename
	-e	erase
	-s	show

Config.fish example (usually not needed)
    if status --is-interactive
        abbr --add --global first 'echo my first abbreviation'
        abbr --add --global second 'echo my second abbreviation'
        abbr --add --global gco git checkout
        # etcetera
    end

# Alias {{{1

function that wraps a command

    function <alias name>
        <alias command>
    end

Create alias=name           alias [--save]

Exit status of last command $status
    0 = true, 1 = false


Arguments: $argv list

Combiners (And, Or, Not) {{{1

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

Virtual Env helper
https://riptutorial.com/python/example/9956/using-virtualenv-with-fish-shell

Spacefish shell prompt
	https://github.com/matchai/spacefish/

Nix plugin
    https://github.com/lilyball/nix-env.fish


Bang Bang
    https://github.com/oh-my-fish/plugin-bang-bang
    !! replaced by last command
    !$ replaced by last arg

Session maanger
https://github.com/farzadghanei/fishion


vim:ts=3 sw=3 sts=3 fdm=marker
