#!/bin/bash -e

# debootstrapの実行

_DIR=$(cd $(dirname $0) ; pwd)
source "$_DIR/conf/conf.sh"
source "$_DIR/conf/conf_mnt.sh"
source "$_DIR/com/com.sh"

check_func 'debootstrap' 'debootstrap'

# マウント
bash "$_DIR/com/mount.sh"

sudo debootstrap $_DEB_OPTION "$_DEB_NAME" "$_MNT_POINT" http://de.archive.ubuntu.com/ubuntu

# fstabの設定
{
    echo '# root'
    echo "UUID=`get_uuid_by_device "$_PAT_ROOT"` / ext4 defaults 0 1"
    echo '# boot'
    echo "UUID=`get_uuid_by_device "$_PAT_BOOT"` /boot ext4 defaults 0 2"
    echo '# efi'
    echo "UUID=`get_uuid_by_device "$_PAT_EFI"` /boot/efi vfat defaults 0 2"
    if [[ $_PAT_SWAP != '' ]]; then
        echo '# swap'
        echo "UUID=`get_uuid_by_device "$_PAT_SWAP"` none swap defaults 0 0"
    fi
} | sudo sh -c "cat > $_MNT_POINT/etc/fstab"

# aptのミラーサイト設定
echo "$_APT_SOURCE_LIST" | sudo sh -c "cat > $_MNT_POINT/etc/apt/sources.list"

# umount
bash "$_DIR/com/unset.sh"
