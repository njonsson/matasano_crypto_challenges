require 'matasano_crypto_challenges/refinements/array'
require 'matasano_crypto_challenges/representations/hexadecimal'
require 'matasano_crypto_challenges/util'

using MatasanoCryptoChallenges::Refinements::Array

module MatasanoCryptoChallenges

  module Set01

    class Challenge05

      def xor_with_repeating_key(plaintext_hexadecimal_string: nil,
                                 key_hexadecimal_string: nil)
        plaintext_hexadecimal = Representations::Hexadecimal.from_value(plaintext_hexadecimal_string)
        key_bytes = Representations::Hexadecimal.from_value(key_hexadecimal_string).bytes
        result = Util.xor_with_repeating_key(content_representation: plaintext_hexadecimal,
                                             key: key_bytes)
        result.value
      end

    end

  end

end
