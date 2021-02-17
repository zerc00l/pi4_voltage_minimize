#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import re

argv = sys.argv[0]
arg1 = sys.argv[1]
arg2 = sys.argv[2]

# arg1 = "0:0:0:0"
# arg2 = "/devices/platform/scb/fd500000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/usb1/1-1/1-1.1/1-1.1.4/1-1.1.4.2/1-1.1.4.2:1.2/host0/target0:0:0/0:0:0:0"

path = re.compile(".*\/(?P<path>\d?\-.*\:[\d]\.[\d])\/.*", re.I)
pinfo = path.match(arg2)
path_info = pinfo.groupdict()
print(path_info['path'])

f = open('/sys/bus/scsi/drivers/sd/unbind', 'w')
f.write(arg1)
try:
    f.close()
except:
    pass

f = open('/sys/bus/usb/drivers/usb-storage/unbind', 'w')
f.write(path_info['path'])
try:
    f.close()
except:
    pass


exit(0)
