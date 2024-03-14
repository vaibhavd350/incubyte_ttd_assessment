# string_calculator.rb

class StringCalculator
  def self.calculate(numbers)
    return 0 if numbers.empty?

    delimiters, numbers_string = extract_delimiters(numbers)
    numbers_array = parse_numbers(numbers_string, delimiters)
    validate_numbers(numbers_array)
    calculate_sum(numbers_array)
  end

  private

  def self.extract_delimiters(numbers)
    if numbers.start_with?("//")
      delimiter_section, numbers_section = numbers.split("\n", 2)
      delimiters = delimiter_section.gsub("//", "").split(/[\[\]]+/).reject(&:empty?)
      numbers_section ||= ""
    else
      delimiters = [",", "\n"]
      numbers_section = numbers
    end
    [delimiters, numbers_section]
  end

  def self.parse_numbers(numbers_string, delimiters)
    delimiters_regex = Regexp.union(delimiters)
    numbers_string.split(delimiters_regex).map(&:to_i)
  end

  def self.validate_numbers(numbers_array)
    negatives = numbers_array.select { |num| num.negative? }
    raise ArgumentError, "negatives not allowed: #{negatives.join(', ')}" if negatives.any?
  end

  def self.calculate_sum(numbers_array)
    numbers_array.reject { |num| num > 1000 }.sum
  end
end
