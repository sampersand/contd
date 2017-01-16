require_relative 'radix_extend'

module Numbers
  module Radix::Hexadecimal
    extend Radix

    START_REGEX = /0x/i
    BODY_REGEX = /[\da-f]/i
    BASE = 16

  end
end
