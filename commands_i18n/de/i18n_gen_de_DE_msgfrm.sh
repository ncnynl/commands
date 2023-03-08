#!/bin/bash
################################################################
# Function :i18n gen zh_CN  msgfrm          #
# Desc     :gen language zh_CN msgfrm                             #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2023-03-06                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################
echo "msgfmt handle"
msgfmt -o commands.mo commands.po

echo "cp to locale"
sudo cp commands.mo /usr/share/locale/de/LC_MESSAGES/

echo "Done!!"

