
Tab Completion {{{1
    Accept      
        all         Ctrl + F
        one word    Alt right arrow

Variables {{{1

All variables are lists of strings
Can interate over and slice

set
    --append, --prepend
    --show
    -U var
        Universal variable - saved in config



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

True if var set
    set -q var (not $var)

Double quote var with test
    test -z "$XDG_DATA_HOME"

Functions {{{1

Create alias=name           alias [--save]
Edit function               funced [--save]
Save interactive func to file   funcsave <function name>

List defined functions      functions   
Show function source        functions <func name>

Exit status of last command     $status

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

Variable expansion {{{1

Expand $var
Separate from surrounding text {$var} or "$var"

Spaces in var preserved - quotes not needed
    set mydir 'My Docs'
    mkdir $mydir

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
exec
read
string
    split
    join
test


Plugins {{{1

SSH agent launcher
https://github.com/danhper/fish-ssh-agent


Virtual Env helper
https://riptutorial.com/python/example/9956/using-virtualenv-with-fish-shell
