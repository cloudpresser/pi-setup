# Get git & tmux
sudo apt install git

# Prevent ssh freezing by setting TOS (type Of Service) field to Cs0, Cs0 (aka 0x00, 0x00) <==> (best effort, best effort)
echo "IPQoS cs0 cs0" >> /etc/ssh/sshd_config

# Clone rpanion
cd ~/ && git clone --recursive https://github.com/stephendade/Rpanion-server.git
cd ./Rpanion-server/deploy && tmux new-session -s deploy_rpanion './RasPi2-3-4-5-deploy.sh'
