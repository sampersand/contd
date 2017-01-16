require_relative '../../core/keyword'
require_relative 'keywords_extend'

module Keywords::Get
  extend Keywords
  VALUE = '!'
  KEYWORD = Keyword::Get
end