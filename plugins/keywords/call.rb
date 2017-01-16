require_relative '../../core/keyword'
require_relative 'keywords_extend'

module Keywords::Call
  extend Keywords
  VALUE = '@'
  KEYWORD = Keyword::Call
end