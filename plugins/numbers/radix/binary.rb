require_relative 'radix_extend'

module Numbers
  module Radix::Binary
    extend Radix

    START_REGEX = /0b/i
    BODY_REGEX = /[01]/
    BASE = 2

  end
end