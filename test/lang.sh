#!/bin/bash
################################################################
# Function :Language             #
# Desc     :测试多语言                                    #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2023-03-06                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

alias GETTEXT='gettext "commands"'
alias ll="ls -la"

HELLO_WORLD=$(GETTEXT "Hello")
echo "$HELLO_WORLD"

echo "$(GETTEXT "Press any key to continue")"

ll 

# xgettext -o commands.pot -L Shell --keyword=GETTEXT lang.sh menu.sh
# xgettext -o commands.pot -L Shell --keyword=GETTEXT lang.sh menu.sh

# msginit -i commands.pot -o commands.po -l zh_CN

# msgfmt -o commands.mo commands.po

# sudo cp commands.mo /usr/share/locale/zh_CN/LC_MESSAGES/


# export LANG=zh_CN.UTF-8
# export LANG=en_US.UTF-8
