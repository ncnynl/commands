#!/bin/bash
sudo apt update 
# install dep

sudo apt install -y \
python3-colcon-common-extensions \
python3-rosdep \
python3-vcstool
#run mkdir

sudo mkdir -p /etc/ros/rosdep/sources.list.d/

#run curl

sudo curl -o /etc/ros/rosdep/sources.list.d/20-default.list https://mirrors.tuna.tsinghua.edu.cn/github-raw/ros/rosdistro/master/rosdep/sources.list.d/20-default.list

#run export 

export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml

#run bashrc

echo 'export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml' >> ~/.bashrc

#run rosdep update
sudo rosdep fix-permissions

rosdep update

