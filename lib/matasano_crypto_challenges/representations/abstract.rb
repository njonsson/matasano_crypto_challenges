module MatasanoCryptoChallenges

  module Representations; end

end

class MatasanoCryptoChallenges::Representations::Abstract

  attr_accessor :normalcy_score

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
    @bytes          = attributes[:bytes]
    @normalcy_score = attributes[:normalcy_score] || 0
    @string         = attributes[:string]
    @value          = attributes[:value]
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

  def bytes
    return @bytes if @bytes

    return nil unless @string

    @bytes = @string.bytes
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
