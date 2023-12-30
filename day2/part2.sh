#!/bin/bash

set -eu
set -o pipefail
shopt -s lastpipe

declare -i SUM=0

while IFS=":" read -r GAME_ID GAME; do
    GAME_ID="${GAME_ID#Game }"
    GAME=";${GAME}"

    declare -A MAX_VALUES=(
        [red]=0
        [green]=0
        [blue]=0
    )

    while true; do
        NEW_GAME="${GAME#*; }"
        if [ "$NEW_GAME" = "$GAME" ]; then
            break
        fi
        GAME="$NEW_GAME"
        THIS_GAME="${GAME%%; *}"
        for COLOR in "${!MAX_VALUES[@]}"; do
            VALUE="${THIS_GAME%" ${COLOR}"*}"
            if [ "$VALUE" != "$THIS_GAME" ]; then
                # The color is present in this game
                VALUE="${VALUE##* }"
                if [ "$VALUE" -gt "${MAX_VALUES[$COLOR]}" ]; then
                    MAX_VALUES[$COLOR]=$VALUE
                fi
            fi
        done
    done

    SUM+=$((MAX_VALUES[red]*MAX_VALUES[blue]*MAX_VALUES[green]))
done

echo "$SUM"
