package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
	"os"
)

type point struct {
	x, y int
}

func must(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func main() {
	file, err := os.Open(os.Args[1])
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	grid := make([][]int, 0)

	x := 0
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		grid = append(grid, []int{math.MinInt64})
		line := scanner.Text()
		for _, c := range line {
			grid[x] = append(grid[x], int(c-'0'))
		}
		grid[x] = append(grid[x], math.MinInt64)
		x++
	}
	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	bottomFrame := make([]int, len(grid[0]))
	for i := 0; i < len(grid[0]); i++ {
		bottomFrame[i] = math.MinInt64
	}
	topFrame := bottomFrame

	grid = append([][]int{topFrame}, grid...)
	grid = append(grid, bottomFrame)

	flashCount := 0

	for step := 1; step <= 100; step++ {
		flashes := make(map[point]struct{})

		for x := 0; x < len(grid); x++ {
			for y := 0; y < len(grid[x]); y++ {
				grid[x][y]++
			}
		}

		sawFlash := true
		for sawFlash {
			sawFlash = false

			for x := 0; x < len(grid); x++ {
				for y := 0; y < len(grid[x]); y++ {
					if grid[x][y] > 9 {
						if _, alreadyFlashed := flashes[point{x, y}]; !alreadyFlashed {
							flashes[point{x, y}] = struct{}{}
							flashCount++
							sawFlash = true

							for i := -1; i <= 1; i++ {
								for j := -1; j <= 1; j++ {
									if !(i == 0 && j == 0) {
										grid[x+i][y+j] += 1
									}
								}
							}
						}
					}
				}
			}
		}

		for flash := range flashes {
			grid[flash.x][flash.y] = 0
		}
	}

	fmt.Printf("%d\n", flashCount)
}
