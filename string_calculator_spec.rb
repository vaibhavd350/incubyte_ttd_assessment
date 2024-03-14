require_relative 'string_calculator'

RSpec.describe StringCalculator do
  describe ".calculate" do
    it "returns 0 for an empty string" do
      expect(StringCalculator.calculate("")).to eq(0)
    end

    it "returns the number for a single number" do
      expect(StringCalculator.calculate("1")).to eq(1)
    end

    it "returns the sum for two numbers separated by a comma" do
      expect(StringCalculator.calculate("1,2")).to eq(3)
    end

    it "returns the sum for an unknown amount of numbers" do
      expect(StringCalculator.calculate("1,2,3,4,5")).to eq(15)
    end

    it "allows new lines between numbers" do
      expect(StringCalculator.calculate("1\n2,3")).to eq(6)
    end

    it "supports different delimiters" do
      expect(StringCalculator.calculate("//;\n1;2;3")).to eq(6)
    end

    it "throws an exception for negative numbers" do
      expect { StringCalculator.calculate("1,-2,3,-4") }.to raise_error(ArgumentError, "negatives not allowed: -2, -4")
    end

    it "ignores numbers larger than 1000" do
      expect(StringCalculator.calculate("2,1001")).to eq(2)
    end

    it "supports delimiters of any length" do
      expect(StringCalculator.calculate("//[***]\n1***2***3")).to eq(6)
    end

    it "supports multiple delimiters" do
      expect(StringCalculator.calculate("//[*][%]\n1*2%3")).to eq(6)
    end
  end
end