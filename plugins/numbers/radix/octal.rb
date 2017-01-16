require_relative 'radix_extend'

module Numbers::Radix::Octal
  extend Numbers::Radix

  START_REGEX = /0o/i
  BODY_REGEX = /[0-7]/
  BASE = 8

end