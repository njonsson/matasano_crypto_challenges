require 'matasano_crypto_challenges/hexadecimal_string'

describe MatasanoCryptoChallenges::HexadecimalString do
  let(:hexadecimal_string_class) { described_class }

  describe '.from_bytes' do
    subject(:from_bytes) { hexadecimal_string_class.from_bytes bytes }

    let(:hexadecimal_string) { hexadecimal_string_class.new '010203' }

    let(:bytes) { [1, 2, 3] }

    specify("returns the expected #{described_class.name}") {
      expect(from_bytes).to eq(hexadecimal_string)
    }
  end

  describe 'that is valid' do
    subject(:hexadecimal_string) { hexadecimal_string_class.new '048bF' }

    specify { expect(hexadecimal_string).to be_valid }

    specify { expect(hexadecimal_string.length).to eq(5) }
  end

  describe 'that is nil' do
    subject(:hexadecimal_string) { hexadecimal_string_class.new nil }

    specify { expect(hexadecimal_string).not_to be_valid }

    specify { expect(hexadecimal_string.length).to eq(0) }
  end

  describe 'that is empty' do
    subject(:hexadecimal_string) { hexadecimal_string_class.new '' }

    specify { expect(hexadecimal_string).not_to be_valid }

    specify { expect(hexadecimal_string.length).to eq(0) }
  end

  describe 'that contains whitespace' do
    subject(:hexadecimal_string) { hexadecimal_string_class.new '1 2' }

    specify { expect(hexadecimal_string).not_to be_valid }

    specify { expect(hexadecimal_string.length).to eq(3) }
  end

  describe 'that contains nonhexadecimal characters' do
    subject(:hexadecimal_string) { hexadecimal_string_class.new '1!2' }

    specify { expect(hexadecimal_string).not_to be_valid }

    specify { expect(hexadecimal_string.length).to eq(3) }
  end

  describe '#==' do
    def hexadecimal_string(value)
      hexadecimal_string_class.new value
    end

    specify "recognizes equivalent #{described_class.name}s" do
      expect(hexadecimal_string('foo')).to eq(hexadecimal_string('foo'))
    end

    specify "recognizes unequivalent #{described_class.name}s" do
      expect(hexadecimal_string('foo')).not_to eq(hexadecimal_string('bar'))
    end
  end

  describe '#^' do
    subject(:xor) {
      hexadecimal_string_class.new('010201') ^
        hexadecimal_string_class.new('020101')
    }

    let(:hexadecimal_string) { hexadecimal_string_class.new '030300' }

    specify("returns the expected #{described_class.name}") {
      expect(xor).to eq(hexadecimal_string)
    }
  end

  describe '#to_bytes' do
    subject(:to_bytes) { hexadecimal_string.to_bytes }

    let(:hexadecimal_string) { hexadecimal_string_class.from_bytes bytes }

    let(:bytes) { [1, 2, 3] }

    specify('returns the expected byte array') { expect(to_bytes).to eq(bytes) }
  end

  describe '#to_s' do
    subject(:to_s) { hexadecimal_string.to_s }

    let(:hexadecimal_string) { hexadecimal_string_class.from_bytes bytes }

    let(:bytes) { string.bytes }

    let(:string) { 'foo' }

    specify('returns the expected string') { expect(to_s).to eq(string) }
  end
end
