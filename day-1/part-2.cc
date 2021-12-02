#include <fstream>
#include <iostream>
#include <tuple>

int main(int argc, char *argv[]) {
  std::ifstream input_file(argv[1]);

  int increases = 0;

  auto vals = std::make_tuple(INT_MAX, INT_MAX, INT_MAX);
  long old_sum = ((long) INT_MAX) * 3;
  int cur_val;

  while (input_file >> cur_val) {
    std::get<0>(vals) = std::get<1>(vals);
    std::get<1>(vals) = std::get<2>(vals);
    std::get<2>(vals) = cur_val;

    int val1, val2, val3;
    std::tie(val1, val2, val3) = vals;

    long new_sum = (long) val1 + (long) val2 + (long) val3;
    if (new_sum > old_sum) {
      increases++;
    }

    old_sum = new_sum;
  }

  std::cout << increases << "\n";
}
