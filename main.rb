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

input = '''
x = 3;
y = 4.5!
'''
input = '123.456'

require_relative 'plugins/number'
parser = Parser.new
parser.add Number
res = parser.parse(input)
p res



















