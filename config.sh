#!/bin/bash

./batch_relink.sh . ~ .bashrc .gitconfig .pythonrc .vimrc .ssh/

pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
