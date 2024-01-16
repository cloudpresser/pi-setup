# Get git
sudo apt install git

# Clone rpanion
cd ~/ && git clone --recursive https://github.com/stephendade/Rpanion-server.git
cd ./Rpanion-server/deploy && ./RasPi2-3-4-5-deploy.sh 

# Prevent ssh freezing by setting TOS (type Of Service) field to Cs0, Cs0 (aka 0x00, 0x00) <==> (best effort, best effort)
echo "IPQoS cs0 cs0" >> /etc/ssh/sshd_config

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

cd ./Rpanion-server/deploy && ./deploy/wifi_access_point.sh


