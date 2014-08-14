module MatasanoCryptChallenges; end

class MatasanoCryptoChallenges::Base64String

  TABLE = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
             a b c d e f g h i j k l m n o p q r s t u v w x y z
             0 1 2 3 4 5 6 7 8 9 + /)

  attr_reader :value

  def self.each_6bit_slice(bytes)
    bytes.each_slice 3 do |three_bytes|
      bits_3_bytes = []
      three_bytes.each do |byte|
        bits_3_bytes << byte.to_s(2).rjust(8, '0')
      end
      bits_3_bytes.join.chars.each_slice 6 do |bits|
        yield bits.join
      end
    end
  end

  def self.from_bytes(bytes)
    value = []
    each_6bit_slice bytes do |six_bits|
      value << TABLE[six_bits.to_i(2)]
    end
    new value.join
  end

  def initialize(value)
    @value = value
  end

  def ==(other)
    other.kind_of?(self.class) && (other.value == value)
  end

  def valid?
    return false unless value

    ! (value.to_s =~ /^[0-9a-z+\/]+$/i).nil?
  end

end
