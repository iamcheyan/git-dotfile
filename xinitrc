#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

[[ -f $HOME/.profile ]] && source $HOME/.profile

# setup XIM environment, needn't if use SCIM as gtk-immodules
export XIM="fcitx"
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim
export XIM_PROGRAM='fcitx &'
killall fcitx
fcitx &

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

for script in /etc/X11/Xsession.d/*; do
  if [ -x $script ]; then
    . $script
  fi
done
unset script

xrdb -merge ~/.Xresources   # update x resources db
xrdb ~/.Xdefaults

xscreensaver -no-splash &         # starts screensaver daemon
sh ~/.fehbg &                     # sets the background image
#xsetroot -cursor_name left_ptr &  # sets the cursor icon
#xset -b /usr/bin/numlockx on      # open numlock

# Transparency
xcompmgr -c -t-5 -l-5 -r4.2 -o.55 &

#xbindkeys &

# X keymap, console keymap in /etc/rc.local
if [ -f ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi
xmodmap -e "keycode 135 = Menu"
xmodmap -e "keysym Menu = Super_R"
# Remap touchpad
xinput set-button-map "SynPS/2 Synaptics TouchPad" 3 2 1
synclient TapButton1=3 # 修正单击触摸板

# WM setting
DEFAULT_SESSION="awesome"
case $1 in
  awesome) exec $1 ;;
  lxde) exec startlxde & ;;
  *) exec $DEFAULT_SESSION ;;
esac
# exec ck-launch-session dbus-launch startlxde
# vim: set ft=sh:
