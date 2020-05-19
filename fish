eval (ssh-agent -c)

Tab Completion {{{1
    Accept      
        all         Ctrl + F
        one word    Alt right arrow

Data Types {{{1

Array
set myarray a b c
echo $myarray[1]


Variables {{{1

All variables are lists of strings
Can interate over and slice

set
    set <options> <var name> <value>
        set -U EDITOR vim
    scope options
        -l  local within current block and children but not
            child functions
        -g  global outside block
        -x  local and exported to child processes but not global
        -U var
            Universal - saved in config

    info
        list all vars           <no arg>
        show debugging info     --show
        show exported global    -xg


Expand $var
Separate from surrounding text {$var} or "$var"

Spaces in var preserved - quotes not needed
    set mydir 'My Docs'
    mkdir $mydir

Undefined var $var or {$var} is null
Undefined double quoted var "$var" length is 0

$status = 0 if var set, = 1 not set
    set -q var (not $var)

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


PATH
    set -U fish_user_paths <paths>

Abbreviations {{{1

word that expands to a phrase
are universal variables saved in .config/fish/fish_variables 

add     -a
rename  -r
erase   -e
show    -s (default)

abbr -a gco git checkout
abbr -a l less


Combiners (And, Or, Not) {{{1

&&, ||, !
and, or, not - job modifiers - have lower precedence

short circuit - do 2 only if 1 succeeds
    cmd1; and cmd2
ex
   cat nothing; and echo done; or echo 'not done';


Conditionals (If, Else, Switch) {{{1
     if, else if, and else to conditionally execute code, based on the exit status of a command

if cat thing
  echo found
else
  echo not found
end

Tests {{{1
compare strings or numbers or check file properties (whether a file exists or is writeable etc.

See man test

Double quote var with test
    test -z "$XDG_DATA_HOME"

Functions {{{1

Define      function <func name>
                ...
            end

Edit        funced [--save]
Save        funcsave <function name>
            functions <func name> > ~/.config/fish/functions
Erase function from curent session but not function file   --erase | -e
List        functions   
Show function location      -D <func name>
Show source     functions <func name>

Arguments: $argv list

Alias {{{1

function that wraps a command

    function <alias name>
        <alias command>
    end

Create alias=name           alias [--save]

Exit status of last command $status
    0 = true, 1 = false


Arguments: $argv list


Parameter Expansion {{{1
Wildcards {{{2

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


History {{{1

history - shows events newest first
    --reverse - oldest first
    search <glob>

Other Builtins {{{1

cdh
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

Fisher and Oh My Fish plugin managers


fzf
    launch      Ctrl + T

    With fzf_key_bindings.fish
    Ctrl + T with multi select
    Ctrl + R history
    Alt + C cd into dir



Virtual Env helper
https://riptutorial.com/python/example/9956/using-virtualenv-with-fish-shell

Spacefish shell prompt
	https://github.com/matchai/spacefish/

