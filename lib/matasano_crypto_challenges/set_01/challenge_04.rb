require 'matasano_crypto_challenges/hexadecimal_string'
require 'matasano_crypto_challenges/single_byte_xor_cracker'

module MatasanoCryptoChallenges

  module Set01

    class Challenge04

      def find_and_cryptanalyze(hexadecimal_strings)
        result = HexadecimalString.from_bytes([])
        hexadecimal_strings.each do |hexadecimal_string|
          hexadecimal_string = HexadecimalString.new(hexadecimal_string)
          guess = single_byte_xor_cracker.crack(hexadecimal_string)
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
