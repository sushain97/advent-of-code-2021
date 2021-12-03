#include <fstream>
#include <iostream>

int main(int argc, char* argv[]) {
  std::ifstream input_file(argv[1]);

  std::string direction;
  int units;

  int horiz = 0, depth = 0, aim = 0;

  while (input_file >> direction >> units) {
    if (direction == "forward") {
      horiz += units;
      depth += aim * units;
    } else if (direction == "down") {
      aim += units;
    } else if (direction == "up") {
      aim -= units;
    }
  }

  std::cout << horiz * depth << "\n";
}
