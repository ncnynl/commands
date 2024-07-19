#!/bin/sh
################################################################
# Function :GPU Commands Manager Shell Utils Script                
# Platform :All Linux Based Platform                           
# Version  :1.1                                                
# Date     :2024-07-19                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################

source ${HOME}/commands/cs_variables.sh

# 检查 NVIDIA GPU
check_nvidia_gpu() {
    if lspci | grep -i nvidia > /dev/null 2>&1; then
        echo "NVIDIA GPU detected."
        return 0
    else
        echo "No NVIDIA GPU detected."
        return 1
    fi
}

# 检查 nvidia-smi 命令
check_nvidia_smi() {
    if command -v nvidia-smi > /dev/null 2>&1; then
        if nvidia-smi > /dev/null 2>&1; then
            echo "nvidia-smi command is available and NVIDIA GPU is functioning."
            return 0
        else
            echo "nvidia-smi command is available but NVIDIA GPU is not functioning properly."
            return 1
        fi
    else
        echo "nvidia-smi command not found."
        return 1
    fi
}

# 检查 OpenGL renderer
check_opengl_renderer() {
    if command -v glxinfo > /dev/null 2>&1; then
        if glxinfo | grep "OpenGL renderer" > /dev/null 2>&1; then
            echo "OpenGL renderer detected."
            return 0
        else
            echo "No OpenGL renderer detected."
            return 1
        fi
    else
        echo "glxinfo command not found."
        return 1
    fi
}

# 检查 OpenCL 支持
check_opencl() {
    if command -v clinfo > /dev/null 2>&1; then
        if clinfo > /dev/null 2>&1; then
            echo "OpenCL support detected."
            return 0
        else
            echo "No OpenCL support detected."
            return 1
        fi
    else
        echo "clinfo command not found."
        return 1
    fi
}

# 检查 CUDA 支持
check_cuda() {
    if command -v nvcc > /dev/null 2>&1; then
        if nvcc --version > /dev/null 2>&1; then
            echo "CUDA support detected."
            return 0
        else
            echo "No CUDA support detected."
            return 1
        fi
    else
        echo "nvcc command not found."
        return 1
    fi
}

# # 主函数
# main() {
#     echo "Checking GPU support..."
    
#     check_nvidia_gpu && check_nvidia_smi && check_opengl_renderer && check_opencl && check_cuda
    
#     if [ $? -eq 0 ]; then
#         echo "GPU support is confirmed."
#     else
#         echo "GPU support is not available."
#     fi
# }

# # 运行主函数
# main
