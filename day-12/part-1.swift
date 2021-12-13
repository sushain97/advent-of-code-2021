#!/usr/bin/env swift

import Foundation

let connectedCaves = try! String(contentsOfFile: CommandLine.arguments[1])
  .split(separator: "\n")
  .map { $0.split(separator: "-").map { String($0) } }
  .flatMap { [$0, $0.reversed()] }

let adjacencyList = Dictionary(grouping: connectedCaves) { $0[0] }
  .mapValues { $0.map { $0[1] } }

var pathCount = 0
var pendingPaths = [["start"]]

while !pendingPaths.isEmpty {
  pendingPaths = pendingPaths.flatMap { path in
    adjacencyList[path.last!, default: []].compactMap { cave in
      let smallCave = cave == cave.lowercased()
      if cave == "end" {
        pathCount += 1
      } else if !smallCave || !path.contains(cave) {
        return path + [cave]
      }

      return nil
    }
  }
}

print(pathCount)
