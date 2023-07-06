#!/bin/bash

# setup sudo, if not root
if [ $(id -u) -ne 0 ]
then
  SUDO=sudo
else
  SUDO=""
fi

# apt update
${SUDO} apt update

# Jack2
${SUDO} apt install -y qjackctl

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
${SUDO} apt install -y invada-studio-plugins-lv2
# Calf plugins
${SUDO} apt install -y calf-plugins

# Sample midi files
${SUDO} mkdir /usr/share/sounds/midi
${SUDO} wget -P /usr/share/sounds/midi https://bitmidi.com/uploads/87216.mid
${SUDO} wget -P /usr/share/sounds/midi https://bitmidi.com/uploads/28362.mid
${SUDO} wget -P /usr/share/sounds/midi https://bitmidi.com/uploads/16752.mid
${SUDO} wget -P /usr/share/sounds/midi https://bitmidi.com/uploads/28316.mid
${SUDO} wget -P /usr/share/sounds/midi https://bitmidi.com/uploads/104840.mid
${SUDO} wget -P /usr/share/sounds/midi https://bitmidi.com/uploads/35017.mid
${SUDO} wget -P /usr/share/sounds/midi https://bitmidi.com/uploads/37464.mid

# Turn off pipewire
systemctl --user mask pipewire.service
systemctl --user mask pipewire-pulse.service
systemctl --user mask pipewire.socket
systemctl --user mask pipewire-pulse.socket


# All done -- reboot
${SUDO} systemctl reboot





