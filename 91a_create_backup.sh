#!/bin/bash -e

# バックアップを作成

_DIR=$(cd $(dirname $0) ; pwd)
source "$_DIR/conf/conf.sh"
source "$_DIR/conf/conf_mnt.sh"
source "$_DIR/com/com.sh"

echo 'バックアップ名を入力してください。'
read -p ":" b_name
backup_dir="$_DIR/disk/$b_name"
if [[ "$b_name" =~ ^$ ]]; then
    echo 'バックアップ名が未指定です。'
    exit 1
fi
if [ -d "$backup_dir" ]; then
    echo 'すでにバックアップディレクトリが存在します。'
    exit 1
fi

sudo mkdir "$backup_dir"

# umount
bash "$_DIR/com/unset.sh"
unset_device "$_DISK_IMG_PATH"

sudo cp "$_DISK_IMG_PATH" "$backup_dir"
