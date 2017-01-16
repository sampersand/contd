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

require_relative 'plugins/numbers'
require_relative 'plugins/whitespace'
require_relative 'plugins/text'
require_relative 'plugins/keywords'
require_relative 'plugins/variable'
require_relative 'plugins/comments'
require_relative 'plugins/operators'
require_relative 'plugins/containers'

input = '3 + 42 * 5'
input = '(3 (4)-!@)+!@'
input = '(9 (4 5)-!@)+!@'
parser = Parser.new(input)
parser.add Text
parser.add Variable
parser.add Numbers
parser.add Whitespace
parser.add Keywords
parser.add Comments
parser.add Operators
parser.add Containers

res = parser.run

body, args = res.split

puts body.call(args)

















