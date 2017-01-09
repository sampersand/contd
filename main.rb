# require_relative 'parsing/parser'
# parser = Parser.new

# body, args = parser.parse('''
# #! Inlcude Add Sub
# #! Number
# +! @ (3 4)
# ''')

# results = Container.new
# body.call(args: args, results: results)
# puts results


a = [1, 2, 3, 4]
i = a.each
i = 0
p loop until (i += 1) == 10
