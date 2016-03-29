require "quick"

module DiamondKata
  class UppercaseLetter
    include Quick::Generator(Char)
    include Quick::Shrinker(Char)

    LOWER_BOUND = 'A'
    UPPER_BOUND = 'Z'
    CHARS = (LOWER_BOUND..UPPER_BOUND).to_a

    def self.next : Char
      CHARS.sample
    end

    def self.shrink(failed_value : Char, prop : Char -> Bool) : Char
      value = next_shrink(failed_value)
      return shrink(value, prop) if can_shrink_to?(value, prop)
      failed_value
    end

    private def self.can_shrink_to?(value : Char, prop : Char -> Bool) : Bool
      in_bounds?(value) && fails?(value, prop)
    end

    private def self.in_bounds?(value : Char) : Bool
      LOWER_BOUND <= value <= UPPER_BOUND
    end

    private def self.fails?(value : Char, prop : Char -> Bool) : Bool
      !prop.call(value)
    end

    private def self.next_shrink(value : Char) : Char
      value.pred
    end
  end
end
