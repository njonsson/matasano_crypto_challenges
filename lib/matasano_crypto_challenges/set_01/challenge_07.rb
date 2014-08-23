require 'matasano_crypto_challenges/representations/base64'
require 'matasano_crypto_challenges/util'

module MatasanoCryptoChallenges

  module Set01

    class Challenge07

      def decrypt_aes128_ecb(ciphertext_base64_string: nil, key_string: nil)
        ciphertext_base64 = Representations::Base64.from_value(ciphertext_base64_string)
        result = Util.decrypt_aes128_ecb(ciphertext_representation: ciphertext_base64,
                                         key_bytes: key_string.bytes)
        result.value
      end

    end

  end

end
