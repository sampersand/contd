

require 'ap'
# require_relative 'parser'
# body, args = Parser::parse_all(File.read('code.rb'))
require_relative 'objects/keyword'
require_relative 'objects/container'
require_relative 'builtins/operators'
require_relative 'builtins/functions'
body = Container.new(stack: [
  Identifier.new( '+' ),
  Keyword::Get.new( :'!' ),
  Container.new(stack: [1.0, 2.0]),
  Keyword::Call.new( :'@' ),
])
p body.stack
# ap body
args = Container.new(knowns: {
  Identifier.new( '+' )     => Operators::Add,
  :'='   => Operators::Assign,
  :'cmp' => Operators::Compare,
  :'index_stack' => Functions::IndexStack,
  :'index_knowns' => Functions::IndexKnowns,
  :'index' => Functions::Index,
  :'disp' => Functions::Display,
})
start_args = args.clone
body.call(args)
puts "\n----\n\n"
ap args.stack
ap args.knowns.reject{ |x| start_args.knowns.include?(x) }












