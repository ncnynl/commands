#!/bin/bash
################################################
# Function : Update python source shell  
# Desc     : 用于更新Python源的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-24 15:17:32                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Update python source shell")"         

#run mkdir

# 新建目录
if [ ! -f ~/.pip/pip.conf ];then
    if [ ! -d ~/.pip ];then 
        mkdir ~/.pip
    fi 
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
SKYBLUE='\033[0;36m'
PLAIN='\033[0m'

setDefault()
{
	if [[ -f ~/.pip/pip.conf.bak ]]; then
		echo -e " ${GREEN}pip.conf.bak exists${PLAIN}"
	else
		mv ~/.pip/pip.conf{,.bak}
	fi    

    echo "[global]" > ~/.pip/pip.conf
    echo "index-url=https://pypi.org/simple" >> ~/.pip/pip.conf
    echo "[install]" >> ~/.pip/pip.conf
    echo "trusted-host=pypi.org" >> ~/.pip/pip.conf
}

setDouban()
{
    sed -i 's/pypi.org/pypi.doubanio.com/'g ~/.pip/pip.conf
}

setTsinghua(){
	sed -i 's/pypi.org/pypi.tuna.tsinghua.edu.cn/'g ~/.pip/pip.conf
}

setUstc(){
	sed -i 's/pypi.org/pypi.mirrors.ustc.edu.cn/'g ~/.pip/pip.conf
}

setAliyun(){
    echo "[global]" > ~/.pip/pip.conf
    echo "index-url=https://mirrors.aliyun.com/pypi/simple" >> ~/.pip/pip.conf
    echo "[install]" >> ~/.pip/pip.conf
    echo "trusted-host=mirrors.aliyun.com" >> ~/.pip/pip.conf
}

restore(){
	if [ -f ~/.pip/pip.conf ]; then
		rm ~/.pip/pip.conf
		mv ~/.pip/pip.conf.bak ~/.pip/pip.conf
	fi
}

setSources(){
	echo "请问你需要变更Python源吗? 不需要的话，直接回车即可"
	echo "Pypi官方源请输入 - pypi"
	echo "豆瓣源请输入 - douban"
	echo "清华大学源请输入 - tsinghua"
	echo "中国科学技术大学源请输入 - ustc"
	echo "阿里云源请输入 - aliyun"
	echo "恢复到上一次 - restore"
	CHOICE_A=$(echo -e "\n Please input source ：")
	read -p "${CHOICE_A}" para			
	case $para in
		'pypi'|'-pypi'|'--pypi' )
			setDefault;;
		'ustc'|'-ustc'|'--ustc' )
			setDefault;setUstc;;
		'tsinghua'|'-tsinghua'|'--tsinghua' )
			setDefault;setTsinghua;;		
		'douban'|'-douban'|'--douban' )
			setDefault;setDouban;;	              	
		'aliyun'|'-aliyun'|'--aliyun' )
			setDefault;setAliyun;;	
		'restore'|'-restore'|'--restore' )
			restore;;
		*);;
	esac

    echo "Have changed to :"
    pip3 config list   
}

para=$1
setSources

echo -e "${GREEN}Done${PLAIN}"