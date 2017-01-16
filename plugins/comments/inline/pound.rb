require_relative 'inline_extend'

module Comments
  module Inline::Pound
    extend Inline
    START = '#'
  end
end
