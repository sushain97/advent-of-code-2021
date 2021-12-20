import scala.io.Source
import scala.collection.mutable.ListBuffer

object Part1 {
  def readPacket(binary: String): (Int, Int) = {
    val version = Integer.parseInt(binary.substring(0, 3), 2)
    val typeId = Integer.parseInt(binary.substring(3, 6), 2)

    if (typeId == 4) {
      def getLength(chunk: String): Int =
        if (chunk.charAt(0) == '0') 5
        else 5 + getLength(chunk.substring(5))

      (6 + getLength(binary.substring(6)), version)
    } else {
      var subPacketValues = ListBuffer[Int]()
      var offset = 0

      val length = binary.charAt(6) match {
        case '0' => {
          var subPacketsLength =
            Integer.parseInt(binary.substring(7, 22), 2)
          while (offset < subPacketsLength) {
            val subPacket = readPacket(
              binary.substring(22 + offset)
            )
            offset += subPacket._1
            subPacketValues += subPacket._2
          }
          22 + subPacketsLength
        }
        case '1' => {
          val subPacketsCount =
            Integer.parseInt(binary.substring(7, 18), 2)
          while (subPacketValues.length < subPacketsCount) {
            val subPacket = readPacket(
              binary.substring(18 + offset)
            )
            offset += subPacket._1
            subPacketValues += subPacket._2
          }
          18 + offset
        }
      }

      (length, version + subPacketValues.sum)
    }
  }

  def main(args: Array[String]) = {
    val binary = Source
      .fromFile(args(0))
      .getLines
      .next
      .toCharArray()
      .map(x =>
        Integer
          .parseInt(x.toString(), 16)
          .toBinaryString
          .reverse
          .padTo(4, '0')
          .reverse
      )
      .mkString("")

    println(readPacket(binary)._2)
  }
}
