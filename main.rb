require_relative 'tokens/keyword'
require_relative 'tokens/container'
body = [
  Identifier.new(:a)
  Container.new(body: []),
  Keyword::Call.new,
]