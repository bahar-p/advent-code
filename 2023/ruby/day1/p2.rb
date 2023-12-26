require 'minitest/autorun'
require 'pry-byebug'

LETTER_DIGIT = {
 1 => "one",
 2 => "two",
 3 => "three",
 4 => "four",
 5 => "five",
 6 => "six",
 7 => "seven",
 8 => "eight",
 9 => "nine" 
}

LETTER_DIGIT_REVERSE = {
  1 => "eno",
  2 => "owt",
  3 => "eerht",
  4 => "ruof",
  5 => "evif",
  6 => "xis",
  7 => "neves",
  8 => "thgie",
  9 => "enin" 
 }

LETTER_PATTERN = "#{LETTER_DIGIT[1]}|#{LETTER_DIGIT[2]}|#{LETTER_DIGIT[3]}|#{LETTER_DIGIT[4]}|#{LETTER_DIGIT[5]}|#{LETTER_DIGIT[6]}|#{LETTER_DIGIT[7]}|#{LETTER_DIGIT[8]}|#{LETTER_DIGIT[9]}"
LETTER_REVERSE_PATTERN = "#{LETTER_DIGIT_REVERSE[1]}|#{LETTER_DIGIT_REVERSE[2]}|#{LETTER_DIGIT_REVERSE[3]}|#{LETTER_DIGIT_REVERSE[4]}|#{LETTER_DIGIT_REVERSE[5]}|#{LETTER_DIGIT_REVERSE[6]}|#{LETTER_DIGIT_REVERSE[7]}|#{LETTER_DIGIT_REVERSE[8]}|#{LETTER_DIGIT_REVERSE[9]}"

def caliberation_sum(file)
    sum = 0
    file.each_line(chomp: true) do |line|
      reverse_line = line.reverse
      first_match = ""
      last_match = ""

      (0..line.length).each do |i|
        if line.start_with?(/\d/)
          first_match = line[0]
          # find the last match
          last_match = find_match(reverse_line)
          break if last_match

        elsif line.start_with?(/#{LETTER_PATTERN}/)
          match = line.match(/#{LETTER_PATTERN}/)
          first_match = match[0]
          # find the last match
          last_match = find_match(reverse_line)
          break if last_match
        else
          line.slice!(0, 1)
        end
      end

      first_digit = find_matching_digit(first_match)
      last_digit = find_matching_digit(last_match)
      caliberation_value = first_digit + last_digit
      sum += caliberation_value.to_i
    end
    puts "Sum: #{sum}"
    sum
end

def find_match(line)
  digit_match = nil
  if line.start_with?(/\d/)
    digit_match = line[0]
  elsif line.start_with?(/#{LETTER_REVERSE_PATTERN}/)
    match = line.match(/#{LETTER_REVERSE_PATTERN}/)

    digit_match = match[0].reverse
  else
    line.slice!(0,1)
  end
  digit_match
end

def find_matching_digit(value, source: LETTER_DIGIT)
  return "" if value.empty?
  return value if value.length == 1
  digit = source.select { |_key, hash_value| value == hash_value }
  digit.keys.first&.to_s
end

class CaliberationSumTest < MiniTest::Unit::TestCase
    def test_sample_input
      input = File.new("#{__dir__}/../../inputs/day1/test_p2.txt")
      expeted_sum = 281
      assert_equal expeted_sum, caliberation_sum(input)
    end

    def test_real_input
      input = File.new("#{__dir__}/../../inputs/day1/day1.txt")
      expeted_sum = 56324
      assert_equal expeted_sum, caliberation_sum(input)
    end
end