#!/bin/bash
################################################################
# Function :i18n gen zh_CN msginit           #
# Desc     :gen language zh_CN msginit                             #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2023-03-06                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

echo "set UTF-8"
sed -i "s/charset=CHARSET/charset=UTF-8/"g  ../commands.pot

echo "msginit handle"
msginit -i ../commands.pot -o commands-new.po -l cs

echo "Done, Please modify and rename to commands.po"


