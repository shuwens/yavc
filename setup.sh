#!/bin/bash
set -e

PYTHON_VERSION=3.12.0

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src

set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

git clone https://github.com/pyenv/pyenv-virtualenv.git (pyenv root)/plugins/pyenv-virtualenv

sudo apt install -y zlib1g-dev lzma-dev zip unzip
sudo apt-get install -y build-essential zlib1g-dev libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev

pyenv install ${PYTHON_VERSION}
pyenv virtualenv ${PYTHON_VERSION} neovim3
