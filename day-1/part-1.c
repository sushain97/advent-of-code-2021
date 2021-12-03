#include <limits.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
  FILE* file = fopen(argv[1], "r");

  int increases = 0;

  int last_val = INT_MAX;
  int val;
  while (!feof(file)) {
    fscanf(file, "%d", &val);
    if (val > last_val) {
      increases++;
    }

    last_val = val;
  }

  printf("%d\n", increases);
}
