#!/bin/bash
################################################
# Function : Install LNMP-MYSQL 8.0.36
# Desc     : 源码编译安装 MySQL 8.0.36 + systemd服务注册
# Platform : Ubuntu
# Version  : 1.1
# Date     : 2025-10-29
# Author   : ncnynl
################################################
set -e

# ---------------- 配置区 ----------------
MYSQL_USER="mysql"
MYSQL_VERSION="8.0.36"

BASE_DIR=~/webserver
SRC_DIR="${BASE_DIR}/src"
MYSQL_DIR="${BASE_DIR}/mysql"
INSTALL_DIR="${BASE_DIR}/mysql-${MYSQL_VERSION}"
DATA_DIR="${INSTALL_DIR}/data"

SYSTEMD_SERVICE="/etc/systemd/system/mysqld.service"
MY_CNF="${INSTALL_DIR}/etc/my.cnf"
CURRENT_USER=$(whoami)
# -----------------------------------------

echo "🔧 安装依赖..."
sudo apt update
sudo apt install -y cmake make gcc g++ bison libncurses5-dev libssl-dev \
  libboost-all-dev zlib1g-dev libevent-dev libaio-dev pkg-config git libtirpc-dev

mkdir -p "${SRC_DIR}"
cd "${SRC_DIR}"

echo "⬇️ 下载 MySQL ${MYSQL_VERSION}..."
wget -c https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-${MYSQL_VERSION}.tar.gz
tar -xzf mysql-${MYSQL_VERSION}.tar.gz

echo "📦 下载 Boost 1.77.0..."
mkdir -p "${SRC_DIR}/boost"
cd "${SRC_DIR}/boost"
[ -f boost_1_77_0.tar.bz2 ] || wget https://archives.boost.org/release/1.77.0/source/boost_1_77_0.tar.bz2
tar -xjf boost_1_77_0.tar.bz2

cd "${SRC_DIR}/mysql-${MYSQL_VERSION}"
mkdir -p build && cd build

echo "⚙️ 配置 CMake..."
cmake .. \
  -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" \
  -DMYSQL_DATADIR="${DATA_DIR}" \
  -DSYSCONFDIR="${INSTALL_DIR}/etc" \
  -DWITH_SSL=system \
  -DWITH_ZLIB=system \
  -DWITH_BOOST="${SRC_DIR}/boost/boost_1_77_0" \
  -DWITH_SYSTEMD=OFF \
  -DWITH_UNIT_TESTS=OFF \
  -DWITH_TEST=OFF \
  -DWITH_TEST_SUITE=OFF

echo "🔨 编译安装..."
make -j2
sudo make install

echo "✅ 建立统一入口 symlink..."
sudo ln -sfn "${INSTALL_DIR}" "${MYSQL_DIR}"

echo "👤 检查/创建 mysql 用户..."
if ! id "${MYSQL_USER}" >/dev/null 2>&1; then
    sudo useradd -r -s /bin/false "${MYSQL_USER}"
fi

echo "📁 初始化数据库目录..."
sudo mkdir -p "${DATA_DIR}" "${INSTALL_DIR}/etc"
sudo chown -R ${MYSQL_USER}:${MYSQL_USER} "${INSTALL_DIR}"
sudo chown -R ${MYSQL_USER}:${MYSQL_USER} "${MYSQL_DIR}"

echo "🔍 初始化 MySQL 数据..."
sudo -u ${MYSQL_USER} "${INSTALL_DIR}/bin/mysqld" \
  --initialize \
  --basedir="${INSTALL_DIR}" \
  --datadir="${DATA_DIR}" \
  --user=${MYSQL_USER} \
  --log-error="${DATA_DIR}/mysql-error.log"

echo "🔍 获取临时密码..."
sudo grep 'temporary password' "${DATA_DIR}/mysql-error.log" || echo "⚠️ 未找到初始化密码，请检查日志"

echo "📝 生成 my.cnf..."
sudo tee "${MY_CNF}" > /dev/null <<EOF
[mysqld]
basedir=${MYSQL_DIR}
datadir=${MYSQL_DIR}/data
port=3306
socket=${MYSQL_DIR}/data/mysql.sock
pid-file=${MYSQL_DIR}/data/mysql.pid
log-error=${MYSQL_DIR}/data/mysql-error.log
secure-file-priv=NULL
symbolic-links=0
EOF

echo "🛠 注册 systemd 服务..."
sudo tee "${SYSTEMD_SERVICE}" > /dev/null <<EOF
[Unit]
Description=MySQL Server (Custom Build)
After=network.target

[Service]
Type=simple
User=${MYSQL_USER}
Group=${MYSQL_USER}
ExecStart=${MYSQL_DIR}/bin/mysqld --defaults-file=${MY_CNF}
ExecStop=${MYSQL_DIR}/bin/mysqladmin --defaults-file=${MY_CNF} shutdown
Restart=on-failure
LimitNOFILE=5000

[Install]
WantedBy=multi-user.target
EOF

echo "📦 启动 MySQL 服务..."
sudo systemctl daemon-reload
sudo systemctl enable mysqld.service
sudo systemctl start mysqld.service

echo ""
echo "✅ MySQL ${MYSQL_VERSION} 编译安装完成！"
echo "📄 查看初始化密码："
echo "   tail -n 20 ${MYSQL_DIR}/data/mysql-error.log"
echo ""
echo "💡 登录示例："
echo "   ${MYSQL_DIR}/bin/mysql -u root -p --socket=${MYSQL_DIR}/data/mysql.sock"
