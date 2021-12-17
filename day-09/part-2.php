<?php

$grid = [];
foreach (file($argv[1]) as $line) {
  array_push($grid, [9, ...str_split(trim($line)), 9]);
}

$top_frame = array_fill(0, count($grid[0]), 9);
array_unshift($grid, $top_frame);

$bottom_frame = $top_frame;
array_push($grid, $bottom_frame);

$low_points = [];
foreach (range(1, count($grid) - 2) as $y) {
  foreach (range(1, count($grid[$y]) - 2) as $x) {
    $low_point = true;
    foreach ([[0, 1], [1, 0], [0, -1], [-1, 0]] as [$dx, $dy]) {
      if ($grid[$y + $dx][$x + $dy] <= $grid[$y][$x]) {
        $low_point = false;
        break;
      }
    }

    if ($low_point) {
      array_push($low_points, [$x, $y]);
    }
  }
}

$basins = [];
foreach (range(1, count($grid) - 2) as $y) {
  foreach (range(1, count($grid[$y]) - 2) as $x) {
    if ($grid[$y][$x] != 9) {
      [$i, $j] = [$x, $y];

      while (!in_array([$i, $j], $low_points)) {
        foreach ([[0, 1], [1, 0], [0, -1], [-1, 0]] as [$dx, $dy]) {
          if ($grid[$j + $dy][$i + $dx] < $grid[$j][$i]) {
            [$i, $j] = [$i + $dx, $j + $dy];
            break;
          }
        }
      }

      $basins[$i . "," . $j] = ($basins[$i . "," . $j] ?? 0) + 1;
    }
  }
}
arsort($basins);

$basin_sizes = array_values($basins);
print(($basin_sizes[0] * $basin_sizes[1] * $basin_sizes[2]) . "\n");
