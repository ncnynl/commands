#!/bin/bash
################################################
# Function : Update GO source shell  
# Desc     : 用于更新GO源的脚本                              
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
echo "$(gettext "Update go source shell")"         

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
SKYBLUE='\033[0;36m'
PLAIN='\033[0m'

setDefault()
{
	if ! grep -Fq "GOPROXY=" ~/.bashrc
	then
		echo "go env -w  GOPROXY=https://goproxy.io,direct" >> ~/.bashrc
		echo "GOPROXY env have installed successfully! writed to ~/.bashrc"
	else
		proxy="goproxy.io"
		sed -i "s/GOPROXY=https:\/\/.*,direct/GOPROXY=https:\/\/$proxy,direct/"g ~/.bashrc		
	fi
}

# 七牛 CDN
setQiniu()
{
	proxy="goproxy.cn"
	sed -i "s/GOPROXY=https:\/\/.*,direct/GOPROXY=https:\/\/$proxy,direct/"g ~/.bashrc
}

# 阿里云
setAliyun(){
	proxy="mirrors.aliyun.com\/goproxy\/"
	sed -i "s/GOPROXY=https:\/\/.*,direct/GOPROXY=https:\/\/$proxy,direct/"g ~/.bashrc
}

setSources(){
	echo "请问你需要变更GO源? 不需要的话，直接回车即可"
	echo "GO官方源请输入 - go"
	echo "七牛GO源请输入 - qiniu"
	echo "阿里云GO源请输入 - aliyun"
	CHOICE_A=$(echo -e "\n Please input source ：")
	read -p "${CHOICE_A}" para			
	case $para in
		'go'|'-go'|'--go' )
			setDefault;;
		'qiniu'|'-qiniu'|'--qiniu' )
			setDefault;setQiniu;;
		'aliyun'|'-aliyun'|'--aliyun' )
			setDefault;setAliyun;;	
		*);;
	esac

    echo "Have changed to :"
	. ~/.bashrc
    go env | grep GOPROXY   
}

para=$1
setSources

echo -e "${GREEN}Done${PLAIN}"