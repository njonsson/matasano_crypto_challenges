require 'matasano_crypto_challenges/set_01/challenge_03'

describe MatasanoCryptoChallenges::Set01::Challenge03 do
  subject(:challenge_03) { challenge_03_class.new }

  let(:challenge_03_class) { described_class }

  describe '#crack_single_byte_xor_key' do
    let(:ciphertext_hexadecimal_string) {
      '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'
    }

    let(:expected_plaintext_hexadecimal_string) {
      expected_plaintext.bytes.collect { |b| b.to_s(16).rjust 2, '0' }.join
    }

    let(:expected_plaintext) { "Cooking MC's like a pound of bacon" }

    specify('returns the expected plaintext hexadecimal string') {
      actual = challenge_03.crack_single_byte_xor_key(ciphertext_hexadecimal_string)
      expect(actual).to eq(expected_plaintext_hexadecimal_string)
    }
  end
end
