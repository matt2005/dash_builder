#!/bin/bash

chown pi:pi /home/pi/.config/openDsh/dash.conf
chown pi:pi /home/pi/dash/openauto.ini
sudo apt-get install -y xserver-xorg-input-evdev
sudo rm /usr/share/X11/xorg.conf.d/40-libinput.conf
sudo mkdir -p /usr/share/X11/xorg.conf.d

sudo apt-get clean autoclean
sudo apt-get autoremove --yes