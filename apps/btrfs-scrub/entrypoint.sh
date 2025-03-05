#!/bin/sh

btrfs scrub start -B /mnt & pid_scrub=$!

UUID="$(btrfs filesystem show / | grep uuid: | sed 's/.*uuid: //')"

tail -F /var/lib/btrfs/scrub.status.${UUID} & pid_tail=$!

wait "$pid_scrub"
kill "$pid_tail"
