require 'matasano_crypto_challenges/refinements/array'
require 'openssl'

using MatasanoCryptoChallenges::Refinements::Array

module MatasanoCryptoChallenges

  module Util

    def self.decrypt_aes128_ecb(ciphertext_representation: nil, key_bytes: nil)
      aes128_ecb_cipher = OpenSSL::Cipher::AES.new(128, :ECB)
      aes128_ecb_cipher.decrypt
      aes128_ecb_cipher.key = Array(key_bytes).collect(&:chr).join
      plaintext_string = aes128_ecb_cipher.update(ciphertext_representation.string) +
                         aes128_ecb_cipher.final
      ciphertext_representation.class.from_string plaintext_string
    end

    def self.xor_with_repeating_key(content_representation: nil, key_bytes: nil)
      repeated_key_bytes = Array(key_bytes).repeat_to(content_representation.bytes.length)
      repeated_key_representation = content_representation.class.from_bytes(repeated_key_bytes)
      content_representation ^ repeated_key_representation
    end

  end

end
