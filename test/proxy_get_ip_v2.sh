#!/bin/bash

curl -s "https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all" > proxy_list_v2.txt