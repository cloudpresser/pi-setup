: ${SCRIPT_NAME:=setup.sh}
: ${TARGET_IP:=192.168.1.164}
: ${TARGET_USER:=luiz}

COMMAND="sudo apt install tmux -y && tmux new -s deploy -d 'wget -qO- https://raw.githubusercontent.com/cloudpresser/pi-setup/main/$SCRIPT_NAME | bash'"
echo $SCRIPT_NAME $TARGET_IP $COMMAND
sudo sed -i '' "/$TARGET_IP/d" $HOME/.ssh/known_hosts
ssh -o StrictHostKeyChecking=accept-new -t $TARGET_USER@$TARGET_IP $COMMAND
