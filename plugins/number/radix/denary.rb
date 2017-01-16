require_relative 'radix_extend'

module Number
  module Radix
    module Denary
      extend Radix

      START_REGEX = /0d/i
      BODY_REGEX = /\d/
      BASE = 10

    end
  end
end