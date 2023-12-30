#!/bin/bash

set -eu
set -o pipefail
shopt -s lastpipe

read -r _ SEEDS



MIN_RESULT=""

for SEED in $SEEDS; do
    LASTTYPE="seed"
    IDX=""
    LASTIDX="$SEED"
    RIGHTTABLE=false
    while read -r A B C; do
        if [[ "$B" == "map:" && "$A" == "$LASTTYPE"-* ]]; then
            LASTTYPE="${A##*-}"
            RIGHTTABLE=true
        elif [[ "$A" == "" ]]; then
            RIGHTTABLE=false
            if [[ -n "$IDX" ]]; then
                LASTIDX="$IDX"
            fi
            # else: LASTIDX=$LASTIDX

            #debug#echo "$LASTTYPE: $LASTIDX"
        elif $RIGHTTABLE && [[ "$LASTIDX" -ge "$B" && "$LASTIDX" -lt "$((B+C))" ]]; then
            IDX=$((A+LASTIDX-B))
        fi
    done < /dev/stdin
    if [[ -n "$IDX" ]]; then
        LASTIDX="$IDX"
    fi

    if [[ -z "$MIN_RESULT" || "$LASTIDX" -lt "$MIN_RESULT" ]]; then
        MIN_RESULT="$LASTIDX"
    fi
done

echo "$MIN_RESULT"
