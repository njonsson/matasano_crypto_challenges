require 'matasano_crypto_challenges/representations/hexadecimal'
require 'matasano_crypto_challenges/single_byte_xor_cracker'

module MatasanoCryptoChallenges

  module Set01

    class Challenge03

      def cryptanalyze(hexadecimal_string)
        hexadecimal = Representations::Hexadecimal.from_value(hexadecimal_string)
        result = single_byte_xor_cracker.crack(hexadecimal)
        result.value
      end

    private

      def single_byte_xor_cracker
        SingleByteXorCracker.new
      end

    end

  end

end
