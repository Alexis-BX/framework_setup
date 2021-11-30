#!/bin/bash

sudo apt update
sudo apt upgrade -y

## Fix mic input
sudo echo "" >> /etc/modprobe.d/alsa-base.conf
sudo echo "# Mic on audio jack fix" >> /etc/modprobe.d/alsa-base.conf
sudo echo "options snd-hda-intel model=dell-headset-multi" >> /etc/modprobe.d/alsa-base.conf

## Add deep sleep
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash mem_sleep_default=deep"/g' /etc/default/grub
sudo update-grub

## Path correction for python (solved a compilation issue)
export PATH="/home/$USER/.local/bin:$PATH"

## Fingerprint reader
sudo apt purge --auto-remove fprintd libfprint-2-2 -y
sudo apt install gtk-doc-tools libfprint-2-dev libgirepository1.0-dev libgusb-dev libgudev-1.0-dev libpam-wrapper libpam0g-dev libpamtest0-dev libpolkit-gobject-1-dev libxml2-utils python3-pip python3-pypamtest git gettext valgrind -y
sudo apt install build-essential cmake gettext libdbus-1-dev libdbus-glib-1-dev libdebconfclient0 libglib2.0-dev libnss3-dev libpixman-1-dev libsystemd-dev meson python3-dbusmock libpam-fprintd udev libcairo2-dev -y
sudo pip install meson
pip install ninja gobject python-dbusmock

git clone https://gitlab.freedesktop.org/libfprint/fprintd.git
cd fprintd && git checkout 1.90.1 && cd ..
git clone https://gitlab.freedesktop.org/libfprint/libfprint.git
cd libfprint && git checkout v1.94.2 && cd ..

sed -i "s/value: 'default'/value: 'goodixmoc'/g" libfprint/meson_options.txt
meson libfprint libfprint/_build
sudo ninja -C libfprint/_build install
meson fprintd fprintd/_build
sudo ninja -C fprintd/_build install

sudo pam-auth-update

echo "You can now go to Settings -> Users to enroll your fingerprints"
echo "If the option does not appear, then there must have been an error in one of the steps above (probably the compilations, lines 31-34)"
