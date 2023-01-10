#!/bin/bash
new_ip=<wsl_ip>
brd=<wsl_netmask>
gateway=<wsl_gateway>
nameserver=<wsl_gateway>
net_dev=eth0
sudo -S ip addr del $(ip addr show $net_dev | grep 'inet\b' | awk '{print $2}' | head -n 1) dev $net_dev
sudo ip addr add $new_ip/24 broadcast $brd dev $net_dev
sudo ip route add 0.0.0.0/0 via $gateway dev $net_dev
echo "nameserver $nameserver" | tee /etc/resolv.conf
