#!/bin/bash

# make sure we are running sudo
if [ $(id -u) -ne 0 ]
then
  SUDO=sudo
else
  SUDO=""
fi

# apt update
${SUDO} apt update

# Alsa Utilities
${SUDO} apt install alsa-utils

# Firefox
${SUDO} DEBIAN_FRONTEND=noninteractive apt-get install libevent-dev libdbus-glib-1-dev -y
wget https://github.com/starfive-tech/Debian/releases/download/v0.8.0-engineering-release-wayland/firefox_105.0_202305_riscv64.deb
${SUDO} dpkg -i firefox_105.0_202305_riscv64.deb
rm firefox_105.0_202305_riscv64.deb

# Chromium
${SUDO} DEBIAN_FRONTEND=noninteractive apt-get install libre2-9 libminizip-dev -y
wget https://github.com/starfive-tech/Debian/releases/download/v0.8.0-engineering-release-wayland/chromium-103.0.5060.114.deb
${SUDO} dpkg -i chromium-103.0.5060.114.deb
rm chromium-103.0.5060.114.deb

# Jack2
${SUDO} apt install -y jack2

# PureData
${SUDO} apt install -y puredata

# ZynAddSynth
${SUDO} apt install -y zynaddsynth

# Fluidsynth
${SUDO} apt install -y fluidsynth

# JALV
${SUDO} apt install -y jalv

# LV2 plugins
#  Invada Studio Plugins
${SUDO} apt install invada-studio-plugins-lv2
# Calf plugins
${SUDO} apt install calf-plugins



# Turn off pipewire
systemctl --user mask pipewire.service
systemctl --user mask pipewire-pulse.service
systemctl --user mask pipewire.socket
systemctl --user mask pipewire-pulse.socket


# All done -- reboot
${SUDO} systemctl reboot





