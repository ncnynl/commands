#!/bin/bash
################################################
# Function : Install ROS2 jazzy turtlebot3 source version 
# Desc     : 用于源码方式安装ROS2 Jazzy版Turtlebot3的脚本  
# Website  : https://www.ncnynl.com/archives/202210/5574.html                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2025-02-17 15:25:09                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 jazzy turtlebot3 source version")"

# echo "Not Yet Supported!"
# exit 0


# if installed ?
if [ -d ~/ros2_tb3_ws/src ]; then
    echo "Turtlebot3 have installed!!" 
else
    # install dep

    $ sudo apt install ntpdate\
                        chrony \
                        python3-colcon-common-extensions \
                        ros-jazzy-nav2-bringup \
                        ros-jazzy-navigation2 \
                        ros-jazzy-cartographer \
                        ros-jazzy-cartographer-ros \
                        ros-jazzy-dynamixel-sdk \
                        ros-jazzy-dynamixel-workbench \
                        ros-jazzy-turtlebot3-msgs \
                        ros-jazzy-hls-lfcd-lds-driver \
                        ros-jazzy-slam-toolbox 

    #rosdep update
    sudo apt install python3-rosdep -y
    . ~/commands/common/shell/update_rosdep_tsinghua.sh
    # rosdep update
    cs -si update_rosdep_tsinghua


    # 新建工作空间
    mkdir -p ~/ros2_tb3_ws/src

    #run cd ros2_tb3_ws

    # 进入工作空间

    cd ~/ros2_tb3_ws/src

    #run wget

    # 获取仓库列表
    #run import
    echo "this will take 10-30 min to download"

    # 下载仓库
    echo "Dowload from turtlebot3 "

    git clone -b jazzy https://github.com/ROBOTIS-GIT/turtlebot3.git

    echo "Dowload from ld08_driver "
    git clone -b ros2-devel https://github.com/ROBOTIS-GIT/ld08_driver.git

    #run colcon

    # 编辑各个包
    echo "build workspace..."
    cd ~/ros2_tb3_ws/
    rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y
    colcon build --symlink-install --parallel-workers 1

    # add rule
    cd ~/ros2_tb3_ws/src/turtlebot3/turtlebot3_bringup/script
    sudo cp 99-turtlebot3-cdc.rules /etc/udev/rules.d/
    sudo udevadm control --reload-rules
    sudo udevadm trigger

    # run echo

    # 添加工作空间路径到bashrc文件

    # echo 'source ~/ros2_tb3_ws/install/setup.bash' >> ~/.bashrc
    # echo 'source ~/ros2_tb3_ws/install/setup.bash' >> ~/.bashrc

    #run echo

    # 添加ROS_DOMAIN_ID到bashrc文件

    # echo 'export ROS_DOMAIN_ID=30 #TURTLEBOT3' >> ~/.bashrc

    # export GAZEBO_MODEL_PATH
    # echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ros2_tb3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models' >> ~/.bashrc

    # export TURTLEBOT3_MODEL
    # echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc

    #run source

    # 加载工作空间到当前环境
    sh -c "~/commands/ros_easy/shell/init_tb3.sh"
    source ~/.bashrc

fi