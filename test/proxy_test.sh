#!/bin/bash

source ${HOME}/commands/cs_utils.sh

re=$(check_github)
echo $re

# re=$(check_github_with_prefix_proxy https://gh-proxy.com)
# echo $re

# file_path="${HOME}/tools/commands/test/proxy_bashrc.sh"

# echo $file_path
# re=$(check_file_with_github $file_path)
# echo $re

# file_path="${HOME}/tools/commands/test/proxy_bashrc.sh"
# # 删除代理行
# sed -i '/^export http_proxy=/d'  $file_path
# sed -i '/^export https_proxy=/d' $file_path