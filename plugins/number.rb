require_relative 'number/whole'
require_relative 'number/radix'
require_relative 'number/real'

module Number

  module_function

  def process_stream(**kwargs)
    Radix.process_stream(**kwargs) || 
    Real.process_stream(**kwargs) ||
    Whole.process_stream(**kwargs)  
  end

end