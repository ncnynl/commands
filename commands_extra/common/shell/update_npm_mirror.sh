#!/usr/bin/env bash
################################################
# Function : Update npm mirrors 
# Desc     : 用于更新NPM源的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-12-18                        
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Update NPM mirrors shell")"  

# 定义常见 npm 源
declare -A NPM_REGISTRIES=(
    ["1"]="https://registry.npmjs.org (官方源)"
    ["2"]="https://registry.npmmirror.com (淘宝镜像)"
    ["3"]="https://registry.yarnpkg.com (Yarn 源)"
    ["4"]="https://mirrors.tencent.com/npm/ (腾讯云)"
    ["5"]="https://r.cnpmjs.org/ (CNPM 镜像)"
)

# 显示可用的 npm 源选项
echo "请选择要配置的 npm 源："
for key in "${!NPM_REGISTRIES[@]}"; do
    echo "$key. ${NPM_REGISTRIES[$key]}"
done
echo "6. 自定义 npm 源"

# 提示用户选择
read -p "请输入编号 (默认: 2): " choice

# 默认选择淘宝镜像
if [[ -z "$choice" ]]; then
    choice="2"
fi

# 处理用户输入
if [[ "$choice" == "6" ]]; then
    # 自定义 npm 源
    read -p "请输入自定义的 npm 源地址: " CUSTOM_NPM_REGISTRY
    if [[ -n "$CUSTOM_NPM_REGISTRY" ]]; then
        SELECTED_REGISTRY=$CUSTOM_NPM_REGISTRY
    else
        echo "未输入有效地址，退出。"
        exit 1
    fi
else
    # 使用预设的 npm 源
    SELECTED_REGISTRY=$(echo "${NPM_REGISTRIES[$choice]}" | awk '{print $1}')
    if [[ -z "$SELECTED_REGISTRY" ]]; then
        echo "无效的选择，退出。"
        exit 1
    fi
fi

# 配置 npm 源
echo "正在配置 npm 源为: $SELECTED_REGISTRY"
npm config set registry $SELECTED_REGISTRY

# 验证设置是否成功
echo "验证配置..."
CURRENT_NPM_REGISTRY=$(npm config get registry)

if [[ "$CURRENT_NPM_REGISTRY" == "$SELECTED_REGISTRY" ]]; then
    echo "npm 源已成功配置为: $CURRENT_NPM_REGISTRY"
else
    echo "npm 源配置失败，请检查。"
fi

# 提示用户是否需要清理缓存
read -p "是否需要清理 npm 缓存？(y/n, 默认: n): " clear_cache
if [[ "$clear_cache" == "y" || "$clear_cache" == "Y" ]]; then
    echo "清理 npm 缓存..."
    npm cache clean --force
    echo "npm 缓存清理完成。"
fi

echo "配置完成！"
