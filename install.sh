#!/bin/bash

# easy install
# curl -sSLf https://config.anhdv.dev/install.sh | bash

# clone repo
git clone https://github.com/vietanhduong/vietanhduong.git vietanhduong && cd $_

# exit if clone repo failed
[[ "$?" != "0" ]] && exit 1

# make sure brew already installed
if ! command -v "brew" &> /dev/null; then
  echo "brew does not install, please install brew first!" >&2
  exit 1
fi

# install brew packages
xargs brew install <./brew/leaves
xargs brew install --cask <./brew/casks

# install font
APPLY_FONT=hack
cp -r ./fonts/$APPLY_FONT/* ~/Library/fonts

# install oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

# set default zsh
sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)

# save current dir
_curdir="$PWD"

# goto $HOME
cd $HOME

# link config
ln -s $_curdir/.zshrc
ln -s $_curdir/.vimrc
ln -s $_curdir/.tmux.conf
ln -s $_curdir/alacritty.yml .alacritty.yml

cd $_curdir

# update vim
mkdir -p $HOME/.vim/colors
cp -r colors $HOME/.vim/

# install plugins for zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# download iterm shell integration
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# git config
git config --global user.email "vietanhs0817@gmail.com"
git config --global user.name "Viet Anh Duong"
git config --global commit.gpgsign true
git config --global gpg.program gpg

# git config --global user.signingkey <place your key>

# disable press and hold on mac os
defaults write -g ApplePressAndHoldEnabled -bool false

# enable font smoothing
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

sudo xcodebuild -license accept
