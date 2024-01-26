# Return home
cd $HOME

# setup arducam
wget -O install_pivariety_pkgs.sh https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/install_script/install_pivariety_pkgs.sh
chmod +x install_pivariety_pkgs.sh

# libcamera
./install_pivariety_pkgs.sh -p libcamera_dev
./install_pivariety_pkgs.sh -p libcamera_apps

# Hawkeye drivers
./install_pivariety_pkgs.sh -p 64mp_pi_hawk_eye_kernel_driver

git clone https://github.com/ayufan-research/camera-streamer.git --recursive
sudo apt-get -y install libavformat-dev libavutil-dev libavcodec-dev libcamera-dev liblivemedia-dev v4l-utils pkg-config xxd build-essential cmake libssl-dev

cd camera-streamer/
make
sudo make install

cd ..

systemctl enable $PWD/pi-setup/camera-streamer-arducam-64MP.service
systemctl start camera-streamer-arducam-64MP.service
