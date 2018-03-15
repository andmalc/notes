Startup {{{
Options

-L <socketname>	
	use to force non-default server, useful for testing config changes
	e.g. tmux -f tmuxtemp -L myapp new-session
-n      name
-c      start dir
-p      split percent


Commands 
    Redraw on bigger screen -d      

Sessions {{{1

Options
    new session         new -s <session name>
    list                list-sessions / ls
    attach to target    attach/a -t <name>
    kill                kill-session -t <name>

$       rename session
()      switch to previous/next session

Browse sessions
    s       list-sessions
            highlight a session with vi or arrow keys.  Right arrow to expand windows
    w       list sessions & windows



Windows {{{1

Options
    create window       -n <name>

Prefix+
    1,2,3   move to window #
    C+n/p     switch to next/previous window
    ,       rename window
    &       kill window

    ?:
    l       last window
    arrow   move to other window or pane
    [       scroll	


move-window
    move within session or to another one
    window id format: [<session name>]:<window #>
    shortcut: .

Panes  {{{1

!       break pane into new window
-|      split vert/horiz
;       last active pane
o		other pane in current window
z       toggle hide other panes (?)
x       kill pane
q       show pane #'s
{}		swap current pane with previous                           

C+o     rotate in circle


resize-pane
    Ctrl + up,down, left, right
    z   zoom
    M+arrow  (rapid for multiple times)

Options
    cmd -t target arg
        client, session, window or pane which a command should affect.

break-pane
    switch current pane into its own window
    shortcut !

join-pane 
    Two windows into 2 panes
    insert a window as a panel in current
    window id format: [<session name>]:<window #>
    -s source pane #     pane to be inserted into current window
    -p percent
    -t target - default: current window
    -b  open window above or to left

split-window into panes 
    split current window or -t # window 
    -v  vert - windows stacked. Default
    -h  horiz - windows side by side
    -b  combine with v or h for active pane to left or above
    shortcuts
        -   split window vertical (modified from ")
        |   split window horizontal (modified from %)



select-layout
    <space>


Layouts {{{2

even-horizontal     left to right
even-vertical       top to bottom
main-horizontal (large pane on top)
main-vertical (large pane on left)


Sessions {{{2
$   rename
s   choose from list


Session Managers {{{1

tmuxp
http://tmuxp.git-pull.com

Copy mode {{{1

Copy:
1. move to start
2. Space
3. move to end
4. Enter

Vi mode movement keys: h,j,k,l

Exit Copy mode: Enter or Esc

w/b     word forward/back
g/G     file top/bottom
/?      search forward/back

Commands
    show-buffer     show current buffer contents
    save-buffer <file>
    capture-pane
    choose-buffer   select a buffer and paste into current pane


Plugins {{{1

tpm manager
    prefix + I/U  install/update plugins

    tmux-resurrect
        prefix + Ctrl-s/r   save/restore

    tmux-continuum
        saves all sessions using tmux-resurrect every fifteen minutes
        auto restore on tmux start
        Option to auto start tmux with systemd

Startup script {{{1

​if​ ! tmux has-session -t development; ​then​
 ​exec tmux new-session -s development -d
​ 	  ​# other setup commands before attaching....​
​ 	​fi​
​ 	exec tmux attach -t development

