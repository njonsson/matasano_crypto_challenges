require 'matasano_crypto_challenges/base64_string'

describe MatasanoCryptoChallenges::Base64String do
  let(:base64_string_class) { described_class }

  describe '.from_bytes' do
    specify("returns the expected #{described_class.name}") {
      expect(base64_string_class.from_bytes([1, 2, 3])).to eq(base64_string_class.new('AQID'))
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

  describe 'that contains nonbase64 characters' do
    subject(:base64_string) { base64_string_class.new '1!2' }

    specify { expect(base64_string).not_to be_valid }
  end

  describe '#==' do
    specify "recognizes equivalent #{described_class.name}s" do
      expect(base64_string_class.new('foo')).to eq(base64_string_class.new('foo'))
    end

    specify "recognizes unequivalent #{described_class.name}s" do
      expect(base64_string_class.new('foo')).not_to eq(base64_string_class.new('bar'))
    end
  end
end
