require 'matasano_crypto_challenges/set_01/challenge_02'

describe MatasanoCryptoChallenges::Set01::Challenge02 do
  subject(:challenge_02) { challenge_02_class.new }

  let(:challenge_02_class) { described_class }

  specify {
    expect(challenge_02.call).to eq('746865206b696420646f6e277420706c6179')
  }
end
