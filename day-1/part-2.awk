#!/usr/bin/awk -f

BEGIN { increases = val0 = val1 = val2 = last_sum = 0 }

{
    val0 = val1;
    val1 = val2;
    val2 = $1;
}

NR >= 4 { new_sum = val0 + val1 + val2 }
new_sum > last_sum { increases++ }
{ last_sum = new_sum }

END { print increases }
