#!/bin/bash
################################################
# Function : install_pyinstaller                              
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

sudo apt install zlib1g-dev

#pyqt5
sudo python3 -m pip install --upgrade pip
sudo pip3 install pyqt5==5.15.2
sudo apt install pyqt5*
sudo apt install qt5-default qttools5-dev-tools

#apt issue
cd /usr/lib/python3/dist-packages
sudo cp apt_pkg.cpython-36m-x86_64-linux-gnu.so apt_pkg.cpython-38m-x86_64-linux-gnu.so
sudo cp apt_pkg.cpython-36m-x86_64-linux-gnu.so apt_pkg.so

#gi issue
cd /usr/lib/python3/dist-packages/gi/
sudo cp _gi.cpython-36m-x86_64-linux-gnu.so _gi.cpython-38m-x86_64-linux-gnu.so
sudo cp _gi_cairo.cpython-36m-x86_64-linux-gnu.so _gi_cairo.cpython-38m-x86_64-linux-gnu.so
#https://blog.csdn.net/qq_30065853/article/details/122414615

#upgrade

sudo apt-get install libgirepository1.0-dev python-cairo libcairo2 libcairo2-dev pkg-config
python3 -m pip install -U pycairo
sudo python3.8 -m pip install --ignore-installed PyGObject


#install pyinstaller
cd ~
wget -O pyinstaller.tar.gz  https://github.com/pyinstaller/pyinstaller/tarball/develop
tar -zxvf pyinstaller.tar.gz
cd bootloader
python3 ./waf distclean all
cd ..
sudo python3 setup.py install

