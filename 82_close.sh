#!/bin/bash -e

# マウントを解除

_DIR=$(cd $(dirname $0) ; pwd)
source "$_DIR/conf/conf.sh"
source "$_DIR/conf/conf_mnt.sh"
source "$_DIR/com/com.sh"

# umount
bash "$_DIR/com/unset.sh"