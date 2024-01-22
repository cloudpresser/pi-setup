: ${SCRIPT_NAME:=setup.sh}
: ${TARGET_IP:=192.168.1.164}
: ${TARGET_USER:=luiz}

COMMAND="sudo apt install tmux -y && tmux new -s deploy 'wget -qO- https://raw.githubusercontent.com/cloudpresser/pi-setup/main/$SCRIPT_NAME | bash'"
echo $SCRIPT_NAME $TARGET_IP $COMMAND
sude sed -i "/$TARGET_IP/d" ~/.ssh/known_hosts
ssh -t $TARGET_USER@$TARGET_IP $COMMAND -y
