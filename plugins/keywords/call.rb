require_relative 'shared_functions'

module Keywords
  module Call

    VALUE = '@'
    KEYWORD = Keyword::Call

    module_function

    def process_stream(**kwargs)
      KeywordsSharedFunctions.process_stream(keyword: self, **kwargs)
    end

  end
end




















