#!/bin/bash

declare -A MAX_VALUES=(
    [red]=12
    [green]=13
    [blue]=14
)

declare -i SUM=0

test_against_max() {
    THIS_GAME="$1"
    COLOR="$2"

    VALUE="${THIS_GAME%" ${COLOR}"*}"
    if [ "$VALUE" != "$THIS_GAME" ]; then
        # The color is present in this game
        VALUE="${VALUE##* }"
        if [ "$VALUE" -gt "${MAX_VALUES[$COLOR]}" ]; then
            return 1
        fi
    fi
    return 0
}

while IFS=":" read -r GAME_ID GAME; do
    GAME_ID="${GAME_ID#Game }"
    VALID=true
    GAME=";${GAME}"

    while true; do
        NEW_GAME="${GAME#*; }"
        if [ "$NEW_GAME" = "$GAME" ]; then
            break
        fi
        GAME="$NEW_GAME"
        THIS_GAME="${GAME%%; *}"
        for COLOR in "${!MAX_VALUES[@]}"; do
            if ! test_against_max "$THIS_GAME" "$COLOR"; then
                VALID=false
                break
            fi
        done
        if ! $VALID; then
            break
        fi
    done

    if $VALID; then
        SUM+=GAME_ID
    fi
done

echo "$SUM"
