
Config keyboard and kbmaps
https://docs.fedoraproject.org/en-US/fedora/rawhide/system-administrators-guide/basic-system-configuration/System_Locale_and_Keyboard_Configuration/
https://wiki.archlinux.org/index.php/Linux_console/Keyboard_configuration
https://blog.stigok.com/2020/10/27/from-x11-xmodmap-to-wayland-xkb-custom-keyboard-layout.html
https://wiki.archlinux.org/title/Sway#Keymap
https://github.com/swaywm/sway/wiki/Shortcut-handling
https://sw.kovidgoyal.net/kitty/faq.html#how-can-i-assign-a-single-global-shortcut-to-bring-up-the-kitty-terminal

Utils 

load keyboard translation tables
	loadkeys


### kitty
kitty +kitten show_key
	key code output for 'send_text'

 kitty --debug-input
	use 'native_code' with map
	`map ctrl+0x61 something`

Backspace cannot be used in combination with other keys
	https://github.com/fish-shell/fish-shell/issues/3730

Modifiers
	Terminal apps: only Ctrl and Alt available
	Multiple mods: only Shift Alt and Ctrl Alt are reliable
	No reliable way to distinguish single Esc press from strt of escape seq
	
	
Alt escape \e
	is case sensitive

Control escape \e
	not case sensitive




Chromebook - map Delete to  Right Alt + BS
Edit /usr/share/X11/xkb/symbols/us, and right after the line:
    name[Group1]= "English (US)";
add these lines:
    include "level3(ralt_switch)"
    key <BKSP> { [ BackSpace, BackSpace, Delete ] };

