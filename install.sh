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

brew tap homebrew/cask-fonts
brew install --cask font-iosevka

# install font
APPLY_FONT=source-code-pro
cp -r ./fonts/$APPLY_FONT/* ~/Library/fonts

# install oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

# set default zsh
sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s "$(which zsh)"

# make neovim config dir
mkdir -p $HOME/.config/nvim

# link config
ln -s $PWD/.zshrc $HOME/.zshrc
ln -s $PWD/.vimrc $HOME/.config/nvim/init.vim
ln -s $PWD/.tmux.conf $HOME/.tmux.conf
ln -s $PWD/alacritty.yml $HOME/.alacritty.yml
ln -s $PWD/.gitconfig $HOME/.gitconfig

# update vim
mkdir -p "$HOME"/vim/colors
cp -r colors "$HOME"/.vim/

# install plugins for zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# download iterm shell integration
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# git config
git config --global user.email "vietanhs0817@gmail.com"
git config --global user.name "Viet Anh Duong"
git config --global commit.gpgsign true
git config --global gpg.program gpg
git config --global format.signoff true
# git config --global user.signingkey <repleace with your key>

git config --global alias.root 'rev-parse --show-toplevel'

# disable press and hold on mac os
defaults write -g ApplePressAndHoldEnabled -bool false

# enable font smoothing
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

# make sure xcode already installed
sudo xcodebuild -license accept

# allow everywhere
sudo spctl --master-disable

# hook ttl 65 at startup
sudo cp com.anhdv.ttl.plist /Library/LaunchDaemons
sudo launchctl load /Library/LaunchDaemons/com.anhdv.ttl.plist

# install fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# gcloud autocompelete
fisher install lgathy/google-cloud-sdk-fish-completion
# kubectl autocomplete
fisher install evanlucas/fish-kubectl-completions


