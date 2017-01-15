require_relative 'shared_functions'

module Comment
  module SingleLine
    
    START = '#'
    STOP = "\n"

    module_function

    def process_stream(**kwargs)
      CommentSharedFunctions::process_stream(comment: self, **kwargs)
    end

  end
end
