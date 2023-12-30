# frozen_string_literal: true
require 'minitest/autorun'


class CubeConundrum
  attr_reader :input
  CUBE_COLOR_COUNT_PATTERN = /[;,]?(?<count>\d+) (?<color>[a-z]+)[;,]?+/
  RED = "red"
  GREEN = "green"
  BLUE = "blue"

  def initialize(input)
    @input = input
  end

  def fewest_cubes
    fewest_cubes_power = []
    input.each_line(chomp: true) do |line|
      max = 0
      sets = find_sets_info(line)
      fewest_cubes = {
        "red" => 0,
        "green" => 0,
        "blue" => 0
      }

      sets.scan(CUBE_COLOR_COUNT_PATTERN).each do |match| 
        if match[1].start_with?(RED)
          color = RED
        elsif  match[1].start_with?(GREEN)
          color = GREEN
        elsif match[1].start_with?(BLUE)
          color = BLUE
        else
          next
        end
        
        fewest_cubes[color] = [fewest_cubes[color], match[0].to_i].max
      end
      fewest_cubes_power << fewest_cubes.values.inject(:*)
    end
    fewest_cubes_power.sum
  end

  def find_sets_info(line_data)
    game = line_data.split(":")
    game[1].strip
  end
end

class CubeConundrumTest <  MiniTest::Unit::TestCase
  def test_sample_input
    input = File.new("#{__dir__}/../../inputs/day2/test.txt")
    cc = CubeConundrum.new(input)
    assert_equal 2286, cc.fewest_cubes
  end

  def test_real_input
    input = File.new("#{__dir__}/../../inputs/day2/day2.txt")
    cc = CubeConundrum.new(input)
    assert_equal 63307, cc.fewest_cubes
  end
end