require_relative 'shared_functions'

module Containers
  module Parens
    
    START = '('
    STOP  = ')'
    
    module_function

    def process_stream(**kwargs)
      ContainersSharedFunctions::process_stream(container: self, **kwargs)
    end

  end
end
