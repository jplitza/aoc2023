#!/bin/bash

set -eu
set -o pipefail
shopt -s lastpipe

IFS=":" read -r _ DURATION
IFS=":" read -r _ DISTANCE
DURATION="${DURATION// /}"
DISTANCE="${DISTANCE// /}"

binary_search() {
    declare -i LOWER="$1" UPPER="$2" THRESHOLD="$3" TOTAL="$4"
    declare -i LOWER_COMP=$(( LOWER*(TOTAL-LOWER) > THRESHOLD))

    while [[ $((UPPER-LOWER)) -gt 1 ]]; do
        NEXT=$(( (UPPER + LOWER) / 2))
        if [[ $((NEXT*(TOTAL-NEXT) > THRESHOLD)) -eq $LOWER_COMP ]]; then
            LOWER=$NEXT
        else
            UPPER=$NEXT
        fi
    done
    echo $UPPER
}

MIDDLE=$((DURATION / 2))

LOWEST=$(binary_search 0 "$MIDDLE" "$DISTANCE" "$DURATION")
HIGHEST=$(binary_search "$MIDDLE" "$DURATION" "$DISTANCE" "$DURATION")

echo $((HIGHEST-LOWEST))
