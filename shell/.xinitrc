#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xsetroot -cursor_name left_ptr -xcf /usr/share/icons/Adwaita/cursors/left_ptr 48
# setxkbmap us 
# with mac-like copy and paste
setxkbmap us -option cutpaste:super
# touchpad acceleration
xinput --set-prop 12 "libinput Accel Speed" 0.6
exec bspwm
