require 'matasano_crypto_challenges/hexadecimal_string'
require 'matasano_crypto_challenges/single_byte_xor_cracker'

module MatasanoCryptoChallenges

  module Set01

    class Challenge03

      def cryptanalyze(hexadecimal_string)
        hexadecimal_string = HexadecimalString.new(hexadecimal_string)
        ordered_guesses = single_byte_xor_cracker.guesses(hexadecimal_string)
        result = ordered_guesses.first
        result.value
      end

    private

      def single_byte_xor_cracker
        SingleByteXorCracker.new
      end

    end

  end

end
