#!/bin/bash
################################################
# Function : Install LNMP-MYSQL 8.0.36
# Desc     : 源码编译安装 MySQL 8.0.36 + systemd服务注册
# Platform : Ubuntu
# Version  : 1.1
# Date     : 2025-10-29
# Author   : ncnynl
################################################
# MySQL 8.0.36 源码自动化安装脚本 for Ubuntu 24.04
set -e  # 遇到任何错误立即退出

echo "开始通过源码安装 MySQL 8.0.36..."

# 1. 安装必要的编译依赖
echo "安装编译依赖..."
sudo apt update
sudo apt install -y wget cmake build-essential libncurses5-dev libssl-dev pkg-config libtirpc-dev

# 2. 创建MySQL用户和组（如果不存在）
if ! id "mysql" &>/dev/null; then
    sudo groupadd mysql
    sudo useradd -r -g mysql -s /bin/false mysql
fi

# 3. 创建安装目录和数据目录
sudo mkdir -p /usr/local/mysql
sudo mkdir -p /usr/local/mysql/data

# 4. 下载MySQL 8.0.36源码包
echo "下载MySQL源码..."
cd /tmp/
if [ ! -f mysql-8.0.36.tar.gz ]; then 
  wget -O mysql-8.0.36.tar.gz "https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.36.tar.gz"
fi 
tar -xzf mysql-8.0.36.tar.gz

echo "📦 下载 Boost 1.77.0..."
mkdir -p "/tmp/boost"
cd /tmp/boost
[ -f boost_1_77_0.tar.bz2 ] || wget https://archives.boost.org/release/1.77.0/source/boost_1_77_0.tar.bz2
tar -xjf boost_1_77_0.tar.bz2

echo "📦 build mysql..."
cd /tmp/mysql-8.0.36

# 5. 创建编译目录并配置编译选项
if [ ! -d /tmp/mysql-8.0.36/build ]; then 
  mkdir build
fi
cd build 
echo "配置MySQL编译选项..."
cmake .. \
    -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
    -DMYSQL_DATADIR=/usr/local/mysql/data \
    -DWITH_INNOBASE_STORAGE_ENGINE=1 \
    -DWITH_ARCHIVE_STORAGE_ENGINE=1 \
    -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
    -DENABLED_LOCAL_INFILE=1 \
    -DDEFAULT_CHARSET=utf8mb4 \
    -DDEFAULT_COLLATION=utf8mb4_0900_ai_ci \
    -DWITH_BOOST=/tmp/boost \
    -DWITH_SSL=system \
    -DWITH_ZLIB=system

# 6. 编译和安装
echo "编译MySQL（这可能需要较长时间）..."
make -j2
sudo make install

# 7. 设置目录权限
echo "设置目录权限..."
sudo chown -R mysql:mysql /usr/local/mysql

# 8. 初始化MySQL系统数据库
echo "初始化MySQL数据库..."
cd /usr/local/mysql
sudo bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data

# 9. 获取初始root密码
initial_password=$(sudo grep 'temporary password' /usr/local/mysql/data/*.err | awk '{print $NF}')
echo "初始root密码: $initial_password"

# 10. 创建配置文件
echo "创建MySQL配置文件..."
# sudo cp support-files/my-default.cnf /etc/my.cnf 2>/dev/null || echo "使用默认配置"
sudo tee /etc/my.cnf > /dev/null <<EOF
[mysqld]
basedir=/usr/local/mysql/
datadir=/usr/local/mysql/data
port=3306
socket=/usr/local/mysql/data/mysql.sock
pid-file=/usr/local/mysql/data/mysql.pid
log-error=/usr/local/mysql/data/mysql-error.log
secure-file-priv=NULL
symbolic-links=0
EOF

# 11. 设置环境变量
echo 'export PATH=/usr/local/mysql/bin:$PATH' | sudo tee /etc/profile.d/mysql.sh
sudo chmod +x /etc/profile.d/mysql.sh
source /etc/profile.d/mysql.sh

# 12. 创建systemd服务文件
echo "创建systemd服务..."
sudo tee /etc/systemd/system/mysql.service > /dev/null <<EOF
[Unit]
Description=MySQL Server
After=network.target

[Service]
User=mysql
Group=mysql
ExecStart=/usr/local/mysql/bin/mysqld --defaults-file=/etc/my.cnf
ExecReload=/bin/kill -HUP \$MAINPID
Restart=always
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

# 13. 重新加载systemd并启动MySQL
sudo systemctl daemon-reload
sudo systemctl enable mysql
sudo systemctl start mysql

echo "MySQL 8.0.36 源码安装完成！"
echo "请使用以下命令登录MySQL:"
echo "mysql -u root -p'$initial_password'"
echo "登录后请立即更改root密码: ALTER USER 'root'@'localhost' IDENTIFIED BY '你的新密码';"