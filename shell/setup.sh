#!/bin/sh
if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "Install oh-my-zsh ..."
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh 1>/dev/null
    cp ~/.zshrc ~/.zshrc.orig 2>/dev/null || true
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 2>/dev/null || true
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 2>/dev/null || true
CUR=`pwd`/zshrc
cd ~
mv ~/.zshrc ~/.zshrc_bak 2>/dev/null || true
ln -s $CUR ./.zshrc

cd -

CUR=`pwd`/bashrc
cd ~

mv ~/.bashrc ~/.bashrc_bak 2>/dev/null || true
ln -s $CUR ./.bashrc

rm ./.bash_profile 2>/dev/null || true
ln -s $CUR ./.bash_profile
cd -


