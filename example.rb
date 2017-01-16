require_relative 'core/parser'
require_relative 'plugins/number'
require_relative 'plugins/whitespace'
require_relative 'plugins/text'
require_relative 'plugins/keywords'
require_relative 'plugins/variable'
require_relative 'plugins/comment'
require_relative 'plugins/containers'

parser = Parser.new
parser.add Text
parser.add Variable
parser.add Number
parser.add Whitespace
parser.add Keywords
parser.add Comment
parser.add Containers


input = '
(1 + 2) * 3
"
'


res = parser.parse(input)
p res.stack



















