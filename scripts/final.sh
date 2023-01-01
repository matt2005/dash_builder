#!/bin/bash

chown pi:pi /home/pi/.config/openDsh/dash.conf
chown pi:pi /home/pi/dash/openauto.ini
apt-get install -y xserver-xorg-input-evdev
rm /usr/share/X11/xorg.conf.d/40-libinput.conf
mkdir -p /usr/share/X11/xorg.conf.d
