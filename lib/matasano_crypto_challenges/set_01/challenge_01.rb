require 'matasano_crypto_challenges/representations/base64'
require 'matasano_crypto_challenges/representations/hexadecimal'

module MatasanoCryptoChallenges

  module Set01

    class Challenge01

      def base64_encode(hexadecimal_string)
        hexadecimal = Representations::Hexadecimal.from_value(hexadecimal_string)
        result = Representations::Base64.from_bytes(hexadecimal.bytes)
        result.value
      end

    end

  end

end
