#!/bin/bash

cat <<EOT >> /boot/config.txt
[pi4]
arm_freq=1800
core_freq=500
dtoverlay=vc4-kms-v3d
initial_turbo=30
force_turbo=1
max_framebuffers=2
arm_64bit=1
[all]
dtoverlay=disable-bt
gpio=16=op,dh
boot_delay=0
dtparam=spi=on
#dtoverlay=mcp2515-can0,oscillator=8000000,interrupt=25
#dtoverlay=spi0-2cs
EOT

# CAN settings
cat <<EOT >> /etc/network/interfaces

#allow-hotplug can0
#iface can0 can static
#    bitrate 33330
EOT
#Setup network interfaces
apt-get -y install network-manager links
raspi-config nonint do_netconf 2
# setup access point
apt-get install -y vim
cat <<EOT >> /etc/dhcpcd.conf
denyinterfaces wlan0
EOT
# configure memory split and disable screensaver, set hostname
raspi-config nonint do_memory_split 128
raspi-config nonint do_hostname OpenDsh
sed -i 's/apt-get install realvnc-vnc-server/apt-get install -y realvnc-vnc-server/g' /usr/bin/raspi-config
raspi-config nonint do_vnc 1
raspi-config nonint do_wifi_country GB
raspi-config nonint do_ssh 1
/usr/lib/raspberrypi-sys-mods/imager_custom set_keymap 'gb'
/usr/lib/raspberrypi-sys-mods/imager_custom set_timezone 'Europe/London'