#!/usr/bin/env ruby
# frozen_string_literal: true

def read_packet(binary)
  version = binary[..2].to_i(2)
  type_id = binary[3..5].to_i(2)

  if type_id == 4
    offset = 6
    loop do
      chunk = binary[offset..(offset + 4)]
      break if chunk[0] == '0'

      offset += 5
    end

    [6 + offset - 1, version]
  else
    sub_packet_values = []
    offset = 0
    length_type_id = binary[6]

    if length_type_id == '0'
      sub_packets_length = binary[7..21].to_i(2)
      while offset < sub_packets_length
        sub_packet = read_packet(binary[(22 + offset)..])
        offset += sub_packet[0]
        sub_packet_values.push(sub_packet[1])
      end
      length = 22 + sub_packets_length
    else
      sub_packet_count = binary[7..17].to_i(2)
      while sub_packet_values.length < sub_packet_count
        sub_packet = read_packet(binary[(18 + offset)..])
        offset += sub_packet[0]
        sub_packet_values.push(sub_packet[1])
      end
      length = 18 + offset
    end

    [length, version + sub_packet_values.sum]
  end
end

if __FILE__ == $PROGRAM_NAME
  binary = File
    .read(ARGV.fetch(0))
    .chars
    .map { _1.to_i(16).to_s(2).rjust(4, '0') }
    .join
  puts read_packet(binary)[1]
end
