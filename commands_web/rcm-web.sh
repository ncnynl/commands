#!/bin/bash

URL="http://localhost:5051"
if which xdg-open > /dev/null; then 
    xdg-open "$URL" &
elif which gnome-open > /dev/null; then 
    xdg-open "$URL" &
elif which open > /dev/null; then 
    open "$URL" &
else
    echo "无法找到合适的命令来打开浏览器"
fi