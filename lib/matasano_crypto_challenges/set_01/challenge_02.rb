module MatasanoCryptoChallenges

  module Set01; end

end

class MatasanoCryptoChallenges::Set01::Challenge02

  HEX1 = '1c0111001f010100061a024b53535009181c'
  HEX2 = '686974207468652062756c6c277320657965'

  def call
    result = []
    0.upto(HEX1.length - 1) do |i|
      hex1 = HEX1.slice(i, 1).to_i(16)
      hex2 = HEX2.slice(i, 1).to_i(16)
      result << (hex1 ^ hex2).to_s(16)
    end
    result.join
  end

end

