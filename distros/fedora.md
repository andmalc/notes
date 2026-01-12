# vim:fileencoding=utf-8:ft=conf:foldmethod=marker

Console switch on Thinkpad: Fn + Ctrl + Alt + #

Install options & disk space {{{1

Fedora 35 {{{2

standard install: disk size 3.5G but almost 8G after update
Everything 
	"Minimal Install" with Admin tools & Standard selected = 900M
	gnome-shell (basic Gnome w/o apps)  = 730M
	gdm - pulls in Gmome Control Centre + power management ? = 300M
	Sway 280M
	Total install with 
		Gnome & Firefox < 2G
		Gnome & Firefox flatpak (org.fedoraproject.Platform runtime)  3.2G

Clear disk space
	journalctl --vacuum-time=2d
	dnf system-upgrade clean


Silverblue  - approx 9GB
Fedora IoT <4G

Installation groups
	basic-desktop-environment - installs Awesome, Blackbox, Ratpoison, and XMona
    
Pop_OS 21.10 {{{2

5.7GB with Freedesktop flatpak runtime and removing libreoffice

Used after 1 year
	/	13.5G
	/home	11.5G
	/boot/efi	300M



sway + Gnome Terminal + gdm ?
Minimal needs wpa_supplicant + NetworkManager-wifi rpms for wireless

Boot and EFI partition sizes {{{2

Fedora
	/boot	300M, 150M on Silverblue
	/efi	<20M

Alternate install {{{2

Install into mounted partition
dnf --installroot=/mnt/drive --releasever=28 install basesystem passwd systemd dnf
install bootloader ?

Fedora upgrade {{{1

fedora-upgrade --upgrade-to=39


Free up space {{{1

Packages to remove
	libreoffice\* (700M)
	cups-client (removes all printing)

Locales
    localectl - verify is en_US
    delete all folders in /usr/share/locale except for en_US

Clear dnf cache in /var/cache/PackageKit
    pkcon refresh force


Config {{{1

Enable graphical session
	systemctl enable gdm.service
	systemctl set-default graphical.target

Environment vars in ~/.config/environment.d

Visudo editor
	Add to sudoers Defaults env_keep += "EDITOR"
	Run visudo as sudo -E svisudo


gpg
    ensure pinentry installed
    set home dir:
         set -x --path GNUPGHOME ~/.config/gnupg

wl-clipboard  - clipbord tool for Wayland
    https://github.com/bugaevc/wl-clipboard

Yubikey/U2F support
	pam-2uf u2f-hidraw-policy

Ibus shorcut (Super + period) disable: ibus-setup


Users {{{1

Show user info
    lslogins

Add user
	useradd -G grp username 

Change user group
	usermod -a -G grp username

Change shell
	chsh -s <shell path>
		sudo chsh -s /usr/bin/fish

	lchsh <user> - said more secure than chsh
	
	not installed by default: pkg: util-linux-user
	usermod -s <shell path> username


adm for journalctl 

Setup new VPS {{{1

Have root password
scp id_ecdsa and id_ecdsa.pub to root home dir on server.
ssh into server as root.
Create .ssh dir
Move in id* files, chmod dir 500 and files 400.
Copy id_ecdsa.pub to authorized_keys

Create andmalc user with useradd -G wheel
Visudo and enable passwordless sudo for wheel

Copy .ssh dir to andmalc
If necessary, fix permissions and restorecon -R -v /andmalc/.ssh

sudo dnf install -y git stow micro tmux fish vim 
# vim:fileencoding=utf-8:ft=conf:foldmethod=marker

eval `ssh-agent`
ssh-add .ssh/id_ecdsa

git clone --recursive git@github.com:andmalc/config.git




Home Dir {{{1


git clone git@github.com:andmalc/config.git

Fedora setup Ansible Playbook
https://github.com/flavienbonvin/ansible-fedora-configuration

gnupg & ssh dirs
- mod 700

.ssh dir
	restorecon -R -v /root/.ssh

Pull Notes, Config, Work
git@github.com:andmalc/config.git

git clone --recursive config # populates submodules
git clone --recursive work
git clone notes

Or:
submodule init / submodule update


Use Stow
/usr/bin/stow -t ~ -d config/dotfiles vim

cd config/dotfiles
for p in *; do stow -t ~ $p ; done;

or symlinks
ln -s 
config/prog/Envs/postactivate Envs
config/prog/Envs/postdeactivate Envs

Vim:
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
BundleInstall

Tmux
While running, Leader + I to install plugins


SSH config {{{3

SSH dir
- mod 700
- authorized_keys file


ssh-agent + ed25519 keys:
https://eklitzke.org/using-ssh-agent-and-ed25519-keys-on-gnome


System config {{{2

Locale
    localectl 
       list-locales 
       set-locale LANG=locale

Console
    Ctr+ Alt 2

    font settings
	fonts in /usr/lib/kdb/consolefonts
        /etc/vconsole.conf
	suggested fonts:
		ter-28v
		large font: FONT="latarcyrheb-sun32.psfu.gz"


Date/time
	timedatectl
         timedatectl set-timezone America/Toronto

/etc/gdm/custom.conf
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=andmalc

/etc/systemd/journald.conf
SystemMaxUse=   max disk usage

DNS with systemd-resolved
	configure /etc/systemd/resolved.conf
	Enable systemd-resolved
	symlinmk /etc/resolve.conf to /run/systemd/resolve/stub-resolv.conf
	verify with resolvectl status

Hardware config {{{2

tuned - power management
Add to profile conf
[disk]
alpm=min-power


Input devices: keyboard, mouse, touchpad via Libinput
https://www.mankier.com/4/libinput#Note
Hotplug or manual config in /etc/X/xorg.d/


Touchpad / Clickpad troubleshooting
xinput --list
xinput list-props <device #>
gsettings list-recursively  | grep touchpad



Packages {{{1

dnf group install  "C Development Tools and Libraries"


Desktop {{{1

Fonts:
Monospaced:
* hack-fonts
* levien-inconsolata-fonts
* adobe-source-code-pro-fonts
mozilla-fira-mono-fonts
dejavu-sans-mono-fonts

Gnome {{{2

Gnome Settings pkg: gnome-control-center

Tap to click
sudo gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click 'true'

Solid backgrond color
gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.desktop.background primary-color '#HEX'

Wayland {{{2

Restart Wayland from cmd:   fuser -k $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY


Dnf {{{1
General {{{2

Dnf <options> <command> <args eg. package spec>
    
Pkg spec:
	case insensitive
	match on whole package name, full path, or path with wildcard prefix *\

Options:
    --exclude <pkg or pat>  exclude from install, remove, list etc.
    --releasever 23
    --installroot=<path>
        dnf --installroot=<installroot> --releasever=<release> install system-release

    Temporarily enable/disable a repo
    --enablerepo <repo>     install pkg from a repo
        --enablerepo=updates-testing fish
    --disable <repo>

Commands {{{2
    
autoclean   remove orphans

history
	list [<pkg>] (default cmd)
	undo, redo
	1..20   show last 20 events
	upgrade <pkg>       avail upgrades for pkg
	userinstalled       manually installed pkgs
    undo
    rollback

info [installed | available]   
	shows pkg details

in|install, reinstall, rm|remove, downgrade <pkg spec> | <provide spec> | <@Group name>
	if /path/file given, acts like provides and installs pkg that provides file

list | ls [installed | available | recent] [<pkg spec>]
	shows name, version, repo, install status
	no pkg summary
	if no arg, lists installed then avail packages
	does not sync metadata
	see also repoquery plugin

search | se [--all | all] <name or glob>
	packages matching any pattern
	result sectioned by closeness of match (closest at end?)
	no installation info.  Use list instead
	'all' searches name & description


provides | wp [installed | available] <file name, cmd, or description keywords>
	shows extended info - all pkg versions and related pkgs


repoquery | rq [<select-options>] [<query-options>] [<pkg-spec>]
	search repos packages or files matching provided file or command 
	no arg output is repo name, pkg name and version 
	Faster than 'dnf provides'
	Pipe to grep for regex pattern matching:  dnf rq | grep "^nu-.*"

	fedora-repoquery package - new util, faster, more intelligent searching - priorities matching patterns at start of package name 
	fedora-repoquery-short - frpq alias
	Usage examples: https://github.com/juhp/fedora-repoquery#readme


Options {{{2

Install options
	--setopt=install_weak_deps=False	# don't install weak dependencies

Query options - set what info displayed about each pkg
	-l <pkg name>   list files in package
	--depends
	-i              info
	--provides      pkgs providing service/cmd
	--recommends
	--requires <pkg>  #  show package dependencies (required by this pkg)

Select options - limit output set 
	--installed
	--repo <repoid>
	--file/-f   list packages providing a file
	--upgrades  # pkgs providing upgrades to existing

	Capability arg, e.g. webserver
	--whatdepends <capability> # pkgs that depend on this one
	--whatprovides <capability>
		same as 'dnf provides'?
	--whatrecommends <capability>
	--whatrequires <capability>  # pkgs requiring this one
	--whatsuggests <capability>

	Show recursive dependencies
		dnf repoquery --requires nginx --resolve --recursive

Output group names:
	--groupmember list groups containing spec


	Examples {{{2
	dnf repoquery --installed kitty\* #pkg name pattern 
	dnf rq -f \*<filename pat> #find package(s) by file

upgrade <pkg spec>
up|update      is alias to upgrade
upgrade-minimal
	Updates each package to the latest version that provides 
	bugfix, enhancement or fix for security issue 


Package Groups {{{2

group info, list, install 
group name
	case insensitive
	format: 'Fedora Blah' fedora-blah @fedora-blah (don't need 'group' in cmd)

Show packages in a group
	group info 'Basic Desktop'


Dnf Examples {{{2

Find package name from file
	dnf wp <any file in package #faster, more info displayed, globbing file name not needed
	dnf rq  --file/-f <any file in package>

List files in package
	dnf rq -l <pkg name> => lists all files in pkg


Show which packages require installed one specified 
	dnf rq  --installed --whatrequires <pkg>
	fedora-repoquery -- --whatrequires pandoc  ('--' needed if release arg ommited)


Cache management {{{2

    autoremove  uninstall orphan pkgs
    clean all   clear package cache

Run dnf without checking cache: -C --cacheonly

Plugins {{{2
http://dnf-plugins-core.readthedocs.org/en/latest/index.html

    provides <path to fn>
        shows which packages provide a file 
        can use glob instead of exact path
            dnf provides '*/semanage'

     dnf-plugin-system-upgrade
        upgrde to new o/s version


rpm file - install dependencies
yum --nogpgcheck localinstall <pkg file>
or maybe dnf install <pkg file>

RPM {{{1

Show package of file
    rpm -qf <path> => package name
List files in package
    rpm -ql <pkg>

Repos {{{1

Repo files in /etc/yum.d
    fedora-release-rawhide
    fedora-updates-testing 

Manage repos
	config-manager
		--add <repo URL>
		--enable | --set-enabled <repo>
		--disable <repo>


repoinfo - more detail than repolist

repolist [enabled | disabled | --all ]
    list repo details

Release management {{{2


Install from specific release: 
$releasever variable is number: 22, 23
Copy repo file and replace var with number to get packages from other release
Enabled = 0
dnf --enablerepo=fedora-23 update systemd

dnf system-upgrade download --refresh --releasever=24 --allowerasing
Return to stable:
disable testing/rawhide repos
dnf distro-sync

Old {{{1
CPU frequency control
https://dunterov.github.io/cpu-freq/
	Install kernel-tools
	Show available governors
		cpupower frequency-info --governors
