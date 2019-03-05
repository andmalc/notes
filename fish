
Tab Completion {{{1
    Accept      
        all         Ctrl + F
        one word    Alt right arrow

Variables {{{1

All variables are lists of strings
Can interate over and slice

set
    set <options> <var name> <value>
        set -U EDITOR vim
    options
        --append, --prepend
        -U var
            Universal variable - saved in config
    info
        list all vars           <no arg>
        show debugging info     --show
        show exported global    -xg

Abbreviations
    word that expands to a phrase
    abbr -a gco git checkout
    abbr -a l less


Variable expansion {{{1


Undefined var $var or {$var} is null
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

#Test for empty list
set files **filenames*
if count $files >/dev/null
    ls $files
end


Tests {{{1
compare strings or numbers or check file properties (whether a file exists or is writeable etc.

See man test

True if var set
    set -q var (not $var)

Double quote var with test
    test -z "$XDG_DATA_HOME"

Functions {{{1

Edit        funced [--save]
Save        funcsave <function name>

List defined    functions   
Show source     functions <func name>

Arguments: $argv list

Alias
    function that wraps a command:
    alias --save ga='git add'`

Exit status of last command     $status

Show argument of last command
    Esc .


Parameter Expansion {{{1
Wildcards {{{2

Any characters including / or empty
    **
Any characters including empty but not /
    *
Any single character 
    ?

Recursive hidden file 
     ls -a **/\.blah*

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

Enumerate items in an arry
    set foo a b c
    for i in (seq (count $foo))


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
    counts number of arguments
    status false if 0
exec
read
string
    split
    join
    length
test


Plugins {{{1

Fisher plugin manager

fzf
    launch      Ctrl + T

    With fzf_key_bindings.fish
    Ctrl + T with multi select
    Ctrl + R history
    Alt + C cd into dir


SSH agent launcher
https://github.com/danhper/fish-ssh-agent

Virtual Env helper
https://riptutorial.com/python/example/9956/using-virtualenv-with-fish-shell

Examples {{{1

read -x lines < remove.txt
set -x MY_VARIABLE (head -1 hello.txt)

for l in (cat remove.txt )
   echo (string match -r "[[:alpha:]]+" $l)
end


