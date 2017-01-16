require_relative 'radix/binary'
require_relative 'radix/octal'
require_relative 'radix/denary'
require_relative 'radix/hexadecimal'
module Numbers
  module Radix

    module_function

    def handle_next(parser)
      Binary.handle_next(parser) ||
      Hexadecimal.handle_next(parser) ||
      Octal.handle_next(parser) ||
      Denary.handle_next(parser)
    end

  end
end
