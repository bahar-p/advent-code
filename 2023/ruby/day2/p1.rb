require 'minitest/autorun'
require 'pry-byebug'

class CubeConundrum
  attr_reader :input, :bag

  GAME_INFO_PATTERN = /^Game (?<id>\d+): (?<sets>.+)$/
  CUBE_COLOR_COUNT_PATTERN = /\A(?<count>\d+) (?<color>[a-z]+)\z/

  def initialize(input)
    @input = input
    @bag = {
      "red" => 12,
      "green" => 13,
      "blue" => 14
    }
    @eligible_ids = []
  end

  def eligible_games_id_sum
    possible_game_ids.sum
  end

  def possible_game_ids
    input.each_line(chomp: true) do |line|
      game_id, sets = extract_game_info(line)
      game_possible = true
      sets.each do |set|
        cubes = set.split(",").map(&:strip)
        break if !game_possible

        cubes.each do |cube|
          match = cube.match(CUBE_COLOR_COUNT_PATTERN)
          count = match["count"]
          color = match["color"]
          if !set_possible?(color, count)
            game_possible = false 
            break
          end
        end
      end
      @eligible_ids << game_id.to_i if game_possible
    end

    @eligible_ids
  end

  def extract_game_info(line_data)
    match = line_data.match(GAME_INFO_PATTERN)
    game_id = match["id"]
    sets = match["sets"]
    sets_array = sets.split(";").map(&:strip)

    [game_id, sets_array]
  end

  def set_possible?(color, count)
    count.to_i <= bag[color]
  end
end




class CubeConundrumTest <  MiniTest::Unit::TestCase
  def test_sample_input
    input = File.new("#{__dir__}/../../inputs/day2/test_p1.txt")
    cc = CubeConundrum.new(input)
    assert_equal 8, cc.eligible_games_id_sum
  end

  def test_real_input
    input = File.new("#{__dir__}/../../inputs/day2/day2.txt")
    cc = CubeConundrum.new(input)
    assert_equal 2416, cc.eligible_games_id_sum
  end
end