require_relative 'keywords_extend'

module Keywords
  module Get
    extend Keywords

    VALUE = '!'
    KEYWORD = Keyword::Get

  end
end