#!/bin/bash
################################################################
# Function :i18n             #
# Desc     :gen language template                              #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2023-03-06                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

echo "xgettext handle , to get template for commands"

xgettext -o commands.pot -L Shell --keyword=gettext ../commands_extra/cs.sh \
 ../commands_extra/common/shell/check_linux_version.sh


 echo "......Done!!......"

