require_relative 'objects/keyword'
require_relative 'objects/container'
require_relative 'objects/identifier'
require_relative 'builtins/operators'

body = Container.new(stack: [
  # Container.new(stack: [
    Identifier.new( :x ),
    Keyword::Get.new,
    Identifier.new(  2 ),
  # ]),
  Identifier.new( :+ ),
  Keyword::Get.new,
  Keyword::Call.new
])

args = Container.new(knowns: {
  Identifier.new( :x ) => Identifier.new(3),
  Identifier.new( :+ ) => Operators::Add,
})
result = body.call(args)

require 'ap'
ap result, index: false










