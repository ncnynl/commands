#!/bin/bash
################################################
# Function : install google benchmark   
# Desc     : 用于安装google benchmark的脚本                           
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

# https://github.com/osqp/osqp/releases/download/v0.6.2/complete_sources.tar.gz
# https://osqp.org/docs/get_started/sources.html#install-the-binaries

echo "Install google benchmark ...."

function install_google_benchmark()
{

    # Check out the library.
    cd ~/tools
    git clone https://ghproxy.com/https://github.com/google/benchmark.git
    # Go to the library root directory
    cd benchmark
    git clone https://ghproxy.com/https://github.com/google/googletest
    # Make a build directory to place the build output.
    cmake -E make_directory "build"
    # Generate build system files with cmake, and download any dependencies.
    cmake -E chdir "build" cmake -DBENCHMARK_DOWNLOAD_DEPENDENCIES=on -DCMAKE_BUILD_TYPE=Release ../
    # or, starting with CMake 3.13, use a simpler form:
    # cmake -DCMAKE_BUILD_TYPE=Release -S . -B "build"
    # Build the library.
    # sudo cmake --build "build" --config Release
    sudo cmake --build "build" --config Release --target install
}
install_google_benchmark