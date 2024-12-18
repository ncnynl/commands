#!/bin/bash

# 获取代理列表
# curl -s https://www.free-proxy-list.net/ | grep -oP '(\d{1,3}\.){3}\d{1,3}:\d{1,5}' | sort -u > proxy_list.txt

wget -q -O proxy_page.html https://www.free-proxy-list.net/

grep -oP '(\d{1,3}\.){3}\d{1,3}:\d{1,5}' proxy_page.html | sort -u > proxy_list.txt