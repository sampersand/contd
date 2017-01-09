require_relative 'parser'
parser = Parser.new

res = parser.parse('''
#!INCLUDE +
3 + 4
# #!INCLUDE -
''')

puts res



#   require_relative 'keyword'
#   require_relative 'builtins'
#   def stack(*a) Container.new(stack: a) end
#   def get; Keyword::Get.new end
#   def call; Keyword::Call.new end
#   def newl; Keyword::Newline.new end
#   body = stack( # foo! @ (1, 2)
#     :eql, get, call,
#     stack(:foo, stack( :+, get, call, stack(:x, get, 5 ))),
#     newl,

#     :foo, get, call,
#     stack(
#       :eql, get, call,
#       stack(:x, 2),
#       newl,
#     ),
#   )
#   args = Container.new( knowns: {
#     eql: Builtins::Assign,
#     '+': Builtins::Add,
#   } )
#   results = Container.new
#   body.call(args, results)
#   puts results






















