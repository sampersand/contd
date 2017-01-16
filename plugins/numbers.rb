require_relative 'numbers/whole'
require_relative 'numbers/radix'
require_relative 'numbers/real'

module Numbers

  module_function

  def handle_next(parser)
    Radix.handle_next(parser) || 
    Real.handle_next(parser) ||
    Whole.handle_next(parser)  
  end

end