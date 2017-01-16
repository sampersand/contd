require_relative 'numbers/whole'
require_relative 'numbers/radix'

module Numbers

  module_function

  def handle_next(parser)
    Radix.handle_next(parser) || 
    Whole.handle_next(parser)  
  end

end