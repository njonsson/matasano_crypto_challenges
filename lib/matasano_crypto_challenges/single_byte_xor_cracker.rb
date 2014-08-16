require 'matasano_crypto_challenges/hexadecimal_string'

module MatasanoCryptoChallenges

  class SingleByteXorCracker

    attr_reader :normally_frequent_bytes

    def initialize(normally_frequent_bytes=' etaoinETAOIN'.bytes)
      self.normally_frequent_bytes = normally_frequent_bytes
    end

    def guesses(hexadecimal_string)
      guesses = []
      1.upto 255 do |key_seed|
        key = HexadecimalString.from_bytes([key_seed] * hexadecimal_string.length)
        guess = hexadecimal_string ^ key
        guesses << [guess, normalcy_score(guess)]
      end
      guesses.sort { |a, b| a.last <=> b.last }.collect(&:first).reverse
    end

    def normally_frequent_bytes=(value)
      @normally_frequent_bytes = Array(value)
    end

  private

    def frequent_bytes(hexadecimal_string)
      table = {}
      hexadecimal_string.to_bytes.each do |b|
        table[b] = table[b].to_i + 1
      end
      table.to_a.
        sort { |left, right| left.last <=> right.last }.
        reverse.
        collect(&:first).
        slice 0, normally_frequent_bytes.length
    end

    def normalcy_score(hexadecimal_string)
      normally_frequent_bytes.length -
        (frequent_bytes(hexadecimal_string) - normally_frequent_bytes).length
    end

  end

end
