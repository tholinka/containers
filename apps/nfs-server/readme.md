# nfs-server

NFSv4 Server

mount your exports to `/etc/exports` or as a file under `/etc/export.d/`

This needs to be ran in as root in a privileged container, or with `SYS_ADMIN` and `SETPCAP` capabilities

## Custom environment configuration

This container support setting certain custom enviroment variables with the use of [drone/envsubst](https://github.com/drone/envsubst).

| Name             | Default    |
|------------------|------------|
| NFS_SERVER_DEBUG | `0`        |
| LANG             | en_US.utf8 |
