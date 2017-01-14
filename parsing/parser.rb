module Parser
  require_relative '../core/container'

  module_function


  def parse(input, options)
    result = Container.new
  end

end



require_relative 'option'
input = 'x = 3'


option = Option.new
res = Parser::parse(input, option)
p res
# class Object
#   def imp
#     case self
#     when :** then 3
#     when :* then 2
#     when :+ then 1
#     else 4
#     end
#   end
# end

# a = [0, :+, 1, :*, 2, :+, 3]
# a = [0, :*, 1, :+, 2, :+, 3]

# def next_priority(arr, sym)
#   res = []
#   until arr.empty?
#     if (sym.imp) < arr.first.imp
#       res << arr.shift
#     else
#       break
#     end
#   end
#   res
# end

# p next_priority(a.clone, :+).join(' ')
# p next_priority(a.clone, :*).join(' ')
# p next_priority(a.clone, :**).join(' ')
# p next_priority(a.clone, :/).join(' ')



