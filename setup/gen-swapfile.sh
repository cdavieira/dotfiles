#!/usr/bin/env bash

SWAPFILE_PATH='/swapfile'
SIZE_IN_GIB=16
FSTAB='/etc/fstab'

# dd if=/dev/zero of=${SWAPFILE_PATH} bs=1M count=${SIZE_IN_GIB}k status=progress
# chmod 0600 ${SWAPFILE_PATH}

# mkswap -U clear ${SWAPFILE_PATH}
# swapon ${SWAPFILE_PATH}

# echo -e "\n# swapfile" >> ${FSTAB}
# echo "${SWAPFILE_PATH} none swap defaults 0 0" >> ${FSTAB}
