require_relative 'shared_functions'

module Keywords
  module Newline

    VALUE = ';'
    KEYWORD = Keyword::Newline

    module_function

    def process_stream(**kwargs)
      KeywordsSharedFunctions.process_stream(keyword: self, **kwargs)
    end

  end
end




















