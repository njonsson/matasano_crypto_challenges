require 'matasano_crypto_challenges/representations/base64'
require 'matasano_crypto_challenges/representations/abstract'
require 'matasano_crypto_challenges/representations/abstract_sharedspec'

describe MatasanoCryptoChallenges::Representations::Base64 do
  it_behaves_like "a subclass of #{MatasanoCryptoChallenges::Representations::Abstract.name}"

  let(:base64_class) { described_class }

  describe 'that is valid' do
    subject(:base64) { base64_class.new value: '048bFjNrVz+/' }

    specify { expect(base64).to be_valid }
  end

  describe 'that contains whitespace' do
    subject(:base64) { base64_class.new value: '1 2' }

    specify { expect(base64).not_to be_valid }
  end

  describe 'that contains non-Base-64 characters' do
    subject(:base64) { base64_class.new value: '1!2' }

    specify { expect(base64).not_to be_valid }
  end

  describe '#bytes' do
    subject(:bytes) { base64.bytes }

    let(:expected_bytes) { [102, 111, 111] }

    describe 'from #value' do
      let(:base64) { base64_class.new value: 'Zm9v' }

      specify('returns the expected byte array') {
        expect(bytes).to eq(expected_bytes)
      }
    end
  end

  describe '#string' do
    subject(:string) { base64.string }

    let(:expected_string) { 'foo' }

    describe 'from #value' do
      let(:base64) { base64_class.new value: 'Zm9v' }

      specify('returns the expected string') {
        expect(string).to eq(expected_string)
      }
    end
  end

  describe '#to_s' do
    subject(:to_s) { base64.string }

    let(:expected_string) { 'foo' }

    describe 'from #value' do
      let(:base64) { base64_class.new value: 'Zm9v' }

      specify('returns the expected string') {
        expect(to_s).to eq(expected_string)
      }
    end
  end

  describe '#value' do
    subject(:value) { base64.value }

    let(:expected_value) { 'Zm9v' }

    describe 'from #bytes' do
      let(:base64) { described_class.new bytes: [102, 111, 111] }

      specify('returns the expected value') {
        expect(value).to eq(expected_value)
      }
    end

    describe 'from #string' do
      let(:base64) { base64_class.new string: 'foo' }

      specify('returns the expected value') {
        expect(value).to eq(expected_value)
      }
    end
  end
end
