#include <limits.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
  FILE* file = fopen(argv[1], "r");

  int increases = 0;

  int val0 = INT_MAX, val1 = INT_MAX, val2 = INT_MAX;
  long old_sum = ((long)INT_MAX) * 3;
  int cur_val;

  while (!feof(file)) {
    fscanf(file, "%d", &cur_val);

    val0 = val1;
    val1 = val2;
    val2 = cur_val;

    long new_sum = (long)val0 + (long)val1 + (long)val2;
    if (new_sum > old_sum) {
      increases++;
    }

    old_sum = new_sum;
  }

  printf("%d\n", increases);
}
