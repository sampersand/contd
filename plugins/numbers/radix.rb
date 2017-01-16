require_relative 'radix/binary'
require_relative 'radix/octal'
require_relative 'radix/denary'
require_relative 'radix/hexadecimal'
module Numbers
  module Radix

    module_function

    def process_stream(**kwargs)
      Binary.process_stream(**kwargs) ||
      Hexadecimal.process_stream(**kwargs) ||
      Octal.process_stream(**kwargs) ||
      Denary.process_stream(**kwargs)
    end

  end
end
