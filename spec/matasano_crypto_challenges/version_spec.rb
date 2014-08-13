require 'matasano_crypto_challenges/version'

describe 'MatasanoCryptoChallenges::VERSION' do
  specify {
    expect(MatasanoCryptoChallenges::VERSION).to match(/^\d+\.\d+\.\d+/)
  }
end
