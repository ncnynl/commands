#!/bin/bash
################################################
# Function : install wireguard server   
# Desc     : 用于安装异域局域网软件wireguard服务端的脚本                  
# Website  : https://www.ncnynl.com/archives/202212/5812.html         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-22                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
# https://www.cyberciti.biz/faq/ubuntu-20-04-set-up-wireguard-vpn-server/
# https://www.wireguard.com/quickstart/
# echo "Not Supported Yet!"
# exit 0         
#for ubuntu20.04 / 22.04

#install wireguard 
sudo apt update
sudo apt install wireguard wireguard-tools -y 

#/etc/wireguard
if [ ! -d /etc/wireguard ];then 
    sudo mkdir -p /etc/wireguard
fi

#genkey
sudo chmod 777 /etc/wireguard
cd /etc/wireguard
umask 077; sudo wg genkey | sudo tee privatekey | sudo wg pubkey > publickey

#view key 
ls -l privatekey publickey
PRK=$(cat privatekey)

#build wg0.conf
echo "
## Set Up WireGuard VPN on Ubuntu By Editing/Creating wg0.conf File ##
[Interface]
## My VPN server private IP address ##
Address = 192.168.6.1/24
 
## My VPN server port ##
ListenPort = 41194
 
## VPN server's private key i.e. /etc/wireguard/privatekey ##
PrivateKey = $PRK

#PostUp = /etc/wireguard/helper/add-nat-routing.sh
#PostDown = /etc/wireguard/helper/remove-nat-routing.sh

#[Peer]
#My Linux Desktop 
#PublicKey = My_Linux_Desktop_KEY
#AllowedIPs = 192.168.6.0/24
" | sudo tee /etc/wireguard/wg0.conf


#if ufw start
# sudo ufw status
# sudo ufw allow 41194/udp

#enable service
sudo systemctl enable wg-quick@wg0

#start service
sudo systemctl start wg-quick@wg0

#status service
# sudo systemctl status wg-quick@wg0


#Verify that interface named wg0 is up
sudo wg

#
sudo ip a show wg0