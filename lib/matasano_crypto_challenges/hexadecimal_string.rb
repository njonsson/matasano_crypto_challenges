module MatasanoCryptChallenges; end

class MatasanoCryptoChallenges::HexadecimalString

  attr_accessor :normalcy_score

  attr_reader :value

  def self.from_bytes(bytes)
    value = bytes.collect { |b| b.to_s(16).rjust 2, '0' }.join
    new value
  end

  def initialize(value)
    @normalcy_score = 0
    @value          = value
  end

  def ==(other)
    other.kind_of?(self.class) && (other.value == value)
  end

  def ^(other)
    result_bytes = to_bytes.zip(other.to_bytes).collect do |bytes, other_bytes|
      bytes ^ other_bytes
    end
    self.class.from_bytes result_bytes
  end

  def length
    return 0 unless value

    value.length
  end

  def to_bytes
    return [] unless value

    bytes = []
    value.chars.each_slice 2 do |nibbles|
      bytes << nibbles.join.to_i(16)
    end
    bytes
  end

  def to_s
    to_bytes.collect(&:chr).join
  end

  def valid?
    return false unless value

    ! (value.to_s =~ /^[0-9a-f]+$/i).nil?
  end

end
