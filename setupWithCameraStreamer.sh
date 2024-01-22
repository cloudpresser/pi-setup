# Prevent ssh freezing by setting TOS (type Of Service) field to Cs0, Cs0 (aka 0x00, 0x00) <==> (best effort, best effort)
echo "IPQoS cs0 cs0" | sudo tee -a /etc/ssh/sshd_config

# Clone rpanion
git clone --recursive https://github.com/stephendade/Rpanion-server.git

# Clone pi-setup
git clone https://github.com/cloudpresser/pi-setup.git

# Deploy rpanion
cd ./Rpanion-server/deploy && /RasPi2-3-4-5-deploy.sh
