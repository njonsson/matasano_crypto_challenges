require 'matasano_crypto_challenges/set_01/challenge_03'

describe MatasanoCryptoChallenges::Set01::Challenge03 do
  subject(:challenge_03) { challenge_03_class.new }

  let(:challenge_03_class) { described_class }

  describe '#cryptanalyze' do
    let(:ciphertext_hexadecimal_string) {
      '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'
    }

    let(:plaintext) { "Cooking MC's like a pound of bacon" }

    let(:plaintext_hexadecimal_string) {
      plaintext.bytes.collect { |b| b.to_s(16).rjust 2, '0' }.join
    }

    specify('returns the expected plaintext hexadecimal string') {
      actual = challenge_03.cryptanalyze(ciphertext_hexadecimal_string)
      expect(actual).to eq(plaintext_hexadecimal_string)
    }
  end
end
