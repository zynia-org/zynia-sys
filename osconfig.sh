#!/bin/bash
# Config minimal Debian image to be a little less minimal

# setup sudo, if not root
if [ $(id -u) -ne 0 ]
then
  SUDO=sudo
else
  SUDO=""
fi

# Add new user
read -p "Username?: " USERNAME
if [ -n "${USERNAME}" ]
then
  ${SUDO} adduser ${USERNAME}
  ${SUDO} usermod -aG sudo ${USERNAME}
  ${SUDO} echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME}
  ${SUDO} passwd ${USERNAME} 
fi

# resize partition4 on sd card to take up rest of space
echo ", +" | ${SUDO} /sbin/sfdisk /dev/mmcblk1 -N4
${SUDO} /sbin/resize2fs /dev/mmcblk1p4

# apt update
${SUDO} apt update

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

# git
${SUDO} apt install git



