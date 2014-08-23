require 'matasano_crypto_challenges/multibyte_xor_cracker'
require 'matasano_crypto_challenges/representations/base64'

module MatasanoCryptoChallenges

  module Set01

    class Challenge06

      def crack_multibyte_xor(ciphertext_base64_string)
        ciphertext_base64 = Representations::Base64.from_value(ciphertext_base64_string)
        result = multibyte_xor_cracker.crack(ciphertext_base64)
        result[:plaintext_representation].value
      end

    private

      def multibyte_xor_cracker
        MultibyteXORCracker.new
      end

    end

  end

end

