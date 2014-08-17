require 'matasano_crypto_challenges/representations/hexadecimal'
require 'matasano_crypto_challenges/representations/abstract'
require 'matasano_crypto_challenges/representations/abstract_sharedspec'

describe MatasanoCryptoChallenges::Representations::Hexadecimal do
  it_behaves_like "a subclass of #{MatasanoCryptoChallenges::Representations::Abstract.name}"

  let(:hexadecimal_class) { described_class }

  describe '.from_bytes' do
    subject(:from_bytes) { hexadecimal_class.from_bytes bytes }

    let(:hexadecimal) { hexadecimal_class.new value: '010203' }

    let(:bytes) { [1, 2, 3] }

    specify("returns the expected #{described_class.name}") {
      expect(from_bytes).to eq(hexadecimal)
    }
  end

  describe 'that is valid' do
    subject(:hexadecimal) { hexadecimal_class.new value: '048bF0' }

    specify { expect(hexadecimal).to be_valid }
  end

  describe 'that contains whitespace' do
    subject(:hexadecimal) { hexadecimal_class.new value: '1 2' }

    specify { expect(hexadecimal).not_to be_valid }
  end

  describe 'that contains nonhexadecimal characters' do
    subject(:hexadecimal) { hexadecimal_class.new value: '1!2' }

    specify { expect(hexadecimal).not_to be_valid }
  end

  describe '#bytes' do
    subject(:bytes) { hexadecimal.bytes }

    let(:expected_bytes) { [102, 111, 111] }

    describe 'from #value' do
      let(:hexadecimal) { hexadecimal_class.new value: '666f6f' }

      specify('returns the expected byte array') {
        expect(bytes).to eq(expected_bytes)
      }
    end
  end

  describe '#string' do
    subject(:string) { hexadecimal.string }

    let(:expected_string) { 'foo' }

    describe 'from #value' do
      let(:hexadecimal) { hexadecimal_class.new value: '666f6f' }

      specify('returns the expected string') {
        expect(string).to eq(expected_string)
      }
    end
  end

  describe '#to_s' do
    subject(:to_s) { hexadecimal.string }

    let(:expected_string) { 'foo' }

    describe 'from #value' do
      let(:hexadecimal) { hexadecimal_class.new value: '666f6f' }

      specify('returns the expected string') {
        expect(to_s).to eq(expected_string)
      }
    end
  end

  describe '#value' do
    subject(:value) { hexadecimal.value }

    let(:expected_value) { '666f6f' }

    describe 'from #bytes' do
      let(:hexadecimal) { described_class.new bytes: [102, 111, 111] }

      specify('returns the expected value') {
        expect(value).to eq(expected_value)
      }
    end

    describe 'from #string' do
      let(:hexadecimal) { hexadecimal_class.new string: 'foo' }

      specify('returns the expected value') {
        expect(value).to eq(expected_value)
      }
    end
  end
end
