#!/bin/bash -e

# grubのインストール

_DIR=$(cd $(dirname $0) ; pwd)
source "$_DIR/conf/conf.sh"
source "$_DIR/conf/conf_mnt.sh"
source "$_DIR/com/com.sh"

# マウント
bash "$_DIR/com/mount.sh"
bash "$_DIR/com/sys_setup.sh"

sudo chroot "$_MNT_POINT" << EOF
    apt install -y $_GRUB_EFI_PACKAGE
    grub-install $_DISK_BASE --target=$_GRUB_TARGET --efi-directory=/boot/efi --boot-directory=/boot
    update-grub
    sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*$/GRUB_CMDLINE_LINUX_DEFAULT=""/g' /etc/default/grub
    update-grub
    exit
EOF

# umount
bash "$_DIR/com/unset.sh"
