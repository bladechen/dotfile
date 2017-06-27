#!/bin/sh
# should be setup after setup zsh/bash
cp ycm_extra_conf.py ~/.ycm_extra_conf.py
CUR=`pwd`/vimrc
rm -rf ~/tmp/vim
if [ ! -d ~/vim80/ ]
then
    mkdir -p ~/tmp/vim

    cd  ~/tmp/vim
    git clone git@github.com:vim/vim.git
    cd -
    cd ~/tmp/vim/vim
    mkdir -p $HOME/vim80/
    # ./configure --prefix=$HOME/vim81/  --with-features=huge   --enable-rubyinterp  --enable-pythoninterp       --with-python-config-dir=/usr/lib/python2.7/             --enable-perlinterp             --enable-gui=gtk2 --enable-cscope             --enable-luainterp=yes  --enable-cscope  --enable-largefile
    ./configure --prefix=$HOME/vim80/  --with-features=huge   --enable-rubyinterp  --enable-pythoninterp                --enable-perlinterp             --enable-gui=gtk2 --enable-cscope             --enable-luainterp=yes  --enable-cscope  --enable-largefile 1>/dev/null

    make 1>/dev/null
    make install 1>/dev/null
    rm -rf ~/tmp/vim
    cd -

fi

if [ ! -d ~/.vim/bundle ]
then
    mkdir ~/.vim/
    cd ~/.vim/
    mkdir -p bundle

    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
    bash ./installer.sh ./bundle 1>/dev/null

    cd -
fi


cd ~
rm ~/.vimrc 2>/dev/null || true
ln -s $CUR .vimrc


# dein update may not install plugin, try several times
for ((i=1;i<5;i++))
do
    $HOME/vim80/bin/vim +'call dein#update()' +qall
    if [ -d ~/.vim/bundle//repos//github.com/bladechen/ ]
    then
        break
    fi
done


cd ~/.vim/bundle//repos//github.com//Valloric/YouCompleteMe/ 2>/dev/null || true
ycm_install=`find . -name "ycm_core.so"|wc -l`
if [ "$ycm_install" == "" ]
then
    ./install.py --clang-complete
fi
cd -
