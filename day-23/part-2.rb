#!/usr/bin/env ruby
# frozen_string_literal: true

HALLWAY_LENGTH = 11
ROOM_SIZE = 4
GOAL = 'ABCD'.chars.map { (_1 * ROOM_SIZE).chars }.freeze
ROOM_POSITIONS = { 'A' => 2, 'B' => 4, 'C' => 6, 'D' => 8 }.freeze
ROOM_INDICES = 'ABCD'.chars.map.with_index.to_h.freeze
POSSIBLE_HALLWAY_POSITIONS = ((0...HALLWAY_LENGTH).to_a - ROOM_POSITIONS.values).freeze
ENERGY_MAP = {
  'A' => 1,
  'B' => 10,
  'C' => 100,
  'D' => 1000
}.freeze

def min_organize_energy(hallway, rooms, energy_memo)
  return 0 if rooms == GOAL
  return energy_memo[[hallway, rooms]] if energy_memo.key?([hallway, rooms])

  hallway_moves = hallway.filter_map.with_index do |hallway_pod, hallway_pos|
    next unless hallway_pod

    room_idx = ROOM_INDICES[hallway_pod]
    room = rooms[room_idx]
    next unless room.all? { _1.nil? || _1 == hallway_pod }

    room_pos = ROOM_POSITIONS[hallway_pod]
    next unless (hallway_pos < room_pos && (hallway_pos + 1..room_pos).none? { hallway[_1] }) ||
                (hallway_pos > room_pos && (room_pos...hallway_pos).none? { hallway[_1] })

    room_slot = room.map.with_index.reject(&:first).max_by(&:last).last
    [hallway_pos, [room_idx, room_slot]]
  end

  room_moves = rooms.flat_map.with_index do |room, room_idx|
    next if room == GOAL[room_idx]

    goal_room_pod = GOAL[room_idx][0]
    room.filter_map.with_index do |room_pod, room_slot|
      next unless room_pod
      next if room.filter.with_index { _2 >= room_slot }.all? { _1 == goal_room_pod }
      next if room.filter.with_index { _2 < room_slot && !_1.nil? }.any?

      possible_hallway_positions = POSSIBLE_HALLWAY_POSITIONS
      room_hallway_pos = ROOM_POSITIONS[goal_room_pod]
      hallway.each.with_index do |hallway_pod, hallway_pos|
        next unless hallway_pod

        possible_hallway_positions -= if hallway_pos <= room_hallway_pos
                                        (0..hallway_pos).to_a
                                      else
                                        (hallway_pos...HALLWAY_LENGTH).to_a
                                      end
      end

      [[room_idx, room_slot], possible_hallway_positions]
    end
  end.compact

  return energy_memo[[hallway, rooms]] = nil if hallway_moves.empty? && room_moves.empty?

  future_energies = []

  future_energies += hallway_moves.map do |hallway_pos, (room_idx, room_slot)|
    pod = hallway[hallway_pos]

    new_hallway = hallway.dup
    new_hallway[hallway_pos] = nil

    new_rooms = rooms.map(&:dup).dup
    new_rooms[room_idx][room_slot] = pod
    new_rooms.each(&:freeze)

    move_count = (hallway_pos - ROOM_POSITIONS[pod]).abs + room_slot + 1
    move_energy = ENERGY_MAP[pod] * move_count

    min_organize_energy(new_hallway.freeze, new_rooms.freeze, energy_memo)&.+(move_energy)
  end

  future_energies += room_moves.flat_map do |(room_idx, room_slot), hallway_positions|
    pod = rooms[room_idx][room_slot]

    new_rooms = rooms.map(&:dup).dup
    new_rooms[room_idx][room_slot] = nil
    new_rooms.each(&:freeze)

    hallway_positions.map do |hallway_pos|
      new_hallway = hallway.dup
      new_hallway[hallway_pos] = pod

      move_count = (hallway_pos - ROOM_POSITIONS.values[room_idx]).abs + room_slot + 1
      move_energy = ENERGY_MAP[pod] * move_count

      min_organize_energy(new_hallway.freeze, new_rooms.freeze, energy_memo)&.+(move_energy)
    end
  end

  energy_memo[[hallway, rooms]] = future_energies.compact.min
end

if $PROGRAM_NAME == __FILE__
  hallway = ([nil] * HALLWAY_LENGTH).freeze

  rooms = File
          .read(ARGV.fetch(0))
          .lines(chomp: true)[2..3]
          .map { _1.split('#').last(4) }
          .transpose
  rooms[0].insert(1, 'D', 'D')
  rooms[1].insert(1, 'C', 'B')
  rooms[2].insert(1, 'B', 'A')
  rooms[3].insert(1, 'A', 'C')

  puts min_organize_energy(hallway, rooms.map(&:freeze).freeze, {})
end
