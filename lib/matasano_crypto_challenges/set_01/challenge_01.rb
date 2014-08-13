require 'base64'

module MatasanoCryptoChallenges

  module Set01; end

end

class MatasanoCryptoChallenges::Set01::Challenge01

  HEX = '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'

  def call
    base64
  end

private

  def base64
    Base64.strict_encode64 binary_string
  end

  def binary_string
    bin = []
    each_byte do |byte|
      bin << byte
    end
    bin.join
  end

  def each_byte
    HEX.chars.each_slice 2 do |nibbles|
      yield nibbles.join.to_i(16).chr
    end
  end

end
