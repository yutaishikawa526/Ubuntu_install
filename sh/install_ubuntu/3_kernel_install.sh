#!/bin/bash -e

# カーネルのインストール

_DIR=$(cd $(dirname $0) ; pwd)
source "$_DIR/conf/conf.sh"
source "$_DIR/conf/conf_mnt.sh"
source "$_DIR/com/com.sh"

# マウント
bash "$_DIR/com/mount.sh"
bash "$_DIR/com/sys_setup.sh"

# カーネルインストール
sudo chroot "$_MNT_POINT" << EOF
    apt update
    apt install -y --no-install-recommends \
        linux-image-$_KERNEL_VER-generic \
        linux-headers-$_KERNEL_VER-generic \
        linux-modules-$_KERNEL_VER-generic \
        linux-modules-extra-$_KERNEL_VER-generic
    apt install -y initramfs-tools $_KERNEL_OTHER_INSTALL
    update-initramfs -c -k all
    exit
EOF

# umount
bash "$_DIR/com/unset.sh"
