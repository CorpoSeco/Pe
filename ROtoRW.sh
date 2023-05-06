#!/bin/bash

#pkg install android-tools
#pkg install e2fsprogs

set -e

if [ -f "$1" ]; then
   srcFile="$1"
fi

if [ ! -f "$srcFile" ];then
	echo "Usage: bash ROtoRW.sh [/path/to/system.img]"
	exit 1
fi

simg2img "$srcFile" system.img || mv "$srcFile" system.img

e2fsck -y -f system.img
resize2fs system.img 4000M
e2fsck -E unshare_blocks -y -f system.img
e2fsck -f -y system.img
resize2fs -M system.img
