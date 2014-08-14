module MatasanoCryptChallenges; end

class MatasanoCryptoChallenges::HexadecimalString

  attr_reader :value

  def self.from_bytes(bytes)
    value = bytes.collect { |b| b.to_s(16).rjust 2, '0' }.join
    new value
  end

  def initialize(value)
    @value = value
  end

  def ==(other)
    other.kind_of?(self.class) && (other.value == value)
  end

  def ^(hexadecimal_string)
    bytes = to_bytes.zip(hexadecimal_string.to_bytes).collect do |this, that|
      this ^ that
    end
    self.class.from_bytes bytes
  end

  def to_bytes
    bytes = []
    value.chars.each_slice 2 do |nibbles|
      bytes << nibbles.join.to_i(16)
    end
    bytes
  end

  def valid?
    return false unless value

    ! (value.to_s =~ /^[0-9a-f]+$/i).nil?
  end

end
