
Notation:
	^k = \C=k = control key + k
	M-k = Meta (usually Alt) key + k
	ek = Escape then k

App
	C-x C-c		exit Emacs
	M-x kill-emacs	exit w/o saving
	^/, ^x-u	undo

Files
	^x,f	open file
	^x,s	save file

char
	^f/^b	move one char forward/back
	^d	delete char to right
	BS	delete to left

word
	M-f / right arrow	move word forward
	M-b	/ left arrow	move word back
	M-d	delete word to right
	M-BS	kill last word | delete word to left
	^DEL	delete word to right

line
	^a	beginning of line
	^e	end of line
	^u	kill line left
	^k  kill line to right, repeat to join line with next
	^y	yank back previous kill
	^n	move line down
	^p	move line up/previous
	^o	insert blank line below
	^x,o	delete all but one consecutive blank lines

history
	^r	search past history
		repeat for additional matches

Buffer
	M </>		move to top/end of buffer
	M-r/C-r	/Pg up/down		scroll up/down
	M-gg #		move to line #	


Windows
	C-x 
		0		delete win
		1		delete other wins
		2		split win below
		3		split win right
	
	M
		r		vertical centre point 

