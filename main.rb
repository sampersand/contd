require_relative 'objects/keyword'
require_relative 'objects/container'
require_relative 'objects/identifier'

def id(val) Identifier.new( val ) end
body = Container.new(stack: [
  Identifier.new( :+ ),
  Container.new(stack: [
    Identifier.new( :x ),
    Identifier.new(  2 ),
  ]),
  Keyword::Call.new
])
args = Container.new(knowns: {
  Identifier.new( :+ ) => Identifier.new( 3)
})
body.execute(args)

require 'ap'
ap body, index: false
























