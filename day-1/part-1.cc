#include <fstream>
#include <iostream>

int main(int argc, char *argv[]) {
  std::ifstream input_file(argv[1]);

  int increases = 0;

  int last_val = INT_MAX;
  int val;
  while (input_file >> val) {
    if (val > last_val) {
      increases++;
    }

    last_val = val;
  }

  std::cout << increases << "\n";
}
