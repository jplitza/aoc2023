#!/bin/bash

set -eu
set -o pipefail
shopt -s lastpipe

declare -a WINNERS=()
declare -a DUPLICATES=()

while IFS=":|" read -r CARD WINNING NUMBERS; do
    CARD_ID="${CARD#Card }"
    WINNERS[CARD_ID]=0
    DUPLICATES[CARD_ID]=1

    for NUMBER in $NUMBERS; do
        for WINNER in $WINNING; do
            if [ "$NUMBER" = "$WINNER" ]; then
                WINNERS[CARD_ID]=$((WINNERS[CARD_ID]+1))
                break
            fi
        done
    done
done

for CARD_ID in "${!WINNERS[@]}"; do
    for (( i=1; i <= "${WINNERS[CARD_ID]}"; i++)); do
        DUPLICATES[CARD_ID+i]=$((DUPLICATES[CARD_ID+i]+DUPLICATES[CARD_ID]))
    done
done

declare -i SUM=0

for NUM_CARDS in "${DUPLICATES[@]}"; do
    SUM+=NUM_CARDS
done

echo "$SUM"
