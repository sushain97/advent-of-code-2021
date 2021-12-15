use std::cmp::Ordering;
use std::collections::BinaryHeap;
use std::convert::{TryFrom, TryInto};
use std::env;
use std::fs::File;
use std::io::{BufRead, BufReader};

#[derive(Copy, Clone, Eq, PartialEq)]
struct Chiton {
    risk: usize,
    position: (usize, usize),
}

impl Ord for Chiton {
    fn cmp(&self, other: &Self) -> Ordering {
        other.risk.cmp(&self.risk)
    }
}

impl PartialOrd for Chiton {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

fn main() {
    let grid = BufReader::new(File::open(env::args().nth(1).unwrap()).unwrap())
        .lines()
        .map(|l| {
            l.unwrap()
                .chars()
                .map(|c| c.to_digit(10).unwrap().try_into().unwrap())
                .collect::<Vec<usize>>()
        })
        .collect::<Vec<_>>();

    let mut frontier = BinaryHeap::from([Chiton {
        position: (0, 0),
        risk: 0,
    }]);

    let mut risks = (0..grid[0].len())
        .map(|_| vec![usize::MAX; grid.len()])
        .collect::<Vec<Vec<usize>>>();

    let mut current = Chiton {
        position: (0, 0),
        risk: 0,
    };
    let destination = (grid[0].len() - 1, grid.len() - 1);

    while current.position != destination {
        let x: isize = current.position.0.try_into().unwrap();
        let y: isize = current.position.1.try_into().unwrap();

        for (nx, ny) in [(x, y - 1), (x, y + 1), (x - 1, y), (x + 1, y)]
            .iter()
            .filter(|(x, y)| {
                *x >= 0
                    && *x < grid[0].len().try_into().unwrap()
                    && *y >= 0
                    && *y < grid.len().try_into().unwrap()
            })
            .map(|(x, y)| (usize::try_from(*x).unwrap(), usize::try_from(*y).unwrap()))
        {
            let neighbor_distance = current.risk + grid[ny][nx];
            if neighbor_distance < risks[ny][nx] {
                frontier.push(Chiton {
                    position: (nx, ny),
                    risk: neighbor_distance,
                });
                risks[ny][nx] = neighbor_distance;
            }
        }

        current = frontier.pop().unwrap();
    }

    println!("{}", risks[destination.1][destination.0]);
}
