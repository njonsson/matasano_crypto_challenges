require 'matasano_crypto_challenges/representations/hexadecimal'

module MatasanoCryptoChallenges

  class FrequencyAnalyzer

    attr_reader :normal

    def initialize(normal=Representations::Hexadecimal.from_string(' etaoinshrdlu'))
      @normal = normal
    end

    def normalcy_score(representation)
      normal.bytes.length -
        (frequent_bytes(representation) - normal.bytes).length
    end

  private

    def frequent_bytes(representation)
      table = {}
      representation.bytes.each do |b|
        table[b] = table[b].to_i + 1
      end
      table.to_a.
            sort_by(&:last).
            reverse.
            collect(&:first).
            slice 0, normal.bytes.length
    end

  end

end
