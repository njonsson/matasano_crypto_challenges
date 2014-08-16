require 'matasano_crypto_challenges/hexadecimal_string'

module MatasanoCryptoChallenges

  class SingleByteXorCracker

    attr_reader :normally_frequent_bytes

    def initialize(normally_frequent_bytes=' etaoinshrdlu'.bytes)
      @normally_frequent_bytes = Array(normally_frequent_bytes)
    end

    def crack(hexadecimal_string)
      best = HexadecimalString.from_bytes([])
      1.upto 255 do |key_seed|
        key = HexadecimalString.from_bytes([key_seed] *
                                           hexadecimal_string.length)
        guess = (hexadecimal_string ^ key)
        if best.normalcy_score < (guess.normalcy_score = normalcy_score(guess))
          best = guess
        end
      end
      best
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
      frequent_bytes = frequent_bytes(hexadecimal_string)
      normally_frequent_bytes.length -
        (frequent_bytes - normally_frequent_bytes).length
    end

  end

end
