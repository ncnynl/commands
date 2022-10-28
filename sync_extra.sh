#!/bin/bash
################################################################
# Function :Sync ~/commands/* to commands_extra                #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-27                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################


function sync_extra()
{
    echo "Begin to sync file to commands_extra!!"
    rsync -azv ~/commands/* ~/tools/commands/commands_extra/
    echo "Done!! Please submit to repo"
}
sync_extra