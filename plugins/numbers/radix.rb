require_relative 'radix/binary'
require_relative 'radix/octal'
require_relative 'radix/denary'
require_relative 'radix/hexadecimal'
module Numbers
  module Radix

    module_function

    def handle_next(**kwargs)
      Binary.handle_next(**kwargs) ||
      Hexadecimal.handle_next(**kwargs) ||
      Octal.handle_next(**kwargs) ||
      Denary.handle_next(**kwargs)
    end

  end
end
