#!/usr/bin/env ruby
# frozen_string_literal: true

if $PROGRAM_NAME == __FILE__
  adjacency_list = File.read(ARGV.fetch(0))
                       .lines(chomp: true)
                       .map { _1.split('-') }
                       .flat_map { [_1, _1.reverse] }
                       .group_by(&:first)
                       .transform_values { _1.map(&:last) }

  paths = []
  pending_paths = [['start']]

  while pending_paths.any?
    pending_paths = pending_paths.flat_map do |path|
      frontier = adjacency_list.fetch(path.last, [])
      frontier.filter_map do |cave|
        small_cave = cave.downcase == cave
        if cave == 'end'
          paths << path + [cave]
          nil
        elsif !small_cave || !path.include?(cave)
          path + [cave]
        end
      end
    end
  end

  puts paths.length
end
