module MatasanoCryptoChallenges

  module Refinements; end

end

module MatasanoCryptoChallenges::Refinements::StringRefinements

  refine String do
    def extend_to(length)
      return slice(0, length) if length <= self.length

      (self * ((length / self.length) + 1)).slice 0, length
    end
  end

end
