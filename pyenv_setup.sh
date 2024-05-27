#!/bin/bash
set -e

sudo apt install -y zlib1g-dev lzma-dev zip unzip npm
sudo apt-get install -y build-essential zlib1g-dev libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev


PYTHON_VERSION=3.12.0

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src

git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv

~/.pyenv/bin/pyenv install ${PYTHON_VERSION}
~/.pyenv/bin/pyenv virtualenv ${PYTHON_VERSION} neovim3


# pip3 install neovim pynvim


echo "Pyenv and pyenv virtualenv is all set"
echo "# set -Ux PYENV_ROOT $HOME/.pyenv"
echo "# fish_add_path $PYENV_ROOT/bin"
