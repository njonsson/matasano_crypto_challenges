require 'matasano_crypto_challenges/hexadecimal_string'

describe MatasanoCryptoChallenges::HexadecimalString do
  let(:hexadecimal_string_class) { described_class }

  describe '.from_bytes' do
    specify("returns the expected #{described_class.name}") {
      expect(hexadecimal_string_class.from_bytes([1, 2, 3])).to eq(hexadecimal_string_class.new('010203'))
    }
  end

  describe 'that is valid' do
    subject(:hexadecimal_string) { hexadecimal_string_class.new '048bF' }

    specify { expect(hexadecimal_string).to be_valid }
  end

  describe 'that is nil' do
    subject(:hexadecimal_string) { hexadecimal_string_class.new nil }

    specify { expect(hexadecimal_string).not_to be_valid }
  end

  describe 'that is empty' do
    subject(:hexadecimal_string) { hexadecimal_string_class.new '' }

    specify { expect(hexadecimal_string).not_to be_valid }
  end

  describe 'that contains whitespace' do
    subject(:hexadecimal_string) { hexadecimal_string_class.new '1 2' }

    specify { expect(hexadecimal_string).not_to be_valid }
  end

  describe 'that contains nonhexadecimal characters' do
    subject(:hexadecimal_string) { hexadecimal_string_class.new '1!2' }

    specify { expect(hexadecimal_string).not_to be_valid }
  end

  describe '#==' do
    specify "recognizes equivalent #{described_class.name}s" do
      expect(hexadecimal_string_class.new('foo')).to eq(hexadecimal_string_class.new('foo'))
    end

    specify "recognizes unequivalent #{described_class.name}s" do
      expect(hexadecimal_string_class.new('foo')).not_to eq(hexadecimal_string_class.new('bar'))
    end
  end

  describe '#^' do
    subject(:hexadecimal_string1) { hexadecimal_string_class.new '010201' }

    subject(:hexadecimal_string2) { hexadecimal_string_class.new '020101' }

    specify("returns the expected #{described_class.name}") {
      expect(hexadecimal_string1 ^ hexadecimal_string2).to eq(hexadecimal_string_class.new('030300'))
    }
  end

  describe '#to_bytes' do
    specify 'returns the expected byte array' do
      expect(hexadecimal_string_class.new('1234').to_bytes).to eq([18, 52])
    end
  end
end
