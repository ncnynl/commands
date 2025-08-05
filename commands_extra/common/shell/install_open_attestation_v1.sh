#!/bin/bash
################################################################
# Function : install_open_attestation_v1 
# Desc     : 安装open-attestation npm version                      
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2025-08-02                           
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_open_attestation_v1")"

echo "💡 开始安装 OpenAttestation CLI..."

# Step 1: 安装 nvm（如未安装）
if [ -z "$NVM_DIR" ]; then
  echo "📦 安装 nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  # shellcheck source=/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Step 2: 安装 Node.js 18（推荐版本）
echo "🔧 安装 Node.js v18..."
nvm install 18
nvm use 18
nvm alias default 18

# Step 3: 安装 OpenAttestation CLI
echo "🧰 安装 @govtechsg/open-attestation-cli..."
npm install -g @govtechsg/open-attestation-cli  @govtechsg/open-attestation  ethers

# Step 4: 验证安装结果
echo "✅ 验证 OpenAttestation CLI 安装成功："
open-attestation -h
