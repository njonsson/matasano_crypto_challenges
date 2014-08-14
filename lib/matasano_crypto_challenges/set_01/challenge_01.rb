module MatasanoCryptoChallenges

  module Set01; end

end

class MatasanoCryptoChallenges::Set01::Challenge01

  BASE64 = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
              a b c d e f g h i j k l m n o p q r s t u v w x y z
              0 1 2 3 4 5 6 7 8 9 + /)

  HEX = '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'

  def call
    base64
  end

private

  def base64
    base64 = []
    each_6bit_slice do |bits|
      base64 << BASE64[bits.to_i(2)]
    end
    base64.join
  end

  def each_6bit_slice
    HEX.chars.each_slice 6 do |nibbles_3_bytes|
      bits_3_bytes = []
      nibbles_3_bytes.each_slice 2 do |nibbles_1_byte|
        bits_3_bytes << nibbles_1_byte.join.to_i(16).to_s(2).rjust(8, '0')
      end
      bits_3_bytes.join.chars.each_slice 6 do |bits|
        yield bits.join
      end
    end
  end

end
