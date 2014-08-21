require 'matasano_crypto_challenges/refinements/array'

using MatasanoCryptoChallenges::Refinements::Array

module MatasanoCryptoChallenges

  module Util

    def self.decrypt(content_representation: nil, key: nil)
      expanded_key_representation = content_representation.class.from_bytes(Array(key).repeat_to(content_representation.bytes.length))
      content_representation ^ expanded_key_representation
    end

  end

end
