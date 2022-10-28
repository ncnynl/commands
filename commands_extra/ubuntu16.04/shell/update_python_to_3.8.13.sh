#!/bin/bash
################################################
# Function : update_python_to_3.8.13.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-25 18:08:16                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
#Not real test

#install dep 
sudo apt-get install zlib1g-dev libbz2-dev libssl-dev libncurses5-dev libsqlite3-dev

#get python3.8.13
wget https://www.python.org/ftp/python/3.8.13/Python-3.8.13.tar.xz

#tar 
tar -xvJf  Python-3.8.13.tar.xz

#upgrade
pip3 install --upgrade pip

# cd 
cd Python-3.8.13/

# make
./configure prefix=/usr/local/python3
sudo -s
make && make install

# ln 
sudo mv /usr/bin/python3 /usr/bin/python3.bak
sudo ln -s /usr/local/python3/bin/python3 /usr/bin/python3


