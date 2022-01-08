
General {{{1

Articles on tmux config
http://deanbodenham.com/learn/home.html

Colour chart
https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg


Setting options
set / set-option option value
    -g  global
    -w  window
    -s  session
    -u  unset

Show current settings
tmux show-options -g


Startup Options
-n      name
-c      start dir
-p      split percent
-f	config file


Sockets & Sessions Startup {{{1

Start with new socket
    tmux -L tmuxtest 

Session startups
    new session         new -s <session name>
    list                list-sessions / ls
    attach to target    attach/a -t <name>
    kill                kill-session -t <name>

    Attach to named session or create
        tmux new-session -A -c ~ -s sql

Select and manage sessions
    s       list-sessions
            highlight a session with vi or arrow keys.  Right arrow to expand windows
    w       list sessions & windows
    ()      switch to previous/next session
    $       rename session

Session Managers 
    tmuxp http://tmuxp.git-pull.com
        save and load configs


Misc {{{1

=   Choose which buffer to paste


Windows {{{1

,       rename window
&       kill window
?:
[       scroll	

Switch/Move windows
    arrow   move to other window or pane
    l (or | ?)      last window
    1,2,3   move to window #
    n/p     switch to next/previous window
    w       choose window interactively

move-window
    move within session or to another one
    window id format: [<session name>]:<window #>
    shortcut: .

Options
    create window       -n <name>


Panes  {{{1
o         Select the next pane in the current window (?)
-|      split-window: create new pane from vert/horiz split
x       kill pane
q       show pane #'s
{}		swap current pane with previous                           

Switch/Move panes
!       break-pane: move current pane into new window
;       last active pane
o	other pane in current window
z       toggle hide other panes 
C+o     rotate panes clockwise. Pane numbers do not change.

Options for following commands
    -v  vert - windows stacked. Default
    -h  horiz - windows side by side
    -b  combine with v or h for current pane to right or above
    -d  remain in current window

break-pane
    change current pane into new window

display-panes
	show pane #'s
	shortcut q

split-window - really split pane 
    split current window or -t # window into panes
    shortcuts
        -   split window vertical (modified from ")
        |   split window horizontal (modified from %)
        " Split horizontally (?)
        % Split vertially (?)

join-pane
    Merge two windows into 2 panes
    Reverse with break-pane
    window id format: [<session name>]:<window #>
    -s source - window to be inserted into target
    -t target - default: current window
    -b  open window above or to left
    -p percent

    join-pane -s # -h -p 40


resize-pane
    z   zoom
    Ctrl + arrow
    M+arrow  (rapid for 5 times)

swap-pane -DU [-s src]
    -U  numerically previous pane (show #'s with q)
    -D  numerically following pane


Layouts {{{2

even-horizontal     left to right
even-vertical       top to bottom
main-horizontal (large pane on top)
main-vertical (large pane on left)

select-layout  main-horizontal

rotate through layouts
    <space>

Sessions {{{2
$   rename
s   choose from list



Copy mode {{{1

Copy:
Enter copy mode: <prefix>+[
Emacs mode:
    Start copy: Ctrl <Space>
Vi mode
    Start copy: <Space>
Copy text: <Enter>
Paste text: <prefix>+]

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

Key Bindings {{{1

? or list-keys [-T <keymap>]


Plugins {{{1

tpm manager
    prefix + I/U  install/update plugins

    tmux-resurrect
        prefix + Ctrl-s/r   save/restore

    tmux-continuum
        saves all sessions using tmux-resurrect every fifteen minutes
        auto restore on tmux start
        Option to auto start tmux with systemd

Debugging {{{1

tmux -f <config file>
    still reads .tmux.conf

tmux show-options [-g -w]

tmux source-file ~/.tmux.conf

Verbose logging
    -v

Force non-default server, useful for testing config changes
	tmu -L <socketname>	
	tmux -f testconfig -L testsocket new-session


Startup script {{{1

​if​ ! tmux has-session -t development; ​then​
 ​exec tmux new-session -s development -d
​ 	  ​# other setup commands before attaching....​
​ 	​fi​
​ 	exec tmux attach -t development

