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

# Reboot
sudo reboot
