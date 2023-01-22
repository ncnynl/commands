#!/bin/bash
################################################
# Function : install autoware source  
# Desc     : 用于安装autoware源码版本的脚本                           
# Platform : WSL2 / ubuntu                                
# Version  : 1.0                               
# Date     : 2022-01-21                             
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
# https://autowarefoundation.gitlab.io/autoware.auto/AutowareAuto/installation-ade.html
# https://ade-cli.readthedocs.io/en/latest/install.html#linux-x86-64-and-aarch64
# https://www.php.cn/blog/detail/35668.
# https://autowarefoundation.gitlab.io/autoware.auto/AutowareAuto/building.html
echo "Install autoware source version ...."

function install_autoware_source()
{

    echo "Install deps, Need git lfs / vcs "
    if ! command -v "vcs" > /dev/null 2>&1; then 
        echo "vcs is not exists, Install now"
        sudo apt install python3-vcstool
    fi 

    if ! command -v "git-lfs" > /dev/null 2>&1; then 
        echo "git-lfs is not exists, Install now"
        pwd=$(pwd)
        sudo sh -c "$pwd/../common/shell/install_gitlfs.sh"
    fi     

    if ! command -v "rosdep" > /dev/null 2>&1; then 
        echo "rosdep is not exists, Install now"
        pwd=$(pwd)
        sudo sh -c "$pwd/../common/shell/update_rosdep_tsinghua.sh"
    fi 


    #host
    export ROS_DISTRO=foxy
    echo $ROS_DISTRO

    #ROS2安装完成后, 设置环境变量
    if [ ! -d /opt/ros/foxy/ ];then 
        echo "Please install foxy first" 
        exit 0
    else
        source /opt/ros/foxy/setup.bash
    fi 
    
    #将ROS环境变量添加到bashrc文件里面
    source ~/.bashrc

    #安装Autoware.Auto依赖的ROS2的其它包，rosdep会自动搜索安装
    mkdir -p ~/adehome
    cd ~/adehome
    touch .adehome
    git clone https://gitlab.com/autowarefoundation/autoware.auto/AutowareAuto.git
    cd AutowareAuto
    vcs import < autoware.auto.$ROS_DISTRO.repos
    export ROS_VERSION=2

    #rosdep 一次安装src下所有依赖
    export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml
    rosdep update
    rosdep install --reinstall -y -i --from-paths src

    #目的是切换想要安装的autoware版本，如果不切换master将使用最新分支
    #Checkout the latest release by checking out the corresponding tag or release branch.
    git checkout tags/1.0.0 -b release-1.0.0

    # If running tests or demos, also pull binary files with
    git lfs pull --exclude="" --include="*"

    #共享环境变量
    cd ~
    cp ~/.bashrc ~/.bashrc.bk
    mv ~/.bashrc ~/adehome/.bashrc
    ln -s ~/adehome/.bashrc

    # Troubleshooting
    # https://autowarefoundation.gitlab.io/autoware.auto/AutowareAuto/installation-no-ade.html
    sudo apt purge -y ros-foxy-autoware-auto-msgs
    sudo apt purge -y ros-foxy-acado-vendor
    sudo apt install -y ros-foxy-acado-vendor

    #打开一个干净的ade容器进行编译
    #Open Docker, only if is not running
    if curl -s --unix-socket /var/run/docker.sock http/_ping 2>&1 >/dev/null
    then
        echo "Docker Deamon is running"
    else
        echo "Docker Deamon is not running"
        sudo service docker start 
    fi

    cd ~/adehome/AutowareAuto
    ade stop
    sudo ade update-cli
    ade --rc .aderc-amd64-foxy-lgsvl start --update --enter

    #inside ade
    echo "Please see install script base ros2_autoware_source_foxy.sh to install left inside ade!!!"
    # export COLCON_DEFAULTS_FILE=/usr/local/etc/colcon-defaults.yaml
    # echo "export COLCON_DEFAULTS_FILE=/usr/local/etc/colcon-defaults.yaml" >> ~/.bashrc
    # cd AutowareAuto
    # rm -rf build/ install/ log/

    # #To build all packages in Autoware.Auto, navigate into the AutowareAuto directory and run
    # colcon build
    # colcon test
    # colcon test-result --verbose

}

install_autoware_source

