#!/bin/bash -e

# ユーザー設定

_DIR=$(cd $(dirname $0) ; pwd)
source "$_DIR/conf/conf.sh"
source "$_DIR/conf/conf_mnt.sh"
source "$_DIR/com/com.sh"

# マウント
bash "$_DIR/com/mount.sh"
bash "$_DIR/com/sys_setup.sh"

# 最小のubuntuのインストール
sudo chroot "$_MNT_POINT" apt install -y --no-install-recommends ubuntu-minimal

sudo chroot "$_MNT_POINT" dpkg-reconfigure tzdata
sudo chroot "$_MNT_POINT" dpkg-reconfigure locales
sudo chroot "$_MNT_POINT" dpkg-reconfigure keyboard-configuration

# localhostの指定
sudo chroot "$_MNT_POINT" << EOF
    echo 'localhost' > /etc/hostname
    echo '127.0.0.1 localhost' >> /etc/hosts
    exit
EOF

# rootユーザーの設定
echo "----------- Enter root password -----------"
sudo chroot "$_MNT_POINT" passwd

# ネットワーク設定
sudo chroot "$_MNT_POINT" << EOF
    systemctl enable systemd-networkd
    {
        echo '[Match]'
        echo "Name=$_NW_INTERFACE"
        echo ''
        echo '[Network]'
        echo 'DHCP=yes'
    } > /etc/systemd/network/ethernet.network
    exit
EOF

# umount
bash "$_DIR/com/unset.sh"
