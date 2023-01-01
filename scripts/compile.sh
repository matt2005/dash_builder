#!/bin/bash

# https://github.com/openDsh/dash/issues/63#issuecomment-821121874
apt-get -y install wget software-properties-common dirmngr apt-transport-https lsb-release ca-certificates git sudo
apt-get -y install --no-install-recommends xserver-xorg-video-all xserver-xorg-input-all xserver-xorg-core xinit x11-xserver-utils  
apt-get -y install gstreamer1.0-plugins-good gstreamer1.0-omx xserver-xorg-video-fbturbo

# add in pi ux tweaks (icons + lxpanel plugins)
apt-get -y install pixflat-icons lxplug-bluetooth lxplug-volumepulse lxplug-network
cd /home/pi && sudo -u pi git clone https://github.com/openDsh/dash
cd /home/pi/dash && sed -i 's/\(^\s*\)\(make\)\($\)/\1make -j$(nproc)/g' install.sh
cp /home/pi/dash_pimod.patch /home/pi/dash/
git apply dash_pimod.patch

cd /home/pi/dash && sudo -u pi bash ./install.sh --deps
cd /home/pi/dash && sudo -u pi bash ./install.sh --aasdk
cd /home/pi/dash && sudo -u pi bash ./install.sh --h264bitstream
cd /home/pi/dash && sudo -u pi bash ./install.sh --gstreamer
cd /home/pi/dash && sudo -u pi bash ./install.sh --pulseaudio
cd /home/pi/dash && sudo -u pi bash ./install.sh --bluez
cd /home/pi/dash && sudo -u pi bash ./install.sh --ofono
# PI2
cd /home/pi/dash && sed -i 's/0006/a01041/g' cmake_modules/functions.cmake
# PI4
#cd /home/pi/dash && sed -i 's/0006/b03111/g' cmake_modules/functions.cmake
cd /home/pi/dash && sudo -u pi bash ./install.sh --openauto
cd /home/pi/dash && sudo -u pi bash ./install.sh --dash
sudo -u pi mkdir -p /home/pi/.config/openDsh