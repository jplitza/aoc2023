#!/bin/sh

set -eu

[ "$(./part1.sh < example)" = "288" ]
[ "$(./part2.sh < example)" = "71503" ]
