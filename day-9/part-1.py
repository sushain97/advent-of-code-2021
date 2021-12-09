import sys

if __name__ == "__main__":
    lines = [s.strip() for s in open(sys.argv[1]).readlines()]

    grid = (
        [[9] * (len(lines[0]) + 2)]
        + [[9] + list(map(int, l)) + [9] for l in lines]
        + [[9] * (len(lines[0]) + 2)]
    )

    print(
        sum(
            grid[x][y]
            for x in range(1, len(grid) - 1)
            for y in range(1, len(lines[0]) + 1)
            if all(
                grid[x][y] < grid[x + dx][y + dy] for dx, dy in [(0, 1), (1, 0), (0, -1), (-1, 0)]
            )
        )
    )
