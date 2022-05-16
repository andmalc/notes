
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
	^x l/r arrows	next/prev buffe

Buffer
	M </>		move to top/end of buffer
	C-Home/End
	M-gg #		move to line #	
	^xk		close file
	^x^b		list buffers in other window

Windows
    C-x
	0		delete win
  	1		delete other wins
  	2		split win below
	3		split win right
	o		switch to other win

Editing
	^SPC / ^@	set mark
	^SPC ^SPC	set mark then deactivate it
	^u ^SPC		jump to mark
	M-@		select following word, point remains at beginning
	
	^x^x		select to previous mark
	
	M-w		copy/kill-region-save
	^w		cut/kill-region
	^x^u		upper case region

Scroll
	M-r		vertical centre point 
	M-v/C-v,Pgup/Pgdown	scrolls content down/up
	^l		scrolls to vertically centre point
			repeat to move point to top & bottom

char
	^f/^b		move one char forward/back
	^d		delete char under cursor
	BS		delete to left

word
	M-f,M-b,arrows	move to after next word
	M-d, ^DEL		delete next word
	M-BS		delete word to left


line
	^a		beginning of line
	^e		end of line
	^j		insert line above
	^n		move line down
	^p		move line up/previous
	^o		insert line after point
	^x^o		delete all but one consecutive blank lines

	kill
		^k  		kill line to right, repeat to join line with next
		^u		kill line left
		^y		yank back previous kill
		^k  		kill line to right, repeat to join line with next

Indented Lines
	M-m		move to beginning of line non-whitespace

Sentence
	M-A/E		beginning/end of a sentence or if none beg/end of paragraph

Paragraph
	M {/}		move to first blank line after/before current paragraph
	M-h		select para including preceeding blank line, point to beginning
	M-q		join lines in paragraph and wrap

history
	^r	search past history
		repeat for additional matches

Lisp
	M-:	eval exppression or return variable value
	M-x	run command
		to search for cmd, enter term + tab
	
	List source file *.el
	     eval   C-x C-e

	Scratch buffer
		enter List exp
		pointer after closing braket
		^j

	Set variables
		M-x set-variable RET
			shorter than M-: (setq myvara val)

Customization cmds (M-x)
	^x^s to save
	customize-group
		select settings category
	customize-theme
