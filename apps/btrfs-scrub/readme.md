# btrfs-scrub

Dockerized btrfs scrub. Run this as a kubernetes cronjob or the like.

Mounting a device, and the scrub, should only require `CAP_SYS_ADMIN`, but that doesn't work. It does work in a privileged container instead.

## Custom environment configuration

| Name         | Default                                                            |
|--------------|--------------------------------------------------------------------|
| MOUNT_ARGS   | rw,relatime,subvolid=5,subvol=/ - only used if MOUNT_DEVICE is set |
| MOUNT_DEVICE | unset, if set mounts device to /mnt before starting scrub          |
