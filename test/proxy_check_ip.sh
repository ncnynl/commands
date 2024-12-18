#!/bin/bash

export http_proxy=""
export https_proxy=""

# 代理列表文件
PROXY_LIST="proxy_list.txt"
# 保存可用代理的文件
OUTPUT_FILE="proxy_list_ok.txt"
# GitHub URL
GITHUB_URL="https://github.com"
# 连接超时时间（秒）
CONNECT_TIMEOUT=5
# 最大请求时间（秒）
MAX_TIME=10

# 清空输出文件
> "$OUTPUT_FILE"

# 读取代理列表并测试每个代理
while IFS= read -r proxy; do
    echo "测试代理: $proxy"

    # 测试通过代理访问 GitHub
    if [ "$(curl -s --connect-timeout "$CONNECT_TIMEOUT" --max-time "$MAX_TIME" -o /dev/null -w "%{http_code}" --http2 --proxy "$proxy" "$GITHUB_URL")" == "200" ]; then
        echo "可用代理: $proxy"
        echo "$proxy" >> "$OUTPUT_FILE"  # 保存可用代理到文件
    else
        echo "不可用代理: $proxy"
    fi
done < "$PROXY_LIST"

echo "测试完成。可用代理已保存到 $OUTPUT_FILE。"


