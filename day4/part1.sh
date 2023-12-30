#!/bin/bash

set -eu
set -o pipefail
shopt -s lastpipe

declare -i SUM=0

while IFS=":|" read -r _ WINNING NUMBERS; do
    declare -i WINNERS=0

    for NUMBER in $NUMBERS; do
        for WINNER in $WINNING; do
            if [ "$NUMBER" = "$WINNER" ]; then
                WINNERS+=1
                break
            fi
        done
    done

    if [ "$WINNERS" -gt 0 ]; then
        SUM+="$((2**(WINNERS-1)))"
    fi
done

echo "$SUM"
