#!/bin/bash

# Main install -y script

# i will edit this to be a install -yation script for axcd AntiX Core Dwm
# run me as root
#
# update and vim
apt-get update &&
apt-get purge vim-tiny &&
apt-get install -y vim &&
apt-get upgrade &&
apt-get autoremove &&

# xwin
apt-get install -y xserver-xorg-video-intel &&
apt-get install -y xfonts-base &&
apt-get install -y xserver-xorg-input-all &&
apt-get install -y pmount &&
apt-get install -y xinit &&

# gcc
apt-get install -y build-essential &&
apt-get install -y git &&
apt-get install -y patch &&
apt-get install -y libx11-dev &&
apt-get install -y libxft-dev &&
apt-get install -y libxinerama-dev &&

# suckless mm
cd /usr/src/ &&
git clone http://git.suckless.org/dwm &&
git clone http://git.suckless.org/st &&
git clone http://git.suckless.org/dmenu &&
git clone http://git.suckless.org/slstatus &&
cd /usr/src/dwm && make clean install -y &&
cd /usr/src/dmenu && make clean install -y &&
cd /usr/src/st && make clean install -y &&
cd /usr/src/slstatus && make clean install -y &&

# xwin setup
cd && 
echo "exec dwm" > .xinitrc &&

# Extra configure and program install -y

# on laptop. to monitor battery charge
apt-get install -y acpi

apt-get install -y qutebrowser # mini browser
# customice qutebrowser settings

apt-get install -y neofetch # inxi and neofetch show system info
apt-get install -y ssh

# config dwm/config.h
replace Mod1Mask with Mod4Mask # use Win-key(Super) insted of Alt
static const char dmenufont... size=12 # change font size

# config st/config.h
static char pixelsize=18 # change font size

# Install a new font to solve problem with st-teminal font
https://sourcefoundry.org/hack/
apt-get install -y unzip && unzip Hack...
cp -r Hack*.ttf /usr/share/fonts/ttf # copy all fonts to default dir
fc-cache -fv # update font list
in st/config.h change
(static char *font = "Liberation Mono:....) to (static char *font = "Hack-Regular:....)

# Auto hide mouse pointer. I don't have any mouse install -yed.
apt install -y unclutter
apt install -y unclutter-startup # dont know if i need this file
cd /usr/src/dwm
# download autostart patch for dwm
https://dwm.suckless.org/patches/autostart/dwm-autostart-20210120-cb3f58a.diff
patch < dwm-autostart-20210120-cb3f58a.diff # install -y autostart patch to dwm
make clean install -y
cd ~ && mkdir .dwm && cd .dwm
echo "unclutter -idle 0.1 -root" > autostart.sh # hides mouse pointer i 0.1sec
chmod +x autostart.sh

# add new keybinds to dwm. Press super+u to run launcher.sh
vim /usr/src/dwm/config.h
/* commands */
static const char *dm_launcher[] = { "dm_launcher.sh", NULL };
{ MODKEY, XK_u, spawn, {.v = dm_launcher } },

# script file dm_launcher.sh looks like this
#!/bin/bash
# dmenu dm_launcher.sh
options="QuteBrowser
Terminal"

choice=$(printf "%s" "$options" | dmenu -i -p "Menu:")

case "$choice" in
    QuteBrowser) qutebrowser ;;
    Terminal) st ;;

# remove special rules for programs
vim dwm/config.h
static Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ NULL,       NULL,       NULL,       0,            False,       -1 },
};

# turn off tlp, battery system service
update-rc.d tlp disable
cd /etc/init.d
chmod -x tlp

# turn off sound support
update-rc.d alsa-utils disable
cd /etc/init.d
chmod -x alsa-utils



# Project im still working on





# to get bluetooth to work
rfkill list
rfkill unblock bluetooth
suso apt-get install -y bluez-tools and bluez //to get bluetoothctl


# file manager to install -y
superfile
# or check the list of other manager
https://www.tecmint.com/linux-terminal-file-managers/
Clifm – Fast File Manager
https://github.com/leo-arch/clifm/
libcap-dev, libacl1-dev, libreadline-dev, libmagic-dev
atool archivemount p7zip p7zip-full p7zip-rar
make install -y

Yazi – Blazing Fast Terminal File Manager
https://github.com/sxyazi/yazi?tab=readme-ov-file
dependensic:
ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick














install -y fire wall ????
apt-get install -y ufw
# firewall – set it & forget it







# to startx by default on bootup
vim /etc/inittab
change runlevel to 3 to start in x insted of console.
runlevel 2 = console
runlevel 3 = xwin
we probably nead a login manager for this to work.
# check these out
https://en.wikipedia.org/wiki/X_display_manager
https://en.wikipedia.org/wiki/LightDM
or maby XDM 

# auto start xorg
install -y xdm
echo "exec dwm" > .xsession # start script
# xdm needs more config to be nice.

# use alias to make commands with default syntax
  alias update='pacman -Syu'  # updates system with pacman
# add the line to .profile to activate on bootup

# to disable pc speaker BEEP
vim /etc/modprobe.d/*.conf
blacklist snd-pcsp
blacklist pcspkr

# shortcuts for dwm
left-Alt-p - dmenu
left-Alt-shift-enter - st terminal
left-Alt-shift-q - logout
ctrl-shift-pg up & pg down - zoom text size
left-Alt-b - remove status bar
ctrl-l - clear window
left-Alt-h and l - resize window
left-Alt-j and k - move between windows
left-Alt-enter - switch master/slave


~/.dwm/autostart.sh

# Make sure you have the path to ~/.local/bin
echo $PATH
# if not pressent
cd ~ && echo "export PATH=$PATH:$HOME/.local/bin" >> .profile # to add path
# if bin directory dont exist
cd ~/.local/ && mkdir bin && cd ~/.local/bin
echo "unclutter -idle 0.1 -root" > autostart.sh # hides mouse pointer i 0.1sec
chmod +x autostart.sh

