#!/bin/bash

set -Eeuo pipefail

if [ -n "${MOUNT_DEVICE}" ]; then
	btrfs device scan

	MOUNT_ARGS=${MOUNT_ARGS:-'-rw,relatime,subvolid=5,subvol=/'}

	mount -o "$MOUNT_ARGS" "$MOUNT_DEVICE" /mnt
fi

btrfs scrub start -B /mnt & pid_scrub=$!

UUID="$(btrfs filesystem show /mnt | grep uuid: | sed 's/.*uuid: //')"

tail -F /var/lib/btrfs/scrub.status.${UUID} & pid_tail=$!

wait "$pid_scrub"
kill "$pid_tail"
