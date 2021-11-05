Ed {{{1

Start with asterik for command prompt
     ed -p\*

Format:
    <line or range selection><command>

Range selection
    current line:       .
    end of buffer       $
    Range of lines:     #,#
    Entire buffer:      ,/%/1,$
    Relative            +# -#
    Regex               g/pat/
                        v/pat/  inverted


Editor commands
longer error mgs    H
append              a / exit with .
change              c
copy                t
delete              d
join lines          j
mark                k
mark referal        '
move                m
read file           r
read overwriting 
    existing        e
substitute          s
print               p
print with line #   n
write/append to file w/W

read output of command
    r !ps -e


Regex selection + command
    g/pat/m$
    s/old/new

    with sufixes
    p   print
    g   match all on line
    m#  move matched line to line #

Search forward/back / ?


Docs 

https://www.ibm.com/developerworks/linux/library/l-awk1/index.html?ca=drs-
Basics cat /etc/passwd | awk -F: {print $1,$3,$5}


Options
    -F "x"  field separator, can be a regex

<conditional expression> {action}
Peform action on all lines that eval to true
If just pattern, prints all matching lines
If just action, acts on lines
$# in action is field #


Expressions preceeding blocks {{{1

If true, action in block is executed

Regex /<pat>/
    uses extended regex like egrep
    matches on any part of a field

Boolean expressions

With comparison operators -  "==", "<", ">", "<=", ">=", and "!="
    $6 == "November" #equals

Match operators, used with regexes
    $1 ~ /Blah/     #matches 
    $1 !~ /Blah/     #does not match

Null field
	!$<field #>

Strings {{{1

String contants in double quotes

Regex Metacharacters

Variables {{{1

auto set:
NF 	number of fields
NR	number of records
	use to start processing at # of lines down

manual set:
FS	field separator
RS	record separator - for mulit line records
	use with FS="\"
	RS="" for blank line
OFS output field separator. Default chars to insert in print
ORS output record separtor. Defaults to \n




Scripts {{{1

BEGIN block
    commands run before processing of lines 


If statement

{ 
  if ( $1 == "foo" ) { 
           if ( $2 == "foo" ) { 
                    print "uno" 
           } else { 
                    print "one" 
           } 
  } else if ($1 == "bar" ) { 
           print "two" 
  } else { 
           print "three" 
  } 
}

Boolean operator statement
|| - OR
&& - AND

( $1 == "foo" ) && ( $2 == "bar" ) { print }


