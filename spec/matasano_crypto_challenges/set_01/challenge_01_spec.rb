require 'matasano_crypto_challenges/set_01/challenge_01'

describe MatasanoCryptoChallenges::Set01::Challenge01 do
  subject(:challenge_01) { challenge_01_class.new }

  let(:challenge_01_class) { described_class }

  describe '#base64_encode' do
    let(:hexadecimal_string) {
      string.bytes.collect { |b| b.to_s(16).rjust 2, '0' }.join
    }

    let(:string) { "I'm killing your brain like a poisonous mushroom" }

    let(:expected_base64_string) {
      'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t'
    }

    specify('returns the expected Base-64 string') {
      actual = challenge_01.base64_encode(hexadecimal_string)
      expect(actual).to eq(expected_base64_string)
    }
  end
end
