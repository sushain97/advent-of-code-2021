package main

import java.io.File

class Part1 {
  companion object {
    @JvmStatic
    fun main(args: Array<String>) {
      val (xTarget, yTarget) =
          File(args[0]).readText().split(": ")[1].split(", ").map {
            it.split("=")[1].split("..").map { it.toInt() }
          }

      println(
          (0..(xTarget[1] + 1))
              .flatMap { vXStart ->
                (yTarget[0]..-yTarget[0]).map(
                    fun(vYStart): Int {
                      var (vX, vY) = arrayOf(vXStart, vYStart)
                      var (x, y) = arrayOf(0, 0)
                      var maxY = 0

                      while (x <= xTarget[1] && yTarget[0] <= y) {
                        if (xTarget[0] <= x && x <= xTarget[1] && yTarget[0] <= y && y <= yTarget[1]
                        ) {
                          return maxOf(maxY, y)
                        }

                        x += vX
                        y += vY

                        if (vX != 0) {
                          vX += if (vX > 0) -1 else 1
                        }
                        vY--

                        maxY = maxOf(maxY, y)
                      }

                      return 0
                    }
                )
              }
              .maxOrNull()
      )
    }
  }
}
