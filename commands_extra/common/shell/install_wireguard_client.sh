#!/bin/bash
################################################
# Function : install wireguard client
# Desc     : 用于安装异域局域网软件wireguard客户端的脚本                              
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


#input server PublicKey
CHOICE_A=$(echo -e "\n Please Input Ubuntu VPN server public key:")
read -p "${CHOICE_A}" PUK

CHOICE_B=$(echo -e "\n Please Input Ubuntu VPN server public IPv4/IPv6 address:")
read -p "${CHOICE_B}" EP

#build wg0.conf
echo "
[Interface]
## This Desktop/client's private key ##
PrivateKey = $PRK
 
## Client ip address ##
Address = 192.168.6.2/24

## DNS server for WG client #
## Syntax is
## DNS = 1.1.1.1, 8.8.8.8
## I am setting my VLAN's DNS but you can use Google, CF, IBM or anything that works with your WG #
DNS = 8.8.8.8
 
[Peer]
## Ubuntu 20.04 server public key ##
PublicKey = $PUK
 
## set ACL ##
#################################################
## Allow remote server as gateway 
## Edit/Update old AllowedIPs entry as follows 
## Otherwise client won't show server's IP 
#################################################
AllowedIPs = 0.0.0.0/0
 
## Your Ubuntu 20.04 LTS server's public IPv4/IPv6 address and port ##
Endpoint = $EP:41194
 
##  Key connection alive ##
PersistentKeepalive = 15
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