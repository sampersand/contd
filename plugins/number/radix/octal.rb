require_relative 'radix_extend'

module Number
  module Radix
    module Octal
      extend Radix

      START_REGEX = /0o/i
      BODY_REGEX = /[0-7]/
      BASE = 8

    end
  end
end