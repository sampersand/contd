require_relative 'keywords_extend'

module Keywords
  module Newline
    extend Keywords

    VALUE = ';'
    KEYWORD = Keyword::Newline

  end
end