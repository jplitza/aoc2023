#!/bin/sh

set -eu

[ "$(./part1.sh < example)" = "13" ]
[ "$(./part2.sh < example)" = "30" ]
