require 'matasano_crypto_challenges/refinements/string_refinements'

using MatasanoCryptoChallenges::Refinements::StringRefinements

describe MatasanoCryptoChallenges::Refinements::StringRefinements do
  describe '#extend_to' do
    describe 'with a negative number' do
      specify('returns nil') {
        expect('foo'.extend_to(-1)).to be_nil
      }
    end

    describe 'with zero' do
      specify('returns an empty string') {
        expect('foo'.extend_to(0)).to eq('')
      }
    end

    describe 'with the length of the string' do
      specify('returns the expected string') {
        expect('foo'.extend_to(3)).to eq('foo')
      }
    end

    describe 'with a value greater than the length of the string' do
      specify('returns the expected string') {
        expect('foo'.extend_to(4)).to eq('foof')
      }
    end
  end
end
