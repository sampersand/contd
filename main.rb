require_relative 'objects/keyword'
require_relative 'objects/container'
require_relative 'objects/identifier'

def id(val) Identifier.new( val ) end
body = [
  id(:+),
  [
    id(1),
    id(2),
  ],
  Keyword::Call.new
]
new_body = Container::from body


require 'ap'
ap new_body, index: false



  # Identifier.new(token: :a),
  # Container.new(stack: [
  #   Identifier.new(token: :b),
  #   Container.new(stack: [
  #     Identifier.new(token: :c),
  #     Identifier.new(token: :d),
  #   ]),
  #   Identifier.new(token: :e),
  # ]),
  # Keyword::Call.new,
