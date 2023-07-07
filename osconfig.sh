#!/bin/bash
# Config minimal Debian image to be a little less minimal

# setup sudo, if not root
if [ $(id -u) -ne 0 ]
then
  SUDO=sudo
else
  SUDO=""
fi

# kick off sudo passwd request
${SUDO} touch foo-$$
${SUDO} rm -f foo-$$

# Add new user
read -p "Username for additional user?: " USERNAME
if [ -n "${USERNAME}" ]
then
  read -p "Full name for ${USERNAME}?: " FULLNAME
  if [ -z "${FULLNAME}" ]; then FULLNAME="Zynia User"; fi
  read -p "Email for ${USERNAME}?: " EMAIL
  if [ -z "${EMAIL}" ]; then EMAIL="user@zynia.org"; fi
  ${SUDO} adduser --gecos "" ${USERNAME}
  ${SUDO} usermod -aG sudo ${USERNAME}
  ${SUDO} echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" | ${SUDO} tee /etc/sudoers.d/${USERNAME} >/dev/null
else
  USERNAME="user"
  FULLNAME="Zynia User"
  EMAIL="user@zynia.org"
fi

# resize partition4 on sd card to take up rest of space
echo ", +" | ${SUDO} /sbin/sfdisk /dev/mmcblk1 -N4 --force
${SUDO} /sbin/partprobe
${SUDO} /sbin/resize2fs /dev/mmcblk1p4

# apt update
${SUDO} apt update

# git
${SUDO} apt install -y git
pushd ~${USERNAME} 2>/dev/null >/dev/null
echo "[user]" >.gitconfig
echo -e "\temail = ${EMAIL}" >>.gitconfig
echo -e "\tname = ${FULLNAME}" >>.gitconfig
popd ~${USERNAME} 2>/dev/null >/dev/null


# Firefox
${SUDO} DEBIAN_FRONTEND=noninteractive apt-get install libevent-dev libdbus-glib-1-dev -y
wget https://github.com/starfive-tech/Debian/releases/download/v0.8.0-engineering-release-wayland/firefox_105.0_202305_riscv64.deb
${SUDO} dpkg -i firefox_105.0_202305_riscv64.deb
rm firefox_105.0_202305_riscv64.deb

# Chromium
# Skip Chromium for now since it doesn't really work on VF2 - FGH 2023-07-06
#${SUDO} DEBIAN_FRONTEND=noninteractive apt-get install libre2-9 libminizip-dev -y
#wget https://github.com/starfive-tech/Debian/releases/download/v0.8.0-engineering-release-wayland/chromium-103.0.5060.114.deb
#${SUDO} dpkg -i chromium-103.0.5060.114.deb
#rm chromium-103.0.5060.114.deb
#export DISPLAY=":0"
#chrome

# set the timezone to west coast US
${SUDO} timedatectl set-timezone America/Los_Angeles

# reboot
${SUDO} systemctl reboot
