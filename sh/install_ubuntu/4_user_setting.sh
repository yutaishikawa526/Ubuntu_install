#!/bin/bash -e

# ユーザー設定

_DIR=$(cd $(dirname $0) ; pwd)
source "$_DIR/conf/conf.sh"
source "$_DIR/conf/conf_mnt.sh"
source "$_DIR/com/com.sh"

# マウント
bash "$_DIR/com/mount.sh"
bash "$_DIR/com/sys_setup.sh"

# 日付、地域、キーボードの設定
sudo chroot "$_MNT_POINT" << EOF
    dpkg-reconfigure tzdata
    dpkg-reconfigure locales
    dpkg-reconfigure keyboard-configuration
    exit
EOF

# localhostの指定
sudo chroot "$_MNT_POINT" << EOF
    echo 'localhost' > /etc/hostname
    echo '127.0.0.1 localhost' >> /etc/hosts
    exit
EOF

# rootユーザーの設定
echo "----------- Enter root password -----------"
sudo chroot "$_MNT_POINT" passwd

# umount
bash "$_DIR/com/unset.sh"
