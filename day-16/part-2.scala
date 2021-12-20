import scala.io.Source
import scala.collection.mutable.ListBuffer

object Part2 {
  def readPacket(binary: String): (Int, Long) = {
    val version = Integer.parseInt(binary.substring(0, 3), 2)
    val typeId = Integer.parseInt(binary.substring(3, 6), 2)

    if (typeId == 4) {
      def getValue(chunk: String): (String, Int) =
        if (chunk.charAt(0) == '0') (chunk.substring(1, 5), 5)
        else
          getValue(chunk.substring(5)) match {
            case (binaryValue, length) =>
              (chunk.substring(1, 5) + binaryValue, length + 5)
          }

      val (binaryValue, length) = getValue(binary.substring(6))
      (6 + length, java.lang.Long.parseLong(binaryValue, 2))
    } else {
      var subPacketValues = ListBuffer[Long]()
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

      val value = typeId match {
        case 0 => subPacketValues.sum
        case 1 => subPacketValues.product
        case 2 => subPacketValues.min
        case 3 => subPacketValues.max
        case 5 => if (subPacketValues(0) > subPacketValues(1)) 1 else 0
        case 6 => if (subPacketValues(0) < subPacketValues(1)) 1 else 0
        case 7 => if (subPacketValues(0) == subPacketValues(1)) 1 else 0
      }

      (length, value)
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
