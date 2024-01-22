#!/bin/bash

# Get git & tmux
sudo apt -y install git

# Clone rpanion
git clone --recursive https://github.com/stephendade/Rpanion-server.git

# Clone pi-setup
git clone https://github.com/cloudpresser/pi-setup.git

# Deploy rpanion
cd ./Rpanion-server/deploy

set -e
set -x

git submodule update --init --recursive

## Raspi-Config - camera, serial port, ssh
#sudo raspi-config nonint do_expand_rootfs
sudo raspi-config nonint do_camera 0
sudo raspi-config nonint do_ssh 0

## Pi5 uses a different UART for the 40-pin header (/dev/ttyAMA0)
# See https://forums.raspberrypi.com/viewtopic.php?t=359132
if [ -e "/proc/device-tree/compatible" ]; then
    if grep -q "5-model-bbrcm" "/proc/device-tree/compatible"; then
        echo "dtparam=uart0=on" | sudo tee -a /boot/config.txt >/dev/null
    else
        # Enable serial, disable console
        sudo raspi-config nonint do_serial 2
    fi
fi

## Change hostname
sudo raspi-config nonint do_hostname rpanion
sudo perl -pe 's/raspberrypi/rpanion/' -i /etc/hosts

./install_common_libraries.sh

## Only install picamera2 on RaspiOS
sudo apt -y install python3-picamera2 python3-libcamera python3-kms++

sudo systemctl disable dnsmasq
sudo systemctl enable NetworkManager

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source $HOME/.nvm/nvm.sh

nvm install --lts
nvm use --lts


## Creates a symlink to /usr/bin/node after using nvm (https://gist.github.com/MeLlamoPablo/0abcc150c10911047fd9e5041b105c34)
sudo ln -s $(which node) /usr/bin/
sudo ln -s $(which npm) /usr/bin/

## Configure nmcli to not need sudo
sudo sed -i.bak -e '/^\[main\]/aauth-polkit=false' /etc/NetworkManager/NetworkManager.conf

## mavlink-router
./build_mavlinkrouter.sh

## and build & run Rpanion
./build_rpanion.sh

## Setup arducam
../../pi-setup/setupArducam.sh

## For wireguard. Must be installed last as it messes the DNS resolutions
## sudo apt install -y resolvconf

## Prevent ssh freezing by setting TOS (type Of Service) field to Cs0, Cs0 (aka 0x00, 0x00) <==> (best effort, best effort)
echo "IPQoS cs0 cs0" | sudo tee -a /etc/ssh/sshd_config

sudo reboot
