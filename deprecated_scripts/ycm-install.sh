#!/bin/bash

cp vimrc_ycm ~/.vimrc
cd bundle && git clone https://github.com/Valloric/YouCompleteMe.git 
./install.py --clang-completer --gocode-completer --racer-completer 

