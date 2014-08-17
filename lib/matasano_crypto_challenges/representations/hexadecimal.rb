require 'matasano_crypto_challenges/representations/abstract'

module MatasanoCryptoChallenges; end

module MatasanoCryptoChallenges::Representations

  class Hexadecimal < Abstract

    def bytes
      super.tap do |b|
        return b if b
      end

      return nil unless @value

      bytes = []
      @value.chars.each_slice 2 do |nibbles|
        bytes << nibbles.join.to_i(16)
      end
      @bytes = bytes
    end

    def valid?
      return false unless super

      ! (value.to_s =~ /^[0-9a-f]+$/i).nil?
    end

    def value
      return @value if @value

      return nil unless bytes

      @value = bytes.collect { |b| b.to_s(16).rjust 2, '0' }.join
    end

  end

end
