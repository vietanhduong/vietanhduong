#!/bin/bash

# install brew packages
xargs brew install < ./brew/leaves
xargs brew install --cask < ./brew/casks

# install Hack fonts
cp -r ./fonts/hack/* ~/Library/fonts

# install oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

# set default zsh
sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)

# link config
ln -s ./.tmux.conf ~/.tmux.conf
ln -s ./.vimrc ~/.vimrc

# install plugins for zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
