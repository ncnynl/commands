#!/bin/bash

#run python3-pip

sudo apt install python3-pip -y

#run rosdepc

sudo pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple rosdepc

#run init

sudo rosdepc init

#run permissions

sudo rosdepc fix-permissions

