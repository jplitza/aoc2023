#!/bin/bash

declare -i SUM=0

while read -r LINE; do
    [[ "$LINE" =~ ^[^0-9]*([0-9]) ]]
    DIGIT="${BASH_REMATCH[1]}"
    [[ "$LINE" =~ ([0-9])[^0-9]*$ ]]
    DIGIT="${DIGIT}${BASH_REMATCH[1]}"
    SUM+=DIGIT
done

echo $SUM
