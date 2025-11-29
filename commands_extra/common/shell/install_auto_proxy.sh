#!/bin/bash
################################################
# Function : auto_proxy Auto find free proxies and set system proxy
# Desc     : 自动抓取免费代理 → 测速 → 生成可用列表 → 
#            选择最快代理 → 配置为系统/Git 代理
# Platform : Ubuntu / Debian / Raspberry Pi / CentOS
# Version  : 1.1
# Date     : 2025-11-26
# Author   : ncnynl
# Contact  : 1043931@qq.com
# URL      : https://ncnynl.com
################################################

WORKDIR="/tmp/auto_proxy"
mkdir -p $WORKDIR
RAW="$WORKDIR/proxies_raw.txt"
GOOD="$WORKDIR/proxies_good.txt"

> "$RAW"
> "$GOOD"

###############################################
# 1. 获取免费代理列表
###############################################
echo "[1/4] 抓取免费代理..."

SOURCES=(
  "https://www.proxy-list.download/api/v1/get?type=http"
  "https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/http.txt"
  "https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all"
)

for url in "${SOURCES[@]}"; do
    curl -s "$url" >> "$RAW"
done

sort -u "$RAW" -o "$RAW"  # 去重


###############################################
# 2. 测试代理速度（访问 GitHub）
###############################################
echo "[2/4] 测试代理可用性与速度..."

test_proxy_speed() {
    proxy=$1
    START=$(date +%s%3N)
    curl -x "http://$proxy" -Is --max-time 3 https://github.com > /dev/null
    if [[ $? -eq 0 ]]; then
        END=$(date +%s%3N)
        SPEED=$((END - START))
        echo "$proxy $SPEED" >> "$GOOD"
        echo "可用代理：$proxy 延迟：${SPEED}ms"
    fi
}

while read -r proxy; do
    if [[ -n "$proxy" ]]; then
        test_proxy_speed "$proxy" &
    fi
done < "$RAW"

wait

if [[ ! -s "$GOOD" ]]; then
    echo "未找到可用代理，退出"
    exit 1
fi


###############################################
# 3. 按速度排序并选出最快代理
###############################################
echo "[3/4] 排序可用代理..."

sort -k2 -n "$GOOD" -o "$GOOD"

FASTEST=$(head -n 1 "$GOOD" | awk '{print $1}')
FASTEST_SPEED=$(head -n 1 "$GOOD" | awk '{print $2}')

echo "最快代理：$FASTEST (${FASTEST_SPEED}ms)"


###############################################
# 4. 设置系统代理与 Git 代理
###############################################
echo "[4/4] 设置系统代理..."

# 环境变量
export http_proxy="http://$FASTEST"
export https_proxy="http://$FASTEST"

# 写入持久化系统代理
cat <<EOF | sudo tee /etc/profile.d/proxy.sh >/dev/null
export http_proxy="http://$FASTEST"
export https_proxy="http://$FASTEST"
export HTTP_PROXY="http://$FASTEST"
export HTTPS_PROXY="http://$FASTEST"
EOF

# Git 代理
git config --global http.proxy "http://$FASTEST"
git config --global https.proxy "http://$FASTEST"

echo "系统代理与 Git 代理已设置为：$FASTEST"
echo "可用代理列表保存在：$GOOD"
echo "完成。"
