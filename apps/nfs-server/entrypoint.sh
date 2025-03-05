#!/bin/sh

set -Eeuo pipefail

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
