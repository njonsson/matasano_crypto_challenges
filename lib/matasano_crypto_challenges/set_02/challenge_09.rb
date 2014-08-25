require 'matasano_crypto_challenges/representations/hexadecimal'

module MatasanoCryptoChallenges

  module Set02

    class Challenge09

      def pkcs7_pad(content: nil, block_size: nil)
        content_hexadecimal = Representations::Hexadecimal.from_string(content)
        result = content_hexadecimal.pad_pkcs7(block_size)
        result.string
      end

    end

  end

end
