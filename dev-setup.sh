#!/bin/bash

cd ~

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf .
cp /tmux.conf.local ~/.tmux.conf.local

curl -sLf https://spacevim.org/install.sh | bash
mkdir -p ~/.SpaceVim.d
cp /init.toml ~/.SpaceVim.d/init.toml
