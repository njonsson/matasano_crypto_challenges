require 'matasano_crypto_challenges/representations/hexadecimal'
require 'matasano_crypto_challenges/single_byte_xor_cracker'

module MatasanoCryptoChallenges

  module Set01

    class Challenge04

      def find_and_crack_single_byte_xor_key(hexadecimal_strings)
        best = {normalcy_score: 0}
        hexadecimal_strings.each do |hexadecimal_string|
          hexadecimal = Representations::Hexadecimal.from_value(hexadecimal_string)
          guess = single_byte_xor_cracker.crack(hexadecimal)
          best = guess if best[:normalcy_score] < guess[:normalcy_score]
        end
        result = best[:plaintext_representation]
        result.value
      end

    private

      def single_byte_xor_cracker
        SingleByteXorCracker.new
      end

    end

  end

end
