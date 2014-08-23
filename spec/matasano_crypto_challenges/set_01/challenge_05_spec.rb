require 'matasano_crypto_challenges/set_01/challenge_05'

describe MatasanoCryptoChallenges::Set01::Challenge05 do
  subject(:challenge_05) { challenge_05_class.new }

  let(:challenge_05_class) { described_class }

  describe '#xor_with_repeating_key' do
    let(:plaintext_hexadecimal_string) {
      plaintext.bytes.collect { |b| b.to_s(16).rjust 2, '0' }.join
    }

    let(:plaintext) {
      <<-end_plaintext.gsub(/^\s+/, '').chomp
        Burning 'em, if you ain't quick and nimble
        I go crazy when I hear a cymbal
      end_plaintext
    }

    let(:key_hexadecimal_string) {
      key.bytes.collect { |b| b.to_s(16).rjust 2, '0' }.join
    }

    let(:key) { 'ICE' }

    let(:expected_ciphertext_hexadecimal_string) {
      <<-end_expected_ciphertext_hexadecimal_string.gsub(/\s+/, '')
        0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a262263242727652
        72a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e2728
        2f
      end_expected_ciphertext_hexadecimal_string
    }

    specify('returns the expected ciphertext hexadecimal string') {
      actual = challenge_05.xor_with_repeating_key(plaintext_hexadecimal_string: plaintext_hexadecimal_string,
                                                   key_hexadecimal_string:       key_hexadecimal_string)
      expect(actual).not_to be_nil
      expect(actual).to eq(expected_ciphertext_hexadecimal_string)
    }
  end
end
