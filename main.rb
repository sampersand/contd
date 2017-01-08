require_relative 'objects/keyword'
require_relative 'objects/identifier'
require_relative 'objects/container'
require_relative 'builtins/operators'
require_relative 'builtins/functions'

GET = Keyword::Get.new
CALL = Keyword::Call.new
NEWL = Keyword::Newline.new
def stack(*args) Container.new(stack: args) end
def func(id) [id, GET, CALL] end
def set(a, b) [stack(*[a, b].flatten), :'=', GET, CALL] end

body = stack(
  # *set(:x, stack(1, 2, 3, *set(9, 3) )),
  # *stack(:x, GET, Identifier.new(0)), *func(:index_stack),
  # *set(:x, stack( *set(9, 3) )),
  *set(:x, stack( :y, GET, 3, *set(2, 0), 3, ) ),
  *stack(*set(:y, 4), :x, GET, 0), *func(:index), *func(:disp)
)

args = Container.new(knowns: {
  :+     => Operators::Add,
  :'='   => Operators::Assign,
  :'cmp' => Operators::Compare,
  :'index_stack' => Functions::IndexStack,
  :'index_knowns' => Functions::IndexKnowns,
  :'index' => Functions::Index,
  :'disp' => Functions::Display,
})
start_args = args.clone
body.call(args)
require 'ap'
ap args.stack
ap args.knowns.reject{ |x| start_args.knowns.include?(x) }












