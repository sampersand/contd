require_relative 'objects/keyword'
require_relative 'objects/container'
require_relative 'objects/identifier'
require_relative 'builtins/operators'

GET = Keyword::Get.new
CALL = Keyword::Call.new
NEWL = Keyword::Newline.new
def stack(*args) Container.new(stack: args) end
body = Container.new(stack: [
  # stack(:foo, stack(stack(:x, GET, 2), :+, GET, CALL)), :set, GET, CALL,
  # stack(stack(:x, 4), :set, GET, CALL), :foo, GET, CALL,
  
  stack(stack(:x, 4), :set, GET, CALL),
  stack(stack(:x, GET, 2), :+, GET, CALL), CALL,

])

args = Container.new(knowns: {
  :+   => Operators::Add,
  :set => Operators::Assign,
  # :foo => stack(:x, GET, 2, :+, GET, CALL)
})
result = body.call(args)
require 'ap'
ap result, index: false
p result.knowns








