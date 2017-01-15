require_relative 'shared_functions'

module Keywords
  module Get

    VALUE = '!'
    KEYWORD = Keyword::Get

    module_function

    def process_stream(**kwargs)
      KeywordsSharedFunctions.process_stream(keyword: self, **kwargs)
    end

  end
end




















