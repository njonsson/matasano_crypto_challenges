module MatasanoCryptoChallenges

  module Refinements; end

end

module MatasanoCryptoChallenges::Refinements::Array

  refine ::Array do
    def repeat_to(length)
      return self.dup if length == self.length

      return(self * length) if self.length == 1

      return slice(0, length) if length < self.length

      repeated = self.dup
      (length / self.length).times do
        repeated.concat self
      end
      repeated.slice 0, length
    end
  end

end
