require "./spec_helper"

module DiamondKata
  Spec2.describe DiamondKata do
    it "has exactly 2k + 1 lines, where k is 'letter - LOWER_BOUND'" do
      Quick.check("exactly 2k + 1 lines", [letter : UppercaseLetter]) do
        Diamond.new(letter).lines.size == 2 * number(letter) + 1
      end
    end

    it "is exactly 2k + 1 columns wide, where k is 'letter - LOWER_BOUND'" do
      Quick.check("exactly 2k + 1 columns", [letter : UppercaseLetter]) do
        Diamond.new(letter).lines.all? do |line|
          line.size == 2 * number(letter) + 1
        end
      end
    end

    it "has exactly one or two character in each line" do
      Quick.check("(1 <= letter <= 2) in each line", [letter : UppercaseLetter]) do
        Diamond.new(letter).lines.all? do |line|
          letter_count = line.chars.count { |x| UppercaseLetter::CHARS.includes?(x) }
          1 <= letter_count <= 2
        end
      end
    end

    it "is symmetric vertically" do
      Quick.check("vertical symmetry", [letter : UppercaseLetter]) do
        symmetric?(Diamond.new(letter).lines)
      end
    end

    it "is symmetric horizontally" do
      Quick.check("horizontal symmetry", [letter : UppercaseLetter]) do
        Diamond.new(letter).lines.all? do |line|
          symmetric?(line.chars)
        end
      end
    end

    it "spans range of letters over back diagonal of left-top quadrant" do
      Quick.check(
      "back diagonal of left-top quadrant is range of letters",
      [letter : UppercaseLetter]) do
        lines = Diamond.new(letter).lines
        count = number(letter)

        letter_range(letter).each_with_index.all? do |tuple|
          x, index = tuple
          lines[index][count - index] == x
        end
      end
    end

    def number(letter)
      letter - UppercaseLetter::LOWER_BOUND
    end

    def letter_range(letter)
      UppercaseLetter::LOWER_BOUND..letter
    end

    def symmetric?(array)
      array.each_with_index.all? do |tuple|
        value, index = tuple
        array[array.size - index - 1] == value
      end
    end
  end
end
