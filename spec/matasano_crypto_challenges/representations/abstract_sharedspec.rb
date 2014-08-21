require 'matasano_crypto_challenges/representations/abstract'

shared_examples_for "a subclass of #{MatasanoCryptoChallenges::Representations::Abstract.name}" do
  describe '.from_bytes' do
    subject(:from_bytes) { described_class.from_bytes bytes }

    let(:bytes) { [1, 2, 3] }

    specify("returns the expected #{described_class.name}") {
      expect(from_bytes).to eq(described_class.new(bytes: bytes))
    }
  end

  describe '.from_string' do
    subject(:from_string) { described_class.from_string string }

    let(:string) { 'foo bar' }

    specify("returns the expected #{described_class.name}") {
      expect(from_string).to eq(described_class.new(string: string))
    }
  end

  describe '.from_value' do
    subject(:from_value) { described_class.from_value value }

    let(:value) { '123abc' }

    specify("returns the expected #{described_class.name}") {
      expect(from_value).to eq(described_class.new(value: value))
    }
  end

  describe 'that is nil' do
    subject(:nil_object) { described_class.new value: nil }

    specify { expect(nil_object).not_to be_valid }
  end

  describe 'that is empty' do
    subject(:empty) { described_class.new value: '' }

    specify { expect(empty).not_to be_valid }
  end

  describe '#==' do
    def object(attributes)
      described_class.new attributes
    end

    specify "recognizes equivalent #{described_class.name} objects" do
      expect(object(bytes: [1, 2],
                    string: 'foo',
                    value: 'F00')).to eq(object(bytes: [1, 2],
                                                string: 'foo',
                                                value: 'F00'))
    end

    specify "recognizes different #{described_class.name} objects" do
      expect(object(bytes: [1, 2],
                    string: 'foo',
                    value: 'F00')).not_to eq(object(bytes: [3, 4],
                                                    string: 'foo',
                                                    value: 'F00'))
      expect(object(bytes: [1, 2],
                    string: 'foo',
                    value: 'F00')).not_to eq(object(bytes: [1, 2],
                                                    string: 'bar',
                                                    value: 'F00'))
      expect(object(bytes: [1, 2],
                    string: 'foo',
                    value: 'F00')).not_to eq(object(bytes: [1, 2],
                                                    string: 'foo',
                                                    value: 'BA3'))
    end
  end

  describe '#^' do
    subject(:xor) {
      described_class.new(bytes: [1, 2, 1]) ^
        described_class.new(bytes: [2, 1, 1])
    }

    let(:expected) { described_class.new bytes: [3, 3, 0] }

    specify("returns the expected #{described_class.name}") {
      expect(xor).to eq(expected)
    }
  end

  describe '#bits' do
    subject(:bits) { expected.bits }

    let(:expected_bits) { [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0] }

    let(:expected) { described_class.new bytes: expected_bytes }

    let(:expected_bytes) { [1, 2] }

    specify('returns the expected bit array') {
      expect(bits).to eq(expected_bits)
    }
  end

  describe '#bytes' do
    subject(:bytes) { expected.bytes }

    let(:expected_bytes) { [1, 2, 3] }

    describe 'from #bytes' do
      let(:expected) { described_class.new bytes: expected_bytes }

      specify('returns the expected byte array') {
        expect(bytes).to eq(expected_bytes)
      }
    end

    describe 'from #string' do
      let(:expected) { described_class.new string: "\x01\x02\x03" }

      specify('returns the expected byte array') {
        expect(bytes).to eq(expected_bytes)
      }
    end
  end

  describe '#hamming_distance' do
    subject(:hamming_distance) {
      described_class.from_string('this is a test').hamming_distance described_class.from_string('wokka wokka!!!')
    }

    let(:expected) { 37 }

    specify('returns the expected result') {
      expect(hamming_distance).to eq(expected)
    }
  end

  describe '#pad_pkcs7' do
    describe 'with block_size' do
      let(:representation) { described_class.new string: string }

      let(:string) { 'foo' }

      describe 'less than zero' do
        specify('raises the expected error') {
          expect {
            representation.pad_pkcs7 -1
          }.to raise_error(ArgumentError, 'block_size must be in 1..255')
        }
      end

      describe 'of zero' do
        specify('raises the expected error') {
          expect {
            representation.pad_pkcs7 0
          }.to raise_error(ArgumentError, 'block_size must be in 1..255')
        }
      end

      describe 'that is positive' do
        subject(:pad_pkcs7) { representation.pad_pkcs7 block_size }

        describe 'but lesser than content size' do
          let(:string) { 'foo' }

          let(:block_size) { 2 }

          let(:expected_representation) { described_class.from_string "foo\x01" }

          specify("returns the expected #{described_class.name}") {
            expect(pad_pkcs7).to eq(expected_representation)
          }
        end

        describe 'and equal to content size' do
          let(:string) { 'foo' }

          let(:block_size) { 3 }

          let(:expected_representation) { described_class.from_string 'foo' }

          specify("returns the expected #{described_class.name}") {
            expect(pad_pkcs7).to eq(expected_representation)
          }
        end

        describe 'and greater than content size' do
          let(:string) { 'foo' }

          let(:block_size) { 5 }

          let(:expected_representation) {
            described_class.from_string "foo\x02\x02"
          }

          specify("returns the expected #{described_class.name}") {
            expect(pad_pkcs7).to eq(expected_representation)
          }
        end
      end
    end
  end

  describe '#string' do
    subject(:string) { expected.string }

    let(:expected_string) { 'foo' }

    describe 'from #bytes' do
      let(:expected) { described_class.new bytes: expected_string.bytes }

      specify('returns the expected string') {
        expect(string).to eq(expected_string)
      }
    end

    describe 'from #string' do
      let(:expected) { described_class.new string: expected_string }

      specify('returns the expected string') {
        expect(string).to eq(expected_string)
      }
    end
  end

  describe '#to_s' do
    subject(:to_s) { expected.to_s }

    let(:expected_string) { 'foo' }

    describe 'from #bytes' do
      let(:expected) { described_class.new bytes: expected_string.bytes }

      specify('returns the expected string') {
        expect(to_s).to eq(expected_string)
      }
    end

    describe 'from #string' do
      let(:expected) { described_class.new string: expected_string }

      specify('returns the expected string') {
        expect(to_s).to eq(expected_string)
      }
    end
  end

  describe '#value' do
    subject(:value) { expected.value }

    let(:expected_value) { 'F00' }

    describe 'from #value' do
      let(:expected) { described_class.new value: expected_value }

      specify('returns the expected value') {
        expect(value).to eq(expected_value)
      }
    end
  end
end
