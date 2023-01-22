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
    cd ~
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
    # git checkout tags/1.0.0 -b release-1.0.0

    # If running tests or demos, also pull binary files with
    git lfs pull --exclude="" --include="*"

    # Troubleshooting
    # https://autowarefoundation.gitlab.io/autoware.auto/AutowareAuto/installation-no-ade.html
    export COLCON_DEFAULTS_FILE=$HOME/AutowareAuto/tools/ade_image/colcon-defaults.yaml

    sudo apt purge -y ros-foxy-autoware-auto-msgs
    sudo apt purge -y ros-foxy-acado-vendor
    sudo apt install -y ros-foxy-acado-vendor

    cd ~/AutowareAuto
    rm -rf build/ install/ log/

    pip install gitpython==3.1.14

    # SPINNAKER SDK not found, so spinnaker_camera_nodes could not be built.
    # https://www.flir.com/support-center/iis/machine-vision/downloads/spinnaker-sdk-and-firmware-download/
    # spinnaker-3.0.0.118-amd64-pkg.tar.gz
    # tar -zxvf     spinnaker-3.0.0.118-amd64-pkg.tar.gz
    # cd spinnaker-3.0.0.118-amd64
    # ./install_spinnaker.sh

    sudo apt install ros-foxy-filters
    sudo apt install ros-foxy-tvm-vendor
    sudo apt install ros-foxy-ackermann-msgs
    # https://osqp.org/docs/get_started/sources.
    if [ ! -d /usr/local/include/osqp ]; then
        pwd=$(pwd)
        sudo sh -c "$pwd/../ros2_autoware/shell/install_osqp.sh"         
    fi    

    sudo apt install ros-foxy-osqp-vendor

    if [ ! -d ~/AutowareAuto/src/external/grid_map ]; then
        cd ~/AutowareAuto/src/external/
        git clone -b foxy-devel https://ghproxy.com/https://github.com/ANYbotics/grid_map
    fi    

    #googletest ament_add_google_benchmark
    #   Unknown CMake command "ament_add_google_benchmark".
    # -- Installing: /usr/local/include/benchmark
    if [ ! -d /usr/local/include/benchmark ]; then
        pwd=$(pwd)
        sudo sh -c "$pwd/../ros2_autoware/shell/install_google_benchmark.sh"           
    fi     

    sudo apt install ros-foxy-octomap
    sudo apt install ros-foxy-octomap-msgs 
    sudo apt install ros-foxy-nav2-costmap-2d
    sudo apt install ros-foxy-point-cloud-msg-wrapper

    # \\wsl$\Ubuntu-20.04\home\ubuntu\AutowareAuto\src\planning\costmap_generator\package.xml
    # GridMapRosConverter.hpp: No such file or directory
    #    23 | #include "grid_map_cv/grid_map_cv.hpp" 
    #   <depend>grid_map_cv</depend>

    #    28 | #include <raptor_dbw_msgs/msg/accelerator_pedal_cmd.hpp>
    sudo apt install ros-foxy-raptor-dbw-msgs
    
    # \\wsl$\Ubuntu-20.04\home\ubuntu\AutowareAuto\src\drivers\ne_raptor_interface\CMakeLists.
    # kill test


    # --- stderr: filter_node_base
    # ** WARNING ** io features related to openni will be disabled
    # ** WARNING ** io features related to openni2 will be disabled
    # ** WARNING ** io features related to pcap will be disabled
    # ** WARNING ** io features related to png will be disabled
    # ** WARNING ** io features related to libusb-1.0 will be disabled
    # ** WARNING ** visualization features related to openni will be disabled
    # ** WARNING ** visualization features related to openni2 will be disabled
    # ** WARNING ** apps features related to openni will be disabled
    # ---

    #openni2_camera
    # git clone -b ros2 https://ghproxy.com/https://github.com/mikeferguson/openni2_camera

    #for pcap
    sudo apt install libpcap0.8-dev

    #   apollo_lidar_segmentation not found, skipping package.
    #   Neural network not found, skipping package.

    # Argument QP_SOLVER not set, using default of QPOASES
    # QP solver QPOASES is not recommended!
    
    # #To build all packages in Autoware.Auto, navigate into the AutowareAuto directory and run
    # colcon build
    colcon build --cmake-args -DBUILD_TESTING=OFF
    colcon test
    colcon test-result --verbose
}

install_autoware_source

