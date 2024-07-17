#!/bin/bash -e

# マウントに関する設定ファイル
# [2_debootstrap.sh]から開始する場合は適切に設定する

# efiパーティション
_PAT_EFI=/dev/sdXXX1
# bootマウントパーティション
_PAT_BOOT=/dev/sdXXX2
# rootマウントパーティション
_PAT_ROOT=/dev/sdXXX3
# swapマウントパーティション
# 空文字の場合は使用しない
_PAT_SWAP=/dev/sdXXX4
