#!/bin/bash

./batch_relink.sh . ~ .bashrc .inputrc
./batch_relink.sh . ~ .ssh/

./batch_relink.sh . ~ .gitconfig
./batch_relink.sh . ~ .pythonrc
./batch_relink.sh . ~ .vimrc

pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
