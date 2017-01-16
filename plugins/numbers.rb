require_relative 'numbers/whole'
require_relative 'numbers/radix'
require_relative 'numbers/real'

module Numbers

  module_function

  def handle_next(**kwargs)
    Radix.handle_next(**kwargs) || 
    Real.handle_next(**kwargs) ||
    Whole.handle_next(**kwargs)  
  end

end