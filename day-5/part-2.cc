#include <fstream>
#include <iostream>
#include <unordered_map>
#include <vector>
#include <utility>

int main(int argc, char* argv[]) {
  std::ifstream input_file(argv[1]);

  std::vector<std::pair<std::pair<int, int>, std::pair<int, int>>> coords;

  std::string p1, arrow, p2;
  while (input_file >> p1 >> arrow >> p2) {
    std::pair<int, int> p1_coords, p2_coords;

    sscanf(p1.c_str(), "%d,%d", &p1_coords.first, &p1_coords.second);
    sscanf(p2.c_str(), "%d,%d", &p2_coords.first, &p2_coords.second);

    coords.push_back({ p1_coords, p2_coords });
  }

  std::unordered_map<std::string, size_t> grid;

  for (auto coord : coords) {
    auto [x1, y1] = coord.first;
    auto [x2, y2] = coord.second;

    if (x1 == x2) {
      for (int y = std::min(y1, y2); y <= std::max(y1, y2); y++) {
        grid[std::to_string(x1) + "," + std::to_string(y)]++;
      }
    } else if (y1 == y2) {
      for (int x = std::min(x1, x2); x <= std::max(x1, x2); x++) {
        grid[std::to_string(x) + "," + std::to_string(y1)]++;
      }
    } else {
      if (x2 < x1) {
        std::swap(x1, x2);
        std::swap(y1, y2);
      }

      int y_dir = y1 < y2 ? 1 : -1;
      for (int i = 0; i <= x2 - x1; i++) {
        grid[std::to_string(x1 + i) + "," + std::to_string(y1 + i * y_dir)]++;
      }
    }
  }

  size_t overlaps = std::count_if(
    grid.begin(),
    grid.end(),
    [](auto& pair) { return pair.second > 1; }
  );
  std::cout << overlaps << std::endl;
}
