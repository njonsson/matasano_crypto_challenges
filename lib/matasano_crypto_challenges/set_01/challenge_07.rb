require 'matasano_crypto_challenges/representations/base64'
require 'openssl'

module MatasanoCryptoChallenges

  module Set01

    class Challenge07

      def decrypt_aes128_ecb(ciphertext_base64_string: nil, key_string: nil)
        ciphertext_base64 = Representations::Base64.from_value(ciphertext_base64_string)
        aes128_ecb_cipher.decrypt
        aes128_ecb_cipher.key = key_string
        plaintext_string = aes128_ecb_cipher.update(ciphertext_base64.string) +
                           aes128_ecb_cipher.final
        result = Representations::Base64.from_string(plaintext_string)
        result.value
      end

    private

      def aes128_ecb_cipher
        @aes128_ecb_cipher ||= OpenSSL::Cipher::AES.new(128, :ECB)
      end

    end

  end

end
