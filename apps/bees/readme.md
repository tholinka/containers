# bees

Dockerized Best-Effort Extent-Same, a btrfs deduplication agent.

mount your btrfs volume to `/mnt`, set your bees arguments as the args

This needs to be ran in as root in a privileged container, or with capabilities: `CAP_DAC_OVERRIDE CAP_DAC_READ_SEARCH CAP_FOWNER`

## Custom environment configuration

This container support setting certain custom enviroment variables with the use of [drone/envsubst](https://github.com/drone/envsubst).

| Name     | Default               |
|----------|-----------------------|
| BEESHOME | /mnt/.beeshome        |
| DB_SIZE  | 1073741824 (aka 1GiB) |
