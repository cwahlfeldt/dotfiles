#!/usr/bin/env bash

xcode-select --install

echo "Set Fast Key Repeats"
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

echo "Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "Installing Software"
brew install zsh nvm composer git coreutils neovim php tig deno exa fzf ack bat curl bash speedtest-cli python python@3.8
brew cask install slack google-chrome homebrew/cask-versions/firefox-developer-edition kitty docker lastpass rectangle figma godot blender phpstorm
brew tap homebrew/cask-fonts
brew cask install font-fira-code-nerd-font

echo "Activate Gotham Colorscheme"
cd ~/dotifles/.config/gotham
./gotham.sh

echo "Install oh-my-zsh"
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Install Node"
nvm install --lts
nvm use --lts

echo "Install Global NPM Packages"
npm install -g npm serve neovim

echo "Install vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Install neo vim packages"
nvim -c PlugUpgrade -c PlugInstall -c CocUpdate -c qa!

echo "Install Pantheon Terminus"
mkdir ~/terminus && cd ~/terminus
curl -L https://github.com/pantheon-systems/terminus/releases/download/$(curl --silent "https://api.github.com/repos/pantheon-systems/terminus/releases/latest" | perl -nle'print $& while m{"tag_name": "\K.*?(?=")}g')/terminus.phar --output terminus
chmod +x terminus
ln -sf ~/terminus/terminus /usr/local/bin/terminus

echo "Symlink Config"
cd ~/dotfiles
ln -sf ./.zshrc ~/.zshrc
ln -sf ./init.vim ~/init.vim
ln -sf ./kitty.conf ~/kitty.conf
ln -sf ./.config ~/.config

source ~/.zshrc
