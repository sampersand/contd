

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
input = '
(foo {x!})=!@;
((x 3)=!@)foo!@
'

input = '1 + 22 * 3 ^ 4'

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

body, result = res.split
# p body.stack[0].stack[0]
# p body.stack[0].stack[1].stack[1]
# p body.stack[1]
# p body.stack[2]

puts body.debug_call(Container.new, result)

















