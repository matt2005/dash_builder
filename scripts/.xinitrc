#!/usr/bin/env sh
xset -dpms
xset s off
xset s noblank

while [ true ]; do
  sh /home/pi/rundash.sh
done
