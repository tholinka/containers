#!/usr/bin/env bash
# remove all -'s, to remove all -rc releases
version="$(curl -sX GET "https://api.github.com/repos/Zygo/bees/tags" | jq -r '[.[].name | select(contains("-") | not)][0]' 2>/dev/null)"
# remove v at beginning
version="${version//v}"
printf "%s" "${version}"
