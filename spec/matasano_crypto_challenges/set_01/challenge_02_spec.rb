require 'matasano_crypto_challenges/set_01/challenge_02'

describe MatasanoCryptoChallenges::Set01::Challenge02 do
  subject(:challenge_02) { challenge_02_class.new }

  let(:challenge_02_class) { described_class }

  describe '#xor' do
    let(:hexadecimal_string1) { '1c0111001f010100061a024b53535009181c' }

    let(:hexadecimal_string2) { '686974207468652062756c6c277320657965' }

    specify('returns the expected hexadecimal string') {
      actual = challenge_02.xor(hexadecimal_string1, hexadecimal_string2)
      expect(actual).to eq('746865206b696420646f6e277420706c6179')
    }
  end
end
