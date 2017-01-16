require_relative 'radix_extend'

module Numbers::Radix::Denary
  extend Numbers::Radix

  START_REGEX = /0d/i
  BODY_REGEX = /\d/
  BASE = 10

end