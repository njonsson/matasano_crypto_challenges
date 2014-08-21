require 'matasano_crypto_challenges/set_02/challenge_01'

describe MatasanoCryptoChallenges::Set02::Challenge01 do
  subject(:challenge_01) { challenge_01_class.new }

  let(:challenge_01_class) { described_class }

  describe '#pcks7_pad' do
    let(:string) { 'YELLOW SUBMARINE' }

    let(:expected_padded_string) { "YELLOW SUBMARINE\x04\x04\x04\x04" }

    specify('returns the expected padded string') {
      actual = challenge_01.pkcs7_pad(content: string, block_size: 20)
      expect(actual).not_to be_nil
      expect(actual).to eq(expected_padded_string)
    }
  end
end
