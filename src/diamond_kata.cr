require "./*"

module DiamondKata
  class Diamond
    def initialize(@letter)
    end

    def lines
      letters.map do |letter|
        line_for(letter)
      end
    end

    private def line_for(letter)
      symmetric(half_line_for(letter))
    end

    private def half_line_for(letter)
      left_pad_for(letter) + "#{letter}" + right_pad_for(letter)
    end

    private def symmetric(string)
      string + string[0...-1].reverse
    end

    private def left_pad_for(letter)
      pad(left_pad_size_for(letter))
    end

    private def left_pad_size_for(letter)
      pad_size - right_pad_size_for(letter)
    end

    private def right_pad_for(letter)
      pad(right_pad_size_for(letter))
    end

    private def right_pad_size_for(letter)
      letter - UppercaseLetter::LOWER_BOUND
    end

    private def pad(size)
      " " * size
    end

    private def pad_size
      (letters.size - 1) / 2
    end

    private def letters
      first_half + second_half
    end

    private def first_half
      upto(@letter)
    end

    private def second_half
      upto(@letter.pred).reverse
    end

    private def upto(letter)
      (UppercaseLetter::LOWER_BOUND..letter).to_a
    end
  end
end
