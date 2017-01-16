require_relative '../../core/keyword'
require_relative 'keywords_extend'

module Keywords::Newline
  extend Keywords
  VALUE = ';'
  KEYWORD = Keyword::Newline
end