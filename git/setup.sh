#!/bin/sh
rm ~/.gitconfig 2>/dev/null|| true
rm ~/.git-completion.bash 2>/dev/null|| true
cd ~
ln -s $HOME/dotfile/git/gitconfig .gitconfig
ln -s $HOME/dotfile/git/git-completion.bash .git-completion.bash
cd -
# cp ./gitconfig ~/.gitconfig
