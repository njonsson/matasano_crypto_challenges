require 'matasano_crypto_challenges/representations/hexadecimal'

module MatasanoCryptoChallenges

  module Set01

    class Challenge08

      def index_of_aes128_ecb(hexadecimal_strings)
        hexadecimal_strings.index do |hexadecimal_string|
          hexadecimal = Representations::Hexadecimal.from_value(hexadecimal_string)
          duplicate_block? hexadecimal
        end
      end

    private

      def duplicate_block?(representation)
        blocks = {}
        representation.bytes.each_slice 16 do |block|
          return true if blocks[block]

          blocks[block] = true
        end
        false
      end

    end

  end

end
