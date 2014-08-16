require 'matasano_crypto_challenges/base64_string'

describe MatasanoCryptoChallenges::Base64String do
  let(:base64_string_class) { described_class }

  describe '.from_bytes' do
    subject(:from_bytes) { base64_string_class.from_bytes bytes }

    let(:base64_string) { base64_string_class.new 'AQID' }

    let(:bytes) { [1, 2, 3] }

    specify("returns the expected #{described_class.name}") {
      expect(from_bytes).to eq(base64_string)
    }
  end

  describe 'that is valid' do
    subject(:base64_string) { base64_string_class.new '048bFjNrVz+/' }

    specify { expect(base64_string).to be_valid }
  end

  describe 'that is nil' do
    subject(:base64_string) { base64_string_class.new nil }

    specify { expect(base64_string).not_to be_valid }
  end

  describe 'that is empty' do
    subject(:base64_string) { base64_string_class.new '' }

    specify { expect(base64_string).not_to be_valid }
  end

  describe 'that contains whitespace' do
    subject(:base64_string) { base64_string_class.new '1 2' }

    specify { expect(base64_string).not_to be_valid }
  end

  describe 'that contains non-Base-64 characters' do
    subject(:base64_string) { base64_string_class.new '1!2' }

    specify { expect(base64_string).not_to be_valid }
  end

  describe '#==' do
    def base64_string(value)
      base64_string_class.new value
    end

    specify "recognizes equivalent #{described_class.name} objects" do
      expect(base64_string('foo')).to eq(base64_string('foo'))
    end

    specify "recognizes different #{described_class.name} objects" do
      expect(base64_string('foo')).not_to eq(base64_string('bar'))
    end
  end

  describe '#to_bytes' do
    subject(:to_bytes) { base64_string.to_bytes }

    let(:base64_string) { base64_string_class.from_bytes bytes }

    let(:bytes) { [102, 111, 111] }

    specify('returns the expected byte array') { expect(to_bytes).to eq(bytes) }
  end

  describe '#to_s' do
    subject(:to_s) { base64_string.to_s }

    let(:base64_string) { base64_string_class.from_bytes bytes }

    let(:bytes) { string.bytes }

    let(:string) { 'foo' }

    specify('returns the expected string') { expect(to_s).to eq(string) }
  end
end
