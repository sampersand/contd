require_relative 'keywords_extend'

module Keywords
  module Call
    extend Keywords

    VALUE = '@'
    KEYWORD = Keyword::Call

  end
end