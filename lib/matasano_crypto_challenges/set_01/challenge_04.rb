require 'matasano_crypto_challenges/hexadecimal_string'
require 'matasano_crypto_challenges/single_byte_xor_cracker'

module MatasanoCryptoChallenges

  module Set01

    class Challenge04

      def find_and_cryptanalyze(hexadecimal_strings)
        best = [nil, 0]
        hexadecimal_strings.each do |hexadecimal_string|
          hexadecimal_string = HexadecimalString.new(hexadecimal_string)
          ordered_guesses = single_byte_xor_cracker.guesses(hexadecimal_string,
                                                            normalcy_score_threshold: best.last)
          unless (guess = ordered_guesses.first)
            next
          end
          normalcy_score = single_byte_xor_cracker.normalcy_score(guess)
          best = [guess, normalcy_score] if best.last < normalcy_score
        end
        result = best.first
        result.value
      end

    private

      def single_byte_xor_cracker
        SingleByteXorCracker.new
      end

    end

  end

end
