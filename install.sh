#!/bin/bash

# install brew first
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash 

# install what I need with brew
./brew/dumps.sh

# install Hack fonts
cp -r ./fonts/hack/* ~/Library/fonts

# install oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

# set default zsh
sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)

# link config
ln -s .tmux.conf ~/.tmux.conf
ln -s .vimrc ~/.vimrc

# make sure .zshrc already removed
rm -f ~/.zshrc
ln -s .zshrc ~/.zshrc
