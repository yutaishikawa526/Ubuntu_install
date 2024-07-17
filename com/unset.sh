#!/bin/bash -e

# ディスクのunmount

_DIR=$(cd $(dirname $0) ; cd ../ ; pwd)
source "$_DIR/conf/conf.sh"
source "$_DIR/conf/conf_mnt.sh"
source "$_DIR/com/com.sh"

sudo umount "$_MNT_POINT/sys" 2> /dev/null || true
sudo umount "$_MNT_POINT/dev/pts" 2> /dev/null || true
sudo umount "$_MNT_POINT/dev" 2> /dev/null || true
sudo umount "$_MNT_POINT/proc" 2> /dev/null || true
sudo umount "$_MNT_POINT/boot/efi" 2> /dev/null || true
sudo umount "$_MNT_POINT/boot" 2> /dev/null || true
sudo umount "$_MNT_POINT" 2> /dev/null || true
