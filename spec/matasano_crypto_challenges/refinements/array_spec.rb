require 'matasano_crypto_challenges/refinements/array'

using MatasanoCryptoChallenges::Refinements::Array

describe MatasanoCryptoChallenges::Refinements::Array do
  describe '#repeat_to' do
    describe 'with a negative number' do
      specify('returns nil') {
        expect(%w(foo bar).repeat_to(-1)).to be_nil
      }
    end

    describe 'with zero' do
      specify('returns an empty array') {
        expect(%w(foo bar).repeat_to(0)).to eq([])
      }
    end

    describe 'with a value less than the length of the array' do
      specify('returns the expected array') {
        expect(%w(foo bar).repeat_to(1)).to eq(%w(foo))
      }
    end

    describe 'with the length of the array' do
      specify('returns the expected array') {
        expect(%w(foo bar).repeat_to(2)).to eq(%w(foo bar))
      }
    end

    describe 'with a value greater than the length of the array' do
      specify('returns the expected array') {
        expect(%w(foo bar).repeat_to(3)).to eq(%w(foo bar foo))
      }
    end
  end
end
