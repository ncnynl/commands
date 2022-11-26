#!/bin/bash
################################################
# Function : install_tb4_ignition_source.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-10-31                           
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
#run ros2_tb4_ignition


# if installed ?
if [ -d ~/ros2_tb4_ws/src/turtlebot4_tutorials ]; then
    echo "Turtlebot4 ignition have installed!!" 
else

    # install dep

    sudo apt install -y  wget python3-colcon-common-extensions python3-rosdep  python3-vcstool

    # 新建工作空间
    mkdir -p ~/ros2_tb4_ws/src

    #run cd ros2_tb4_ws

    # 进入工作空间

    cd ~/ros2_tb4_ws/src

    #run wget

    # 获取仓库列表

    git clone https://ghproxy.com/https://github.com/turtlebot/turtlebot4_simulator.git

    #run import
    echo "this will take 10-30 min to download"

    # 下载仓库
    echo "Dowload from irobot_create_msgs "

    git clone -b galactic https://ghproxy.com/https://github.com/iRobotEducation/irobot_create_msgs.git

    echo "Dowload from create3_sim "
    git clone -b galactic https://ghproxy.com/https://github.com/iRobotEducation/create3_sim.git

    echo "Dowload from turtlebot4 "
    git clone -b galactic https://ghproxy.com/https://github.com/turtlebot/turtlebot4.git

    echo "Dowload from turtlebot4_desktop "
    git clone -b galactic https://ghproxy.com/https://github.com/turtlebot/turtlebot4_desktop.git

    echo "Dowload from turtlebot4_tutorials "
    git clone -b galactic https://ghproxy.com/https://github.com/turtlebot/turtlebot4_tutorials.git


    #run colcon

    # 编辑各个包, 如果编译出错，重新编译一次
    echo "build workspace..."
    cd ~/ros2_tb4_ws/
    rosdep install --from-path src -yi
    colcon build --symlink-install

    #run echo

    # 添加工作空间路径到bashrc文件

    echo 'source ~/ros2_tb4_ws/install/local_setup.bash' >> ~/.bashrc

    # 加载工作空间到当前环境

    source ~/.bashrc

fi