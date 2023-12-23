require 'minitest/autorun'

def caliberation_sum(file)
    sum = 0
    pattern = /^[a-zA-Z]*(?<digit>\d)\w*$/
    file.each_line(chomp: true) do |line|
        match_first = line.match(pattern)
        match_last = line.reverse.match(pattern)
        caliberation_value =  match_first["digit"] + match_last["digit"]
        sum += caliberation_value.to_i
    end
    sum
end

class CaliberationSumTest < MiniTest::Unit::TestCase
    def test_sample_input
        input = File.new("#{__dir__}/../../inputs/day1/test_p1.txt")
        expeted_sum = 331
        assert_equal expeted_sum, caliberation_sum(input)
    end

    def test_real_input
        input = File.new("#{__dir__}/../../inputs/day1/day1.txt")
        expeted_sum = 55108
        assert_equal expeted_sum, caliberation_sum(input)
    end
end