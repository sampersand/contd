# Object = {
#   init = {
#     { cls = cls! }.update( args! )
#   }
# }

# Car =!@ {
#   init =!@ {
#     cls!.super_cls!.init(args =!@ {maker =!@ maker!})
#   }

#   super_cls =!@ Object
#   wheels =!@ 4
# }

# Car!.wheels # => 4
# c =!@ Car!.init(cls =!@ Car!, maker =!@ 'honda') # => {maker =!@ 'honda', **Car}
# c.maker  # => 'honda'
# c.wheels # => 4



require_relative 'core/options'
require_relative 'core/container'
body = Container.new(stack: [
  :car,
    :'=',
  :ten, :'!',
  # Container.new(stack: [:TEN, :eql, :'!', :ten, :'!',])
])


args = Container.new(knowns: {
    :'=' => proc{ |result:| result.push (result[result.delete_at(-2)] = result.pop); exit(1)},
    ten: 10,
})

result = body.call(result: args, options: Options)
p result



























