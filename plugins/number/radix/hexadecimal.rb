require_relative 'radix_extend'

module Number
  module Radix
    module Hexadecimal
      extend Radix

      START_REGEX = /0x/i
      BODY_REGEX = /[\da-f]/i
      BASE = 16

    end
  end
end
