#!/bin/bash -e

# chrootする

_DIR=$(cd $(dirname $0) ; pwd)
source "$_DIR/conf/conf.sh"
source "$_DIR/conf/conf_mnt.sh"
source "$_DIR/com/com.sh"

# マウント
bash "$_DIR/com/mount.sh"
bash "$_DIR/com/sys_setup.sh"

sudo chroot "$_MNT_POINT"

# umount
bash "$_DIR/com/unset.sh"