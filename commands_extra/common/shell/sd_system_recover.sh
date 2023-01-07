#!/bin/bash
################################################
# Function : sd system backup  
# Desc     : 用于把压缩的GZ镜像系统并恢复到SD卡                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-25 17:12:05                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
# sudo dd bs=4M if=/dev/sdb | gzip > /home/your_username/image`date +%d%m%y`.gz
# sudo gzip -dc /home/your_username/image.gz | dd bs=4M of=/dev/sdb
function sd_system_recover(){
    DEVICES=(
    /dev/sd
    /dev/nvm
    )


    echo "Have devices:"
    for dev in ${DEVICES[@]}
    do
        echo "$dev:"
        dev_info=$(sudo fdisk -l | grep "Disk $dev")
        echo "---$dev_info" 
    done

    CHOICE_A=$(echo -e "\n Please input your device name (like /dev/sda) ：")
    read -p "${CHOICE_A}" dev_name
    if [ ! $dev_name ]; then
        echo "Your device name can not be null"
        sd_system_recover
    else
        if [ ! -e $dev_name ];then 
            echo "Your device name can not exists"
            sd_system_recover
        else 
            echo "Your device name is: $dev_name"
        fi
        
    fi 

    CHOICE_B=$(echo -e "\n Please input your package name (like /home/ubuntu/tools/image.gz) ：")
    read -p "${CHOICE_B}" package_name
    if [ ! -f $package_name ]; then
        sd_system_recover
    else
        echo "Your package name is: $package_name"
    fi 

    echo "Start recover $package_name  to $dev_name"
    sudo gzip -dc $package_name | dd bs=4M of=$dev_name

}

sd_system_recover