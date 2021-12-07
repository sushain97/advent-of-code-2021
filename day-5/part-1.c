#include <limits.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char* argv[]) {
  FILE* file = fopen(argv[1], "r");

  size_t max_x = 0, max_y = 0;

  int x1, y1, x2, y2;
  while (!feof(file)) {
    fscanf(file, "%d,%d -> %d,%d", &x1, &y1, &x2, &y2);

    max_x = fmax(fmax(max_x, x1), x2);
    max_y = fmax(fmax(max_y, y1), y2);
  }

  int grid[max_x + 1][max_y + 1];
  memset(grid, 0, sizeof(grid));

  fseek(file, 0, SEEK_SET);

  while (!feof(file)) {
    fscanf(file, "%d,%d -> %d,%d", &x1, &y1, &x2, &y2);

    if (x1 == x2) {
      for (int y = fmin(y1, y2); y <= fmax(y1, y2); y++) {
        grid[x1][y]++;
      }
    } else if (y1 == y2) {
      for (int x = fmin(x1, x2); x <= fmax(x1, x2); x++) {
        grid[x][y1]++;
      }
    }
  }

  size_t overlaps = 0;
  for (int y = 0; y <= max_y; y++) {
    for (int x = 0; x <= max_x; x++) {
      if (grid[x][y] > 1) {
        overlaps++;
      }
    }
  }

  printf("%zu\n", overlaps);
}
