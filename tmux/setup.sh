#!/bin/sh
if [ ! -f $HOME/local/bin/tmux ]
then
    bash ./tmux_install.sh
fi
if [ ! -d $HOME/.tmux/plugins ]
then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
CUR=`pwd`/tmux.conf

cd ~
rm ~/.tmux.conf 2>/dev/null|| true
ln -s $CUR .tmux.conf

cd -
# start a server but don't attach to it
tmux start-server
# create a new session but don't attach to it either
tmux new-session -d
# install the plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh
# killing the server is not required, I guess
tmux kill-server

