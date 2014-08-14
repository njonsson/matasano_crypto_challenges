require 'matasano_crypto_challenges/hexadecimal_string'

module MatasanoCryptoChallenges

  module Set01

    class Challenge02

      def xor(hexadecimal_string1, hexadecimal_string2)
        (HexadecimalString.new(hexadecimal_string1) ^ HexadecimalString.new(hexadecimal_string2)).value
      end

    end

  end

end
