require_relative '../../core/keyword'
require_relative 'keywords_extend'

module Keywords::Comma
  extend Keywords
  VALUE = ','
  KEYWORD = Keyword::Comma
end