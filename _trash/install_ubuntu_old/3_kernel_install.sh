#!/bin/bash -e

# カーネルのインストール

_DIR=$(cd $(dirname $0) ; pwd)
source "$_DIR/conf/conf.sh"

# マウント
bash "$_COM_DIR/mount.sh"
bash "$_COM_DIR/sys_setup.sh"

# カーネルインストール
sudo chroot "$_MNT_DIR" << EOF
    apt update
    apt install -y --no-install-recommends \
        linux-image-$_KERNEL_VER-generic \
        linux-headers-$_KERNEL_VER-generic \
        linux-modules-$_KERNEL_VER-generic \
        linux-modules-extra-$_KERNEL_VER-generic \
        ubuntu-minimal \
        initramfs-tools \
        $_KERNEL_OTHER_INSTALL
    update-initramfs -c -k all
    exit
EOF

# umount
bash "$_COM_DIR/unset.sh"