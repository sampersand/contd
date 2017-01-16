require_relative 'inline_extend'

module Comments
  module Inline::CStyle
    extend Inline
    START = '//'
  end
end
