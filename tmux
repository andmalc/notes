Startup {{{
Options

-L <socketname>	
	use to force non-default server, useful for testing config changes
	e.g. tmux -f tmuxtemp -L myapp new-session
-n      name
-c      start dir
-p      split percent


Commands 
	new-session             -s
    attach to target        -a -t
    Redraw on bigger screen -d      


Key Bindings {{{2

Windows {{{2
l       last window
n/p     switch to next/previous window
arrow   move to other window or pane
,       rename window
&       kill window
[       scroll	
w       list windows

join-pane -s # -t #		Two windows into 2 panes

Panes  {{{2
|       split window horizontal (modified from %)
-		split window vertical (modified from ")
;       last active pane
o		other pane in current window
z       toggle hide other panes (?)
x       kill pane
q       show pane #'s
{}			swap pane                           
!       break pane into new window
M+arrow resize (rapid for multiple times)

Layouts {{{2

even-horizontal     left to right
even-vertical       top to bottom
main-horizontal (large pane on top)
main-vertical (large pane on left)


Sessions {{{2
$   rename
s   choose from list


