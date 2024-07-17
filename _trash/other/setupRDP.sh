#!/bin/bash -e

# xrdpを使用したリモートデスクトップの設定
# xrdpはデフォルトでは起動しない
# 使用する場合はssh接続で有効化して使用する

sudo apt update -y
sudo apt install -y xrdp ufw

sudo ufw allow from '10.8.0.0/24' to any port 3389 proto tcp
sudo ufw enable

sudo systemctl stop xrdp
sudo systemctl stop xrdp-sesman

sudo systemctl disable xrdp
sudo systemctl disable xrdp-sesman
