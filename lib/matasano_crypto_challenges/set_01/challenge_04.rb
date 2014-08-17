require 'matasano_crypto_challenges/representations/hexadecimal'
require 'matasano_crypto_challenges/single_byte_xor_cracker'

module MatasanoCryptoChallenges

  module Set01

    class Challenge04

      def find_and_cryptanalyze(hexadecimal_strings)
        result = Representations::Hexadecimal.from_bytes([])
        hexadecimal_strings.each do |hexadecimal_string|
          hexadecimal = Representations::Hexadecimal.from_value(hexadecimal_string)
          guess = single_byte_xor_cracker.crack(hexadecimal)
          result = guess if result.normalcy_score < guess.normalcy_score
        end
        result.value
      end

    private

      def single_byte_xor_cracker
        SingleByteXorCracker.new
      end

    end

  end

end
