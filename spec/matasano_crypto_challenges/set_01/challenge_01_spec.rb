require 'matasano_crypto_challenges/set_01/challenge_01'

describe MatasanoCryptoChallenges::Set01::Challenge01 do
  subject(:challenge_01) { challenge_01_class.new }

  let(:challenge_01_class) { described_class }

  describe '#base64_encode' do
    let(:hexadecimal_string) {
      '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'
    }

    specify('returns the expected Base-64 string') {
      expect(challenge_01.base64_encode(hexadecimal_string)).to eq('SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t')
    }
  end
end
