#!/bin/bash
set -e

CUR_DIR=`dirname "$0"`

cp /boot/cmdline.txt /boot/cmdline.txt.bak.`date '+%Y%m%d_%H%M%S'`
cp /boot/config.txt /boot/config.txt.bak.`date '+%Y%m%d_%H%M%S'`

/usr/bin/rsync -zPrlthpog ${CUR_DIR}/rootfs/ /
systemctl daemon-reload
udevadm control --reload 
shutdown -r -t 1
