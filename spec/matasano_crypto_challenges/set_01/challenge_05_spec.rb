require 'matasano_crypto_challenges/set_01/challenge_05'

describe MatasanoCryptoChallenges::Set01::Challenge05 do
  subject(:challenge_05) { challenge_05_class.new }

  let(:challenge_05_class) { described_class }

  describe '#xor_with_repeating_key' do
    let(:plaintext) {
      <<-end_string.gsub(/^\s+/, '').chomp
        Burning 'em, if you ain't quick and nimble
        I go crazy when I hear a cymbal
      end_string
    }

    let(:plaintext_hexadecimal_string) {
      plaintext.bytes.collect { |b| b.to_s(16).rjust 2, '0' }.join
    }

    let(:key) { 'ICE' }

    let(:key_hexadecimal_string) {
      key.bytes.collect { |b| b.to_s(16).rjust 2, '0' }.join
    }

    specify('returns the expected ciphertext hexadecimal string') {
      actual = challenge_05.xor_with_repeating_key(plaintext_hexadecimal_string: plaintext_hexadecimal_string,
                                                   key_hexadecimal_string:       key_hexadecimal_string)
      expect(actual).to eq('0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d' +
                           '63343c2a26226324272765272a282b2f20430a652e2c652a31' +
                           '24333a653e2b2027630c692b20283165286326302e27282f')
    }
  end
end
