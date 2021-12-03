#!/usr/bin/awk -f

BEGIN { increases = 0 }

NR == 1 { last_val = $1 }
$1 > last_val { increases++ }
{ last_val = $1 }

END { print increases }
