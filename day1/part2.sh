#!/bin/bash

set -eu
set -o pipefail
shopt -s lastpipe

declare -i SUM=0

get_number() {
    case "$1" in
        one)
            echo 1
            ;;
        two)
            echo 2
            ;;
        three)
            echo 3
            ;;
        four)
            echo 4
            ;;
        five)
            echo 5
            ;;
        six)
            echo 6
            ;;
        seven)
            echo 7
            ;;
        eight)
            echo 8
            ;;
        nine)
            echo 9
            ;;
        *)
            echo "$1"
            ;;
    esac
}

while read -r LINE; do
    [[ "$LINE" =~ ([0-9]|one|two|three|four|five|six|seven|eight|nine).*$ ]]
    DIGIT="$(get_number "${BASH_REMATCH[1]}")"
    [[ "$LINE" =~ ^.*([0-9]|one|two|three|four|five|six|seven|eight|nine) ]]
    DIGIT="${DIGIT}$(get_number "${BASH_REMATCH[1]}")"
    SUM+=DIGIT
done

echo $SUM
