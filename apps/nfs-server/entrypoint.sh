#!/bin/bash

set -Eeuo pipefail

if [ -n "${MOUNT_DEVICE_0}" ]; then
	btrfs device scan

	MOUNT_ARGS_0=${MOUNT_ARGS_0:-'-rw,relatime,subvolid=5,subvol=/'}
	MOUNT_LOC_0=${MOUNT_LOC_0:-'/srv/nfs/0'}

	mount -o "$MOUNT_ARGS_0" "$MOUNT_DEVICE_0" "$MOUNT_LOC_0"
fi

# TODO add more? or somehow convert to an array?
if [ -n "${MOUNT_DEVICE_1}" ]; then
	btrfs device scan

	MOUNT_ARGS_1=${MOUNT_ARGS_1:-'-rw,relatime,subvolid=5,subvol=/'}
	MOUNT_LOC_1=${MOUNT_LOC_1:-'/srv/nfs/1'}

	mount -o "$MOUNT_ARGS_1" "$MOUNT_DEVICE_1" "$MOUNT_LOC_1"
fi

echo "/etc/exports:"
cat /etc/exports
echo

exportfs -afv

nfsd_debug_opt=
mountd_debug_opt=
if [ $NFS_SERVER_DEBUG -eq 1 ]; then
    nfsd_debug_opt="-d"
    mountd_debug_opt="-d all"
fi

mount -t nfsd nfsd /proc/fs/nfsd

rpc.nfsd -N 3 -V 4 --grace-time 10 $nfsd_debug_opt &
rpc.mountd -N 2 -N 3 -V 4 --foreground $mountd_debug_opt &

wait
