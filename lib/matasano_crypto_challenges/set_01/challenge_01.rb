require 'matasano_crypto_challenges/base64_string'
require 'matasano_crypto_challenges/hexadecimal_string'

module MatasanoCryptoChallenges

  module Set01

    class Challenge01

      def base64_encode(hexadecimal_string)
        hexadecimal_string = HexadecimalString.new(hexadecimal_string)
        base64_string = Base64String.from_bytes(hexadecimal_string.to_bytes)
        base64_string.value
      end

    end

  end

end
