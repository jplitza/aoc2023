#!/bin/sh

set -eu

[ "142" = "$(./part1.sh <<EOF
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
EOF
)" ]

[ "281" = "$(./part2.sh <<EOF
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
EOF
)" ]
