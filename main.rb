# require_relative 'core/container'
# require_relative 'std'

# def stack(*a) Container.new(stack: a) end
# def known(**a) Container.new(known: a) end
# body = stack(
#   #
#   stack(
#     :foo,
#     stack(4, :ten, Keyword::Get.new),
#     :+, Keyword::Get.new, Keyword::Call.new
#   ), :assign, Keyword::Get.new, Keyword::Call.new
# )


# rename_me = known(
#   #
#   :ten => 10,
#   :+ => Std::Operator::Add.new(:+),
#   :assign => Std::Operator::Assign.new(:'='),
# )

# p body.call(rename_me: rename_me)





require_relative 'core/parser'

input = '


x = 3;
y = \'4.5\'
#foo
/* bar
baz */
z = (6.7 + 9) * 3.2
w = ten0_1 !
v = 
ab'
input = '
x = 0x0110
y = 0d39a
z = 20
w = 2.3
'


require_relative 'plugins/number'
require_relative 'plugins/whitespace'
require_relative 'plugins/text'
require_relative 'plugins/keywords'
require_relative 'plugins/variable'
require_relative 'plugins/comment'
# require_relative 'plugins/operator'
require_relative 'plugins/containers'

parser = Parser.new
parser.add Text
parser.add Variable
parser.add Number
parser.add Whitespace
# parser.add Keywords
parser.add Comment
# parser.add Operator
# parser.add Containers

res = parser.parse(input)
p res.stack


















