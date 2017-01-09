# require_relative 'parser'
# parser = Parser.new

# body, args = parser.parse('''
# #! Inlcude Add
# #! Number
# +! @ (3 4)
# ''')

# results = Container.new
# body.call(args: args, results: results)
# puts results
require_relative 'core/'