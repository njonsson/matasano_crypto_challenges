require 'matasano_crypto_challenges/refinements/string_refinements'
require 'matasano_crypto_challenges/representations/hexadecimal'

using MatasanoCryptoChallenges::Refinements::StringRefinements

module MatasanoCryptoChallenges

  module Set01

    class Challenge05

      def xor_with_repeating_key(plaintext_hexadecimal_string: nil,
                                 key_hexadecimal_string: nil)
        plaintext_hexadecimal = Representations::Hexadecimal.from_value(plaintext_hexadecimal_string)
        key_hexadecimal = Representations::Hexadecimal.from_value(key_hexadecimal_string.extend_to(plaintext_hexadecimal_string.length))
        result = plaintext_hexadecimal ^ key_hexadecimal
        result.value
      end

    end

  end

end
