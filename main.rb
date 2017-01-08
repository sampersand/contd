

require 'ap'
require_relative 'parser'
# body, args = Parser::parse_all(File.read('code.rb'))
require_relative 'objects/keyword'
body = Container.new(stack: [
  :+,
  Keyword::Get.new( :get ),
  Keyword::Call.new( :call ),
  Container.new(stack: [1, 2])
])
# ap body
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
puts "\n----\n\n"
ap args.stack
ap args.knowns.reject{ |x| start_args.knowns.include?(x) }












