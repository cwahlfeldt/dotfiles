#!/usr/bin/env bash

echo "Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Software"
brew install zsh nvm composer git coreutils neovim php tig deno exa fzf ack bat curl bash speedtest-cli python python@3.8
brew cask install slack google-chrome homebrew/cask-versions/firefox-developer-edition kitty docker lastpass rectangle figma godot blender phpstorm
brew tap homebrew/cask-fonts
brew cask install font-fira-code-nerd-font

echo "Install Node"
nvm install --lts
nvm use --lts

echo "Install Global NPM Packages"
npm install -g npm serve

echo "Install Pantheon Terminus"
mkdir ~/terminus && cd ~/terminus
curl -L https://github.com/pantheon-systems/terminus/releases/download/$(curl --silent "https://api.github.com/repos/pantheon-systems/terminus/releases/latest" | perl -nle'print $& while m{"tag_name": "\K.*?(?=")}g')/terminus.phar --output terminus
chmod +x terminus
sudo ln -sf ~/terminus/terminus /usr/local/bin/terminus

echo "Symlink Config"
cd ~/dotfiles
ln -sf ./.zshrc ~/.zshrc
ln -sf ./init.vim ~/init.vim
ln -sf ./kitty.conf ~/kitty.conf
