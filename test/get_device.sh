#!/bin/bash
################################################
# Function : sd system backup  
# Desc     : 用于DD备份SD卡的系统并进行gz压缩                            
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
function sd_system_backup(){
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
        sd_system_backup
    else
        if [ ! -e $dev_name ];then 
            echo "Your device name can not exists"
            sd_system_backup
        else 
            echo "Your device name is: $dev_name"
        fi
        
    fi  

    CHOICE_B=$(echo -e "\n Please input your package name (like ros-easy-rpi) ：")
    read -p "${CHOICE_B}" package_name
    if [ ! $package_name ]; then
        sd_system_backup
    else
        echo "Your package name is: $dev_name"
    fi 


    path="$PWD/$package_name-"`date +%Y-%m-%d`.gz
    echo $path 
    echo "Start backup $dev_name to $path"
    sudo dd bs=4M if=$dev_name | gzip > $path 

}

sd_system_backup