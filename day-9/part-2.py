import collections
import sys

if __name__ == "__main__":
    with open(sys.argv[1]) as f:
        lines = f.read().splitlines()
        grid = [
            [9] * (len(lines[0]) + 2),
            *[[9, *map(int, l), 9] for l in lines],
            [9] * (len(lines[0]) + 2),
        ]

        low_points = {
            (x, y)
            for x in range(1, len(grid) - 1)
            for y in range(1, len(lines[0]) + 1)
            if all(
                grid[x][y] < grid[x + dx][y + dy] for dx, dy in [(0, 1), (1, 0), (0, -1), (-1, 0)]
            )
        }

        basins = collections.defaultdict(int)
        for x in range(1, len(grid) - 1):
            for y in range(1, len(lines[0]) + 1):
                if grid[x][y] != 9:
                    i, j = x, y

                    while (i, j) not in low_points:
                        for dx, dy in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
                            if grid[i + dx][j + dy] < grid[i][j]:
                                i, j = i + dx, j + dy
                                break

                    basins[(i, j)] += 1

        a, b, c, *rest = sorted(basins.values(), reverse=True)
        print(a * b * c)
