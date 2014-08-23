require 'matasano_crypto_challenges/set_01/challenge_02'

describe MatasanoCryptoChallenges::Set01::Challenge02 do
  subject(:challenge_02) { challenge_02_class.new }

  let(:challenge_02_class) { described_class }

  describe '#xor' do
    let(:ciphertext_hexadecimal_string) {
      '1c0111001f010100061a024b53535009181c'
    }

    let(:key_hexadecimal_string) {
      key.bytes.collect { |b| b.to_s(16).rjust 2, '0' }.join
    }

    let(:key) { "hit the bull's eye" }

    let(:expected_plaintext_hexadecimal_string) {
      expected_plaintext.bytes.collect { |b| b.to_s(16).rjust 2, '0' }.join
    }

    let(:expected_plaintext) { "the kid don't play" }

    specify('returns the expected plaintext hexadecimal string') {
      actual = challenge_02.xor(ciphertext_hexadecimal_string,
                                key_hexadecimal_string)
      expect(actual).to eq(expected_plaintext_hexadecimal_string)
    }
  end
end
