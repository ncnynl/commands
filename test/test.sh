#!/bin/bash
#export TEXTDOMAINDIR=/usr/share/locale
#export TEXTDOMAIN=commands
#echo "$(gettext "hello")"

# msgfmt -o test.sh.mo test.sh.zh_CN.po
# sudo mv test.sh.mo /usr/share/locale/zh_CN/LC_MESSAGES/

# msgfmt -o test.sh.mo test.sh.en.po
# sudo cp test.sh.mo /usr/share/locale/en/LC_MESSAGES/
# sudo mv test.sh.mo /usr/share/locale/en/LC_MESSAGES/

# export TEXTDOMAINDIR=/usr/share/locale

# export LANG=zh_CN.UTF-8

# export LANG=

# export LC_ALL="it_IT.UTF-8"

# locale

# sudo locale-gen "en_HK.UTF-8"

# sudo locale-gen "zh_CN.UTF-8"

# sudo dpkg-reconfigure locales

#file_name="/home/ubuntu/commands/ros_easy/shell/load_ros4.sh"
## sed -i -e "/$file_name/d" ./del_string.txt
#echo $file_name
#echo ${file_name##*/}

rsync_exits=$(which is rsyn)
if [ $rsync_exits ]; then 
  	echo "rsync exits"
else 
	echo "rsync is not exits"
fi
