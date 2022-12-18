#!/bin/bash

set +e

CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
if [ -f /usr/lib/raspberrypi-sys-mods/imager_custom ]; then
   /usr/lib/raspberrypi-sys-mods/imager_custom set_hostname OpenDsh
else
   echo OpenDsh >/etc/hostname
   sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\traspberrypi/g" /etc/hosts
fi
FIRSTUSER=`getent passwd 1000 | cut -d: -f1`
FIRSTUSERHOME=`getent passwd 1000 | cut -d: -f6`
if [ -f /usr/lib/raspberrypi-sys-mods/imager_custom ]; then
   /usr/lib/raspberrypi-sys-mods/imager_custom enable_ssh
else
   systemctl enable ssh
fi
#if [ -f /usr/lib/userconf-pi/userconf ]; then
#   /usr/lib/userconf-pi/userconf 'pi' '$5$YYEsyGLfTB$JCgvZ7sadgiUVquy8JRQ79aM0r3cIUbFjPduxLrGNwC'
#else
#   echo "$FIRSTUSER:"'$5$YYEsyGLfTB$JCgvZ7sadgiUVquy8JRQ79aM0r3cIUbFjPduxLrGNwC' | chpasswd -e
#   if [ "$FIRSTUSER" != "pi" ]; then
#      usermod -l "pi" "$FIRSTUSER"
#      usermod -m -d "/home/pi" "pi"
#      groupmod -n "pi" "$FIRSTUSER"
#      if grep -q "^autologin-user=" /etc/lightdm/lightdm.conf ; then
#         sed /etc/lightdm/lightdm.conf -i -e "s/^autologin-user=.*/autologin-user=pi/"
#      fi
#      if [ -f /etc/systemd/system/getty@tty1.service.d/autologin.conf ]; then
#         sed /etc/systemd/system/getty@tty1.service.d/autologin.conf -i -e "s/$FIRSTUSER/pi/"
#      fi
#      if [ -f /etc/sudoers.d/010_pi-nopasswd ]; then
#         sed -i "s/^$FIRSTUSER /pi /" /etc/sudoers.d/010_pi-nopasswd
#      fi
#   fi
#fi
#if [ -f /usr/lib/raspberrypi-sys-mods/imager_custom ]; then
#   /usr/lib/raspberrypi-sys-mods/imager_custom set_keymap 'us'
#   /usr/lib/raspberrypi-sys-mods/imager_custom set_timezone 'America/New_York'
#else
#   rm -f /etc/localtime
#   echo "America/New_York" >/etc/timezone
#   dpkg-reconfigure -f noninteractive tzdata
#cat >/etc/default/keyboard <<'KBEOF'
#XKBMODEL="pc105"
#XKBLAYOUT="us"
#XKBVARIANT=""
#XKBOPTIONS=""
#KBEOF
#   dpkg-reconfigure -f noninteractive keyboard-configuration
#fi

sudo nmcli con add type wifi ifname wlan0 con-name OpenDsh autoconnect yes ssid OpenDsh
sudo nmcli con modify OpenDsh 802-11-wireless.mode ap 802-11-wireless.band a ipv4.method shared
sudo nmcli con modify OpenDsh wifi-sec.key-mgmt wpa-psk
sudo nmcli con modify OpenDsh wifi-sec.psk "1234567890"
sudo nmcli con up OpenDsh

sudo apt-get full-upgrade
sudo apt-get sudo rpi-eeprom-update 

# Gui Boot autologin
sudo raspi-config nonint do_boot_behaviour B4

systemctl disable systemd-timesyncd
systemctl disable cups.service
systemctl disable avahi-daemon.service
systemctl disable dphys-swapfile.service
systemctl disable apt-daily.service
systemctl disable keyboard-setup.service
#systemctl disable raspi-config.service
systemctl disable triggerhappy.service
systemctl disable apt-daily-upgrade.service
systemctl disable man-db.service
systemctl disable ntp.service
systemctl disable rpi-eeprom-update

rm -f /boot/firstrun.sh
sed -i 's| systemd.run.*||g' /boot/cmdline.txt
exit 0
