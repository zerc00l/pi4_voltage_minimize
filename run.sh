#!/bin/bash
set -e

CUR_DIR=`dirname "$0"`

# patch_cmdline <cmdline entry name>
patch_cmdline() {
    local cmdline match;
    cmdline=`head -n 1 /boot/cmdline.txt`
    if [ -z "$(echo $cmdline | grep "$1")" ]; then
        cmdline="$cmdline $1"
    else
        return 0
    fi
    echo $cmdline > /boot/cmdline.txt
}

cp /boot/cmdline.txt /boot/cmdline.txt.bak.`date '+%Y%m%d_%H%M%S'`
cp /boot/config.txt /boot/config.txt.bak.`date '+%Y%m%d_%H%M%S'`

patch_cmdline "usbcore.autosuspend=-1"
patch_cmdline "usbcore.initial_descriptor_timeout=50000"
patch_cmdline "usbcore.old_scheme_first=1"
patch_cmdline "usbcore.use_both_schemes=1"

/usr/bin/rsync -zPrlthpog ${CUR_DIR}/rootfs/ /

/usr/bin/rpi-eeprom-update -f /home/pi/pieeprom-2021-01-16.bin
systemctl daemon-reload
udevadm control --reload 
shutdown -r -t 1
