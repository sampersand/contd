require_relative 'objects/keyword'
require_relative 'objects/container'
require_relative 'objects/identifier'
body = Container.new(body: [
  Identifier.new(token: :a),
  Container.new(body: [
    Identifier.new(token: :b),
    Container.new(body: [
      Identifier.new(token: :c),
      Identifier.new(token: :d),
    ]),
    Identifier.new(token: :e),
  ]),
  Keyword::Call.new,
])


require 'ap'
ap body, index: false