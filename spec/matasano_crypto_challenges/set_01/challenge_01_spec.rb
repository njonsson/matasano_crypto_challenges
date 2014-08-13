require 'matasano_crypto_challenges/set_01/challenge_01'

describe MatasanoCryptoChallenges::Set01::Challenge01 do
  subject(:challenge_01) { challenge_01_class.new }

  let(:challenge_01_class) { described_class }

  specify {
    expect(challenge_01.call).to eq('SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t')
  }
end
