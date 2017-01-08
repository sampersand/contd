require_relative 'objects/keyword'
require_relative 'objects/container'
require_relative 'objects/identifier'

body = Container.new(stack: [
  Identifier.new( :x ),
  Keyword::Get.new,
  # Identifier.new( :+ ),
  # Container.new(stack: [
  #   Identifier.new( :x ),
  #   Keyword::Get.new,
  #   Identifier.new(  2 ),
  # ]),
  # Keyword::Call.new
])

args = Container.new(knowns: {
  Identifier.new( :+ ) => Identifier.new( 3)
})

result = body.execute(args: args)

require 'ap'
ap result, index: false

















