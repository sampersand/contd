require_relative 'shared_functions'

module Comment
  module MultiLine
    
    START = '/*'
    STOP  = '*/'

    module_function

    def process_stream(**kwargs)
      CommentSharedFunctions::process_stream(plugin: self, **kwargs)
    end

  end
end
