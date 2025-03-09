# nfs-server

NFSv4 Server

mount your exports to `/etc/exports` or as a file under `/etc/export.d/`

if `MOUNT_DEVICE_*` is set, it will mount the btrfs volume at that location to `MOUNT_LOC_*`

This needs to be ran in as root in a privileged container, or with `CAP_SYS_ADMIN` and `CAP_SETPCAP` capabilities

Mounting a device should only require `CAP_SYS_ADMIN`, but that doesn't work. It does work in a privileged container instead.

## Custom environment configuration

This container support setting certain custom environment variables with the use of [drone/envsubst](https://github.com/drone/envsubst).

| Name             | Default                                                                     |
|------------------|-----------------------------------------------------------------------------|
| NFS_SERVER_DEBUG | `0`                                                                         |
| LANG             | en_US.utf8                                                                  |
| MOUNT_ARGS_0     | rw,relatime,subvolid=5,subvol=/ - only used if MOUNT_DEVICE is set          |
| MOUNT_DEVICE_0   | unset, if set mounts device to $MOUNT_LOCATION_0 before starting nfs server |
| MOUNT_LOC_0      | /srv/nfs/0                                                                  |
| MOUNT_ARGS_1     | same as _0                                                                  |
| MOUNT_DEVICE_1   | same as _0                                                                  |
| MOUNT_LOC_1      | /srv/nfs/0                                                                  |
