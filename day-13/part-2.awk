#!/usr/bin/awk -f

$1 ~ /,/ { dots[$1] = 1 }

$3 ~ /\=/ {
  split($3, fold, "=");

  for (d in dots) {
    delete dots[d];
    split(d, dot, ",");

    new_dot = d;
    if (fold[1] == "x" && dot[1] > fold[2]) {
      new_dot = (fold[2] - (dot[1] - fold[2])) "," dot[2];
    } else if (fold[1] == "y" && dot[2] > fold[2]) {
      new_dot = dot[1] "," (fold[2] - (dot[2] - fold[2]));
    }

    dots[new_dot] = 1;
  }
}

END {
  for (d in dots) {
    split(d, dot, ",");

    if (dot[1] > max_x) {
      max_x = dot[1];
    }
    if (dot[2] > max_y) {
      max_y = dot[2];
    }
  }

  for (y = 0; y <= max_y; y++) {
    for (x = 0; x <= max_x; x++) {
      if (dots[x "," y]) {
        printf "█";
      } else {
        printf " ";
      }
    }

    print "";
  }
}
