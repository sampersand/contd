module Containers
  module Brackets
    
    START = '['
    STOP  = ']'
    module_function

    def process_stream(**kwargs)
      SharedFunctions::process_stream(container: self, **kwargs)
    end

  end
end
