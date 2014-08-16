require 'matasano_crypto_challenges/hexadecimal_string'

module MatasanoCryptoChallenges

  class SingleByteXorCracker

    attr_reader :normally_frequent_bytes

    def initialize(normally_frequent_bytes=' etaoinshrdlu'.bytes)
      self.normally_frequent_bytes = normally_frequent_bytes
    end

    def guesses(hexadecimal_string, normalcy_score_threshold: 0)
      guesses = []
      1.upto 255 do |key_seed|
        key = HexadecimalString.from_bytes([key_seed] *
                                           hexadecimal_string.length)
        guess = hexadecimal_string ^ key
        if normalcy_score_threshold <= (normalcy_score = normalcy_score(guess))
          guesses << [guess, normalcy_score]
        end
      end
      guesses.sort { |a, b| a.last <=> b.last }.collect(&:first).reverse
    end

    def normalcy_score(hexadecimal_string_or_frequent_bytes)
      frequent_bytes = case hexadecimal_string_or_frequent_bytes
                         when HexadecimalString
                           frequent_bytes hexadecimal_string_or_frequent_bytes
                         when Array
                           hexadecimal_string_or_frequent_bytes
                         else
                           raise "hexadecimal_string_or_frequent_bytes must be either #{HexadecimalString.name} or #{Array.name} of bytes"
                       end
      normally_frequent_bytes.length -
        (frequent_bytes - normally_frequent_bytes).length
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

  end

end
