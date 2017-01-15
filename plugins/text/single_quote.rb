require_relative 'shared_functions'

module Text
  module SingleQuote
    
    module_function

    QUOTE = '\''
    ESCAPE = '\\'

    def process_stream(**kwargs)
      TextSharedFunctions::process_stream(plugin: self, **kwargs)
    end

  end
end
