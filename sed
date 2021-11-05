
Docs
	O'Reilly book
		http://www.unix.org.ua/orelly/unix/sedawk/index.htm

    Processing a csv file
        https://blog.theodo.fr/2018/03/regex-warrior/


Basic sed operatation: 
$ sed "s/<string to replace>/<string to replace it with>/g" <source_file> > <target_file>.

options:
	read each line of input 
	each line in turn becomes the current line.  
	lines matched by address 
		instructions applied
	unlike editors like ed & vi, addressing is implicitly global


OPTIONS
	-n	Suppresses auto output of input lines.  
		Each instruction intended to produce output must include a 'p' command, e.g.
			s/a/b/p

	-e		script follows
			instruction separator on command line e.g.:
				sed -e 's/a/b/' -e 's/c/d/' file	
			or terminate with ;
				sed 's/a/b/; s/b/c/' file
			or enter instructions with CR's between quotes in shell line editor

	-f		script file arg

	-F (awk)	Field separator e.g. -F, (comma as FS)

    -r  extended regex

	p	Print, if substitution made
	w	Write to named file if substitution made
	g	Apply repl to all matches of reg, not just first

line addressing

	sed
		,[cmd]...
			alias for global line matching
		code blocks enclosing one or more procedure statements
			start with brace '{' at the end of the line 
			end is a close brace '}' on a line by itself:
				/pat/,/pat/ {
				/pat/p
				s/pat/rep/
				}

COMMAND FORMAT

Under Windows, pats including a < or > must be double quoted

statement separators 
	may be any character although slashes in pats must still be escaped.
	Alternative Separator syntax	 \%reg%

Case insensitive flag:	I	eg /reg/pI

metacharacters

	Sed & Awk differences:
		Sed: ^ and & are metachars only at start and end of a regex.  
		Awk: ^ and & are metachars everywhere unless escaped.

	Test sed output:
		Run 'diff' on input & output files to see changes 

	basic
		.	any char except newline
			awk: can include newline

		^/$	first/last char in line
			awk: first/last char in string
			python: in multiline mode, also matches after new line

	extended (awk and egrep)
		+	one or more of precedding
		?	zero or one "
		|	alternation (either preceeding or following match)
		{n}, {n,}, {n,m}
			exactly, at least, between n & m chars
			basic - escape braces
	
	character classes
		^	reverse match when in 1st position
		\	escape any special character (awk only)
		-	indictes a range when not in 1st or last position

		
	replacement metacharacters
		\		Newline.  Must be last char in line.  See O'Reilley  p 83
		&		Extent of pattern (not line that was matched)


.EXAMPLES

/reg/s/lhs/rhs/		For first line matching reg, sub lhs for rhs
g/reg/s/lhs/rhs/	For all lines matching reg, sub lhs for rhs

/reg/s//rhs/		reg and lhs are the same

A sed filter and print command.  More explicit syntax is 'g/Toronto/p'
sed -n '/Toronto/p' list		

Pipe:
echo Test String |
sed -e 's/a/b/' |
sed -e 's/T/Z/'

Here doc:
sed -e 's/a/b' <<+
Test String
+

Zsh 'here string' & std out to file
>outfile sed -e 's/a/b/' <<< 'Test string'


Given line:
sssss XXXXX

Following will break above across two lines:
{s/\(s*\) \(X*\)/\1 \
\2/
}

Delete the 'NOSPAM':
mailto: `echo NniOtroS@aPpcAi.nMet  | sed 's/[NOSPAM]//g'`

vim: ts=4
