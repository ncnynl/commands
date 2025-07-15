#!/bin/bash
################################################
# Function : Install LNMP-MYSQL 8.0.36
# Desc     : 用于安装LNMP-MYSQL 8.0.36的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2025-07-14                           
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install LNMP-MYSQL 8.0.36")" 

set -e

# ---------------- 配置区域 ----------------
MYSQL_USER="mysql"
MYSQL_VERSION="8.0.36"

ROOT_DIR=~/webserver
SRC_DIR="${ROOT_DIR}/mysql-${MYSQL_VERSION}-src"
INSTALL_DIR="${ROOT_DIR}/mysql-${MYSQL_VERSION}"
DATA_DIR="$INSTALL_DIR/data"

SYSTEMD_SERVICE="/etc/systemd/system/mysqld.service"
MY_CNF="$INSTALL_DIR/etc/my.cnf"
CURRENT_USER=$(whoami)
# -----------------------------------------

echo "🔧 安装构建依赖..."
sudo apt update
sudo apt install -y cmake make gcc g++ bison libncurses5-dev libssl-dev \
  libboost-all-dev zlib1g-dev libevent-dev libaio-dev pkg-config git libtirpc-dev
cd ${ROOT_DIR}

echo "⬇️ 下载并解压 MySQL $MYSQL_VERSION..."
wget -c https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-${MYSQL_VERSION}.tar.gz
tar -xzf mysql-${MYSQL_VERSION}.tar.gz
mv mysql-${MYSQL_VERSION} mysql-${MYSQL_VERSION}-src
cd mysql-${MYSQL_VERSION}-src
mkdir -p build
cd build 

echo "📥 手动下载 Boost 1.77.0..."
mkdir -p boost
wget -O boost/boost_1_77_0.tar.bz2 https://archives.boost.org/release/1.77.0/source/boost_1_77_0.tar.bz2
cd boost && tar xjf boost_1_77_0.tar.bz2
cd ..

echo "⚙️ 配置 CMake..."
cmake .. \
  -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
  -DMYSQL_DATADIR="$DATA_DIR" \
  -DSYSCONFDIR="$INSTALL_DIR/etc" \
  -DWITH_SSL=system \
  -DWITH_ZLIB=system \
  -DWITH_BOOST="$SRC_DIR/build/boost" \
  -DWITH_SYSTEMD=OFF \
  -DWITH_UNIT_TESTS=OFF \
  -DWITH_TEST=OFF \
  -DWITH_TEST_SUITE=OFF
  
echo "🔨 编译并安装..."
make -j$(nproc)
make install

cd .. 

echo "👤 创建 mysql 用户（如未存在）..."
if ! id "$MYSQL_USER" >/dev/null 2>&1; then
    sudo useradd -r -s /bin/false $MYSQL_USER
fi

echo "📁 初始化数据库目录..."
mkdir -p "$DATA_DIR" "$INSTALL_DIR/etc"
sudo usermod -aG ubuntu $MYSQL_USER
# sudo chown -R $MYSQL_USER:$MYSQL_USER "$INSTALL_DIR"

echo "🔍 初始化 MySQL 数据..."
"$INSTALL_DIR/bin/mysqld" --initialize --user=$MYSQL_USER --basedir="$INSTALL_DIR" --datadir="$DATA_DIR"

echo "🔍 GET MySQL INIT password ..."
grep 'A temporary password' $INSTALL_DIR/mysql-error.log

echo "🔍 将 socket 链接到默认路径 /tmp/mysql.sock"
sudo ln -s $INSTALL_DIR/mysql.sock /tmp/mysql.sock

echo "📝 创建 my.cnf 配置文件..."
cat > "$MY_CNF" <<EOF
[mysqld]
basedir=$INSTALL_DIR
datadir=$DATA_DIR
port=3306
socket=$INSTALL_DIR/mysql.sock
pid-file=$INSTALL_DIR/mysql.pid
log-error=$INSTALL_DIR/mysql-error.log
secure-file-priv=NULL
EOF

echo "🛠 设置 systemd 服务文件：$SYSTEMD_SERVICE"
sudo tee "$SYSTEMD_SERVICE" > /dev/null <<EOF
[Unit]
Description=Local MySQL Service (User Build)
After=network.target

[Service]
Type=simple
User=$CURRENT_USER
Group=$CURRENT_USER
ExecStart=$INSTALL_DIR/bin/mysqld  --defaults-file=$MY_CNF
ExecStop=$INSTALL_DIR/bin/mysqladmin --defaults-file=$MY_CNF --socket=$INSTALL_DIR/mysql.sock shutdown
Restart=on-failure
LimitNOFILE=5000

[Install]
WantedBy=multi-user.target
EOF

echo "📦 重新加载并启动 systemd 服务..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable mysqld.service
sudo systemctl start mysqld.service

echo ""
echo "✅ MySQL 源码安装并注册 systemd 服务完成！"
echo "🔐 请查看初始化密码（首次启动终端或日志中）："
echo "   tail -n 50 $INSTALL_DIR/mysql-error.log"
echo ""
echo "💡 登录示例："
echo "   $INSTALL_DIR/bin/mysql -u root -p --socket=$INSTALL_DIR/mysql.sock"
