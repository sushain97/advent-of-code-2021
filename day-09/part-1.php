<?php

$grid = [];
foreach (file($argv[1]) as $line) {
  array_push($grid, [9, ...str_split(trim($line)), 9]);
}

$top_frame = array_fill(0, count($grid[0]), 9);
array_unshift($grid, $top_frame);

$bottom_frame = $top_frame;
array_push($grid, $bottom_frame);

print(array_sum(array_map(
  fn ($y) =>
  array_sum(array_map(function ($x) use ($grid, $y) {
    $low_point = true;
    foreach ([[0, 1], [1, 0], [0, -1], [-1, 0]] as [$dx, $dy]) {
      if ($grid[$y + $dx][$x + $dy] <= $grid[$y][$x]) {
        $low_point = false;
        break;
      }
    }

    return $low_point ? (1 + $grid[$y][$x]) : 0;
  }, range(1, count($grid[$y]) - 2))),
  range(1, count($grid) - 2),
)) . "\n");
