#!/bin/bash

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/local/bin.
# It's assumed that wget and a C/C++ compiler are installed.

# exit on error
set -e

TMUX_VERSION=2.5

# create our directories
mkdir -p $HOME/local $HOME/tmux_tmp
cd $HOME/tmux_tmp

# download source files for tmux, libevent, and ncurses
wget -O tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz 1>/dev/null 2>&1
# wget https://github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz --no-check-certificate
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz --no-check-certificate 1>/dev/null 2>&1

# wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz --no-check-certificate
wget http://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz --no-check-certificate 1>/dev/null 2>&1

# extract files, configure, and compile

############
# libevent #
############
tar xvzf libevent-2.1.8-stable.tar.gz 1>/dev/null 2>&1
cd libevent-2.1.8-stable

# tar xvzf libevent-2.0.19-stable.tar.gz
# cd libevent-2.0.19-stable
./configure --prefix=$HOME/local --disable-shared 1>/dev/null
make 1>/dev/null
make install 1>/dev/null
cd ..

############
# ncurses  #
############
export CPPFLAGS="-P"
tar xvzf ncurses-6.0.tar.gz 1>/dev/null
cd ncurses-6.0
./configure --prefix=$HOME/local 1>/dev/null
make 1>/dev/null
make install 1>/dev/null
cd ..

############
# tmux     #
############
tar xvzf tmux-${TMUX_VERSION}.tar.gz 1>/dev/null
cd tmux-${TMUX_VERSION}
./configure CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include" 1>/dev/null
CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib" make 1>/dev/null
cp tmux $HOME/local/bin
cd ..

# cleanup
rm -rf $HOME/tmux_tmp

echo "$HOME/local/bin/tmux is now available. You can optionally add $HOME/local/bin to your PATH."


