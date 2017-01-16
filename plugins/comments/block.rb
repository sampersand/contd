require_relative 'comments_extend'

module Comments::Block
  extend Comments
  START = '/*'
  STOP  = '*/'
end
