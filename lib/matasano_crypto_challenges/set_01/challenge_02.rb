require 'matasano_crypto_challenges/representations/hexadecimal'

module MatasanoCryptoChallenges

  module Set01

    class Challenge02

      def xor(hexadecimal_string1, hexadecimal_string2)
        hexadecimal1 = Representations::Hexadecimal.from_value(hexadecimal_string1)
        hexadecimal2 = Representations::Hexadecimal.from_value(hexadecimal_string2)
        result = hexadecimal1 ^ hexadecimal2
        result.value
      end

    end

  end

end
