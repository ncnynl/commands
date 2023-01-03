#!/bin/bash
################################################
# Function : install_robots_ros_org.sh                              
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
# https://www.cyberciti.biz/faq/how-to-set-up-wireguard-firewall-rules-in-linux/
# echo "Not Supported Yet!"
# exit 0         
#for ubuntu20.04 / 22.04

#/etc/wireguard
if [ ! -d /etc/wireguard/helper/ ];then 
    sudo mkdir -p /etc/wireguard/helper/
fi

#chmod perm
sudo chmod 777 /etc/wireguard/helper/

#vars
IPT="/sbin/iptables"
IPT6="/sbin/ip6tables" 
# IN_FACE="eth0"                   # NIC connected to the internet
IN_FACE="wlp0s20f3"              # NIC connected to the internet
WG_FACE="wg0"                    # WG NIC 
SUB_NET="192.168.6.0/24"         # WG IPv4 sub/net aka CIDR
WG_PORT="41194"                  # WG udp port
# SUB_NET_6="fd42:42:42:42::/112"  # WG IPv6 sub/net

#add file /etc/wireguard/helper/add-nat-routing.sh
echo "
#!/bin/bash
## IPv4 ##
$IPT -t nat -I POSTROUTING 1 -s $SUB_NET -o $IN_FACE -j MASQUERADE
$IPT -I FORWARD -s $SUB_NET -i wg0 -d $SUB_NET -j ACCEPT
## $IPT -I INPUT 1 -i $WG_FACE -j ACCEPT
## $IPT -I FORWARD 1 -i $IN_FACE -o $WG_FACE -j ACCEPT
## $IPT -I FORWARD 1 -i $WG_FACE -o $IN_FACE -j ACCEPT
## $IPT -I INPUT 1 -i $IN_FACE -p udp --dport $WG_PORT -j ACCEPT

## IPv6 (Uncomment) ##
## $IPT6 -t nat -I POSTROUTING 1 -s $SUB_NET_6 -o $IN_FACE -j MASQUERADE
## $IPT6 -I FORWARD -s $SUB_NET -i wg0 -d $SUB_NET -j ACCEPT
## $IPT6 -I INPUT 1 -i $WG_FACE -j ACCEPT
## $IPT6 -I FORWARD 1 -i $IN_FACE -o $WG_FACE -j ACCEPT
## $IPT6 -I FORWARD 1 -i $WG_FACE -o $IN_FACE -j ACCEPT
" | sudo tee /etc/wireguard/helper/add-nat-routing.sh

#/etc/wireguard/helper/remove-nat-routing.sh
echo "
#!/bin/bash

# IPv4 rules #
$IPT -t nat -D POSTROUTING -s $SUB_NET -o $IN_FACE -j MASQUERADE
$IPT -D FORWARD -s $SUB_NET -i wg0 -d $SUB_NET -j ACCEPT 
## $IPT -D INPUT -i $WG_FACE -j ACCEPT
## $IPT -D FORWARD -i $IN_FACE -o $WG_FACE -j ACCEPT
## $IPT -D FORWARD -i $WG_FACE -o $IN_FACE -j ACCEPT
## $IPT -D INPUT -i $IN_FACE -p udp --dport $WG_PORT -j ACCEPT


# IPv6 rules (uncomment) #
## $IPT6 -t nat -D POSTROUTING -s $SUB_NET_6 -o $IN_FACE -j MASQUERADE
## $IPT6 -D FORWARD -s $SUB_NET -i wg0 -d $SUB_NET -j ACCEPT 
## $IPT6 -D INPUT -i $WG_FACE -j ACCEPT
## $IPT6 -D FORWARD -i $IN_FACE -o $WG_FACE -j ACCEPT
## $IPT6 -D FORWARD -i $WG_FACE -o $IN_FACE -j ACCEPT
" | sudo tee /etc/wireguard/helper/remove-nat-routing.sh

#/etc/sysctl.d/10-wireguard.conf 
echo " 
net.ipv4.ip_forward=1
net.ipv6.conf.all.forwarding=1
" | sudo tee /etc/sysctl.d/10-wireguard.conf

#
sudo sysctl -p /etc/sysctl.d/10-wireguard.conf

#perm to exec
sudo chmod -v +x /etc/wireguard/helper/*.sh

#input Desktop/client's PublicKey
CHOICE_A=$(echo -e "\n Please Input Ubuntu Desktop/client's PublicKey:")
read -p "${CHOICE_A}" My_Linux_Desktop_KEY

#use *.sh 
if [ -f /etc/wireguard/wg0.conf ];then
    sudo sed -i 's/\#PostUp/PostUp/'g /etc/wireguard/wg0.conf
    sudo sed -i 's/\#PostDown/PostDown/'g /etc/wireguard/wg0.conf
    sudo sed -i 's/\#\[Peer\]/\[Peer\]/'g /etc/wireguard/wg0.conf
    sudo sed -i 's/\#PublicKey/PublicKey/'g /etc/wireguard/wg0.conf
    sudo sed -i 's/\#AllowedIPs/AllowedIPs/'g /etc/wireguard/wg0.conf
    sudo sed -i "s?My_Linux_Desktop_KEY?$My_Linux_Desktop_KEY?g" /etc/wireguard/wg0.conf
fi 

#restart
sudo systemctl restart wg-quick@wg0.service
