#!/bin/bash

set -eu
set -o pipefail
shopt -s lastpipe

read -ra DURATION
read -ra DISTANCE
declare -i RESULT=1

for GAME in "${!DURATION[@]}"; do
    if [[ "$GAME" == 0 ]]; then
        continue
    fi
    declare -i i WINNERS=0
    GAME_DURATION=${DURATION[$GAME]}
    for ((i=1; i < GAME_DURATION; i++)); do
        if [[ ${DISTANCE[$GAME]} -lt $((i*(GAME_DURATION-i))) ]]; then
            WINNERS+=1
        fi
    done
    RESULT=$((RESULT*WINNERS))
done

echo $RESULT
