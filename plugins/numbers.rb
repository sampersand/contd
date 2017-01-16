require_relative 'numbers/whole'
require_relative 'numbers/radix'
require_relative 'numbers/real'

module Numbers

  module_function

  def process_stream(**kwargs)
    Radix.process_stream(**kwargs) || 
    Real.process_stream(**kwargs) ||
    Whole.process_stream(**kwargs)  
  end

end