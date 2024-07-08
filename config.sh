#!/bin/bash

./batch_relink.sh . ~ .inputrc .tmux.conf
./batch_relink.sh . ~ .ssh/

./batch_relink.sh . ~ .bashrc .bash_aliases
./batch_relink.sh . ~ .gitconfig .vimrc

./batch_relink.sh . ~ .pythonrc

pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

