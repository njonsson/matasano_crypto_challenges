require 'matasano_crypto_challenges/frequency_analyzer'
require 'matasano_crypto_challenges/refinements/array'
require 'matasano_crypto_challenges/single_byte_xor_cracker'
require 'matasano_crypto_challenges/util'

using MatasanoCryptoChallenges::Refinements::Array

module MatasanoCryptoChallenges

  class MultibyteXORCracker

    attr_reader :key_sizes

    def initialize(key_sizes=2..40)
      @key_sizes = key_sizes
    end

    def crack(representation)
      best = {normalcy_score: 0}
      likely_key_sizes(representation).each do |key_size|
        block_representations = demux(representation: representation,
                                      block_size:     key_size)
        key = crack_key_from_blocks(block_representations)
        plaintext_representation = Util.xor_with_repeating_key(content_representation: representation,
                                                               key:                    key)
        guess = {plaintext_representation: plaintext_representation,
                 key:                      key,
                 normalcy_score:           frequency_analyzer.normalcy_score(plaintext_representation)}
        best = guess if best[:normalcy_score] < guess[:normalcy_score]
      end
      best[:key_representation] = representation.class.from_bytes(best.delete(:key))
      best
    end

  private

    MAXIMUM_NUMBER_OF_BLOCKS_TO_ANALYZE = 4

    MAXIMUM_NUMBER_OF_LIKELY_KEY_SIZES = 5

    def crack_key_from_blocks(block_representations)
      cracker = SingleByteXORCracker.new
      block_representations.collect do |block_representation|
        cracked = cracker.crack(block_representation)
        cracked[:key]
      end
    end

    def demux(representation: nil, block_size: nil)
      blocks = []
      block_size.times do
        blocks << []
      end
      representation.bytes.each_slice block_size do |muxed_block|
        muxed_block.each_with_index do |byte, index|
          block = blocks[index]
          block << byte
        end
      end
      blocks.collect do |block|
        representation.class.from_bytes block
      end
    end

    def frequency_analyzer
      @frequency_analyzer ||= FrequencyAnalyzer.new
    end

    def likely_key_sizes(representation)
      normalized_average_hamming_distances_by_key_size(representation).to_a.
                                                                       sort_by(&:last).
                                                                       slice(0,
                                                                             MAXIMUM_NUMBER_OF_LIKELY_KEY_SIZES).
                                                                       collect(&:first)
    end

    def normalized_average_hamming_distances_by_key_size(representation)
      key_sizes.inject({}) do |result, key_size|
        muxed_blocks = []
        number_of_blocks_to_analyze = number_of_blocks_to_analyze(representation: representation,
                                                                  key_size:       key_size)
        representation.bytes.slice(0...(key_size * number_of_blocks_to_analyze)).each_slice key_size do |muxed_block|
          muxed_blocks << representation.class.from_bytes(muxed_block)
        end
        sum_of_hamming_distances = muxed_blocks.inject 0 do |sum, muxed_block|
          sum + muxed_block.hamming_distance(muxed_blocks.first)
        end
        average_hamming_distance = sum_of_hamming_distances.to_f /
                                   number_of_blocks_to_analyze.to_f
        normalized_average_hamming_distance = average_hamming_distance /
                                              key_size.to_f
        result.merge key_size => normalized_average_hamming_distance
      end
    end

    def number_of_blocks_to_analyze(representation: nil, key_size: nil)
      if representation.bytes.length < key_size
        raise ArgumentError, 'representation not long enough to analyze'
      end

      2.upto MAXIMUM_NUMBER_OF_BLOCKS_TO_ANALYZE do |i|
        return(i - 1) if representation.bytes.length < (key_size * i)
      end

      MAXIMUM_NUMBER_OF_BLOCKS_TO_ANALYZE
    end

  end

end
