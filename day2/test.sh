#!/bin/sh

set -eu

[ "$(./part1.sh < example)" = "8" ]
[ "$(./part2.sh < example)" = "2286" ]
