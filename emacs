
Notation:
	^k = \C=k = control key + k
	M-k = Meta (usually Alt) key + k
	ek = Escape then k

Help
	^h-k		describe key or menu item
	^h-a		apropos
	
App
	C-x C-c		exit Emacs
	M-x kill-emacs	exit w/o saving
	^/, ^x-u	undo
	^xz		redo
	M-x		run command
	C-u #		numeric prefix to cmd

Files
	^x^f		open file
	^x^s		save file
	^x arrows	next/prev buffe

Buffer
	M </>		move to top/end of buffer
	M {/}		move by paragraph
	M-gg #		move to line #	
	^xk		close file
	^x^b		list buffers in other window

Scroll
	M-r		vertical centre point 
	M-v/C-v,Pgup/Pgdown	scroll up/down

Windows
	C-x 
		0		delete win
		1		delete other wins
		2		split win below
		3		split win right
		o		switch to other win


char
	^f/^b		move one char forward/back
	^d		delete char under cursor
	BS		delete to left

word
	M-f,M-b,arrows	move word forward/back
	M-d, ^DEL		delete next word
	M-BS		kill last word | delete word to left


line
	^a		beginning of line
	M-m		beginning of line non-whitespace
	^e		end of line
	^j		insert line above
	^n		move line down
	^p		move line up/previous
	^o		insert RET, no auto indent
	^x,o		delete all but one consecutive blank lines

	kill
		^k  		kill line to right, repeat to join line with next
		^u		kill line left
		^y		yank back previous kill
		^k  		kill line to right, repeat to join line with next

Indenting
	

		
Editing
	^SPC		set mark
	M-w		copy

history
	^r	search past history
		repeat for additional matches

Lisp
	M-:	eval exp

	Scratch buffer
		enter List exp
		pointer after closing braket
		^j

Customization
	customize-group