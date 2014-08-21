module MatasanoCryptoChallenges

  module Representations; end

end

class MatasanoCryptoChallenges::Representations::Abstract

  VALID_BLOCK_SIZE = (1..255).freeze

  attr_reader :value

  def self.from_bytes(bytes)
    new bytes: bytes
  end

  def self.from_string(string)
    new string: string
  end

  def self.from_value(value)
    new value: value
  end

  def initialize(attributes={})
    @bytes  = attributes[:bytes]
    @string = attributes[:string]
    @value  = attributes[:value]
  end

  def ==(other)
    other.kind_of?(self.class) &&
      (other.bytes  == bytes)  &&
      (other.string == string) &&
      (other.value  == value)
  end

  def ^(other)
    result_bytes = bytes.zip(other.bytes).collect do |bytes, other_bytes|
      bytes ^ other_bytes
    end
    self.class.from_bytes result_bytes
  end

  def bits
    bytes.collect do |b|
      b.to_s(2).rjust(8, '0').split('').collect(&:to_i)
    end.flatten
  end

  def bytes
    return @bytes if @bytes

    return nil unless @string

    @bytes = @string.bytes
  end

  def hamming_distance(other)
    (self ^ other).bits.inject(&:+)
  end

  def pad_pkcs7(block_size)
    unless VALID_BLOCK_SIZE.include?(block_size)
      raise ArgumentError, "block_size must be in #{VALID_BLOCK_SIZE.inspect}"
    end

    number_of_padding_bytes = (block_size < bytes.length)     ?
                              bytes.length.modulo(block_size) :
                              (block_size - bytes.length)
    return self.dup if number_of_padding_bytes.zero?

    padding = [number_of_padding_bytes] * number_of_padding_bytes
    self.class.from_bytes(bytes + padding)
  end

  def string
    return @string if @string

    return nil unless bytes

    @string = bytes.collect(&:chr).join
  end

  def to_s
    string
  end

  def valid?
    Array(bytes).all? do |b|
      (0..255).include? b
    end
  end

end
