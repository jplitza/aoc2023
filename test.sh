#!/bin/sh

set -eu

for DIR in "$(realpath "$(dirname "$0")")/day"*; do
    cd "$DIR"
    if ! ./test.sh; then
        echo "$DIR failed"
    fi
done
