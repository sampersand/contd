require_relative 'radix_extend'

module Numbers::Radix::Hexadecimal
  extend Numbers::Radix

  START_REGEX = /0x/i
  BODY_REGEX = /[\da-f]/i
  BASE = 16

end