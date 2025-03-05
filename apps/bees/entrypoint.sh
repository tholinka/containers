#!/bin/bash

# Check DB size
# from bees.git/scripts/beesd
{
	## Helpful functions
	INFO(){ echo "INFO:" "$@"; }
	ERRO(){ echo "ERROR:" "$@"; exit 1; }

	readonly AL128K="$((128*1024))"
	DB_SIZE="${DB_SIZE:-$((8192*AL128K))}"

	if [ -d "$BEESHOME" ]; then
		mkdir "$BEESHOME"
	fi

	DB_PATH="$BEESHOME/beeshash.dat"

	touch "$DB_PATH"
	OLD_SIZE="$(du -b "$DB_PATH" | sed 's/\t/ /g' | cut -d' ' -f1)"
	NEW_SIZE="$DB_SIZE"
	if (( "$NEW_SIZE"%AL128K > 0 )); then
		ERRO "DB_SIZE Must be multiple of 128K"
	fi
	if (( "$OLD_SIZE" != "$NEW_SIZE" )); then
		INFO "Resize db: $OLD_SIZE -> $NEW_SIZE"
		rm -f "$BEESHOME/beescrawl.dat"
		truncate -s "$NEW_SIZE" "$DB_PATH"
	fi
	chmod 700 "$DB_PATH"
}

exec /usr/local/bin/bees --no-timestamps /mnt "$@"
