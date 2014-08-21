require 'matasano_crypto_challenges/frequency_analyzer'
require 'matasano_crypto_challenges/util'

module MatasanoCryptoChallenges

  class SingleByteXorCracker

    def crack(representation)
      best = {normalcy_score: 0}
      1.upto 255 do |key_seed|
        plaintext_representation = Util.decrypt(content_representation: representation,
                                                key:                    key_seed)
        guess = {plaintext_representation: plaintext_representation,
                 key:                      key_seed,
                 normalcy_score:           frequency_analyzer.normalcy_score(plaintext_representation)}
        best = guess if best[:normalcy_score] < guess[:normalcy_score]
      end
      best
    end

  private

    def frequency_analyzer
      @frequency_analyzer ||= FrequencyAnalyzer.new
    end

  end

end
