module MatasanoCryptChallenges; end

class MatasanoCryptoChallenges::Base64String

  TABLE = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
             a b c d e f g h i j k l m n o p q r s t u v w x y z
             0 1 2 3 4 5 6 7 8 9 + /).freeze

  INVERSE_TABLE = {}.tap do |inverse_table|
    TABLE.each_with_index do |item, index|
      raise "Duplicate entry #{item.inspect} in TABLE" if inverse_table[item]

      inverse_table[item] = index
    end
    inverse_table.freeze
  end

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
    self
  end

  def self.each_8bit_slice(base64_chars)
    base64_chars.each_slice 4 do |four_chars|
      bits_4_chars = []
      four_chars.each do |char|
        if (index = TABLE.index(char))
          bits_4_chars << index.to_s(2).rjust(6, '0')
        else
          # Give up early since we encountered an illegal Base-64 character.
          return self
        end
      end
      bits_4_chars.join.chars.each_slice 8 do |bits|
        yield bits.join
      end
    end
    self
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

  def length
    return 0 unless value

    value.length
  end

  def to_bytes
    return [] unless value

    bytes = []
    self.class.each_8bit_slice value.chars do |eight_bits|
      bytes << eight_bits.to_i(2)
    end
    bytes
  end

  def to_s
    to_bytes.collect(&:chr).join
  end

  def valid?
    return false unless value

    ! (value.to_s =~ /^[0-9a-z+\/]+$/i).nil?
  end

end
