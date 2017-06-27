#!/bin/sh

set -x

mkdir -p ~/.ssh
chmod 0700 ~/.ssh
mkdir -p ~/.ssh/socks
cd ~/.ssh
mv ~/.ssh/config ~/.ssh/config.bak 2>/dev/null || true
ln -s ~/dotfile/ssh/config config 2>/dev/null || true
cd -



sudo apt-get update 1>/dev/null
sudo apt-get install exuberant-ctags cmake  python-dev python liblua5.2-dev "lua5.2" -y 1>/dev/null
sudo apt-get install clang -y 1>/dev/null
sudo apt-get install libssl1.0.0 libssl-dev -y 1>/dev/null
sudo apt-get install ruby -y 1>/dev/null
sudo apt-get install awscli -y 1>/dev/null
sudo apt-get install cowsay -y 1>/dev/null
sudo apt-get install gcc -y 1>/dev/null
sudo apt-get install g++ -y 1>/dev/null

sudo apt install linux-tools-common -y 1>/dev/null


sudo dpkg --add-architecture i386 1>/dev/null
sudo apt-get update 1>/dev/null
sudo apt-get install libssl1.0.0:i386 -y 1>/dev/null
sudo apt-get install libx32gcc-4.8-dev -y 1>/dev/null
sudo apt-get install libc6-dev-i386 -y 1>/dev/null
sudo apt-get install python -y 1>/dev/null
sudo apt-get install python3 -y 1>/dev/null
sudo apt-get install python-pip python-dev build-essential -y 1>/dev/null
sudo apt install zsh -y 1>/dev/null

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password 123456'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 123456'
sudo apt-get -y install mysql-server 1>/dev/null
sudo apt-get -y install mysql-client 1>/dev/null
sudo -H pip install --upgrade pip 1>/dev/null




sudo -H pip install pwn 1>/dev/null



sudo apt-get install htop tig mycli jq -y 1>/dev/null
sudo -H pip install cheat 1>/dev/null

rm -rf ~/.cheat 1>/dev/null
cd ~
ln -s $HOME/dotfile/misc/cheat_sheat .cheat
cd -


mkdir -p ~/local/bin
cd ~/local/bin
if [ ! -f pbcopy ]
then
    ln -s ~/dotfile/install_env/copy_paste/pbcopy pbcopy
    ln -s ~/dotfile/install_env/copy_paste/pbpaste pbpaste
fi
cd -

# 2G swap
SWAPFILE=/mnt/swapfile.swap

sudo cat /proc/swaps| grep swapfile 1>/dev/null 2>&1
if [ "$?" -ne "0" ]
then

	sudo swapoff -a
	sudo rm -rf "$SWAPFILE"
	sudo dd if=/dev/zero of=$SWAPFILE bs=1M count=2048
	sudo mkswap $SWAPFILE
	sudo chmod 0600 $SWAPFILE
	sudo swapon $SWAPFILE
	sudo cp ./install_env/swapfile /etc/init.d/swapfile
	sudo chmod 0550 /etc/init.d/swapfile
	sudo update-rc.d swapfile defaults
fi


cd ./shell/
bash ./setup.sh
cd -


export ENV_INSTALL=1
. ~/dotfile/shell/sh_alias
#if echo $SHELL | grep -q "zsh" 2>/dev/null
#then
#    . ~/.zshrc
#else
#    . ~/.bashrc
#fi

# export PATH=$HOME/vim80/bin:$PATH




cd ./tmux/
bash ./setup.sh 1>/dev/null
cd -


# cp ./ssh/config ~/.ssh

cd ./vim/
bash ./setup.sh
cd -

cd ./git/
bash setup.sh
cd -

if [ ! -d ~/local/PathPicker ]
then
    cd ~/local/
    git clone https://github.com/facebook/PathPicker.git
    cd PathPicker/
    ln -s "$(pwd)/fpp" $HOME/local/bin/fpp
else
    cd ~/local/PathPicker/
    git pull
fi

if [ ! -d ~/.fzf ]
then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-update-rc
else
    cd ~/.fzf && git pull && ./install
fi
cd ~
export ENV_INSTALL=0
echo "env installation complete!"
