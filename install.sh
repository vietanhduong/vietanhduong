#!/bin/bash

# install brew packages
xargs brew install <./brew/leaves
xargs brew install --cask <./brew/casks

# install Hack fonts
cp -r ./fonts/hack/* ~/Library/fonts

# install oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

# set default zsh
sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)

# link config
ln -s .tmux.conf /Users/${USER}/.tmux.conf
ln -s .vimrc /Users/${USER}/.vimrc

# install plugins for zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# git config
git config --global user.email "vietanhs0817@gmail.com"
git config --global user.name "Viet Anh Duong"
git config --global commit.gpgsign true
git config --global gpg.program gpg

# git config --global user.signingkey <place your key>



