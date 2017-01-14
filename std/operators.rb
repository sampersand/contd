require_relative 'functions'
module Std
  module Functions
    module Operators
      Operator = Class.new(Function)

      Add = Operator.new { |args:, results:| results << (args >> 2) +  (args >> 1) }
      Sub = Operator.new { |args:, results:| results << (args >> 2) -  (args >> 1) }
      Mul = Operator.new { |args:, results:| results << (args >> 2) *  (args >> 1) }
      Div = Operator.new { |args:, results:| results << (args >> 2) /  (args >> 1) }
      Mod = Operator.new { |args:, results:| results << (args >> 2) %  (args >> 1) }
      Pow = Operator.new { |args:, results:| results << (args >> 2) ** (args >> 1) }

      LShift = Operator.new { |args:, results:| results << (args >> 2) << (args >> 1) }
      RShift = Operator.new { |args:, results:| results << (args >> 2) >> (args >> 1) }
      And    = Operator.new { |args:, results:| results << (args >> 2) &  (args >> 1) }
      Or     = Operator.new { |args:, results:| results << (args >> 2) |  (args >> 1) }
      Xor    = Operator.new { |args:, results:| results << (args >> 2) ^  (args >> 1) }

      Equal              = Operator.new { |args:, results:| results << (args >> 2) == (args >> 1) }
      NotEqual           = Operator.new { |args:, results:| results << (args >> 2) != (args >> 1) }
      GreaterThan        = Operator.new { |args:, results:| results << (args >> 2) >  (args >> 1) }
      LessThan           = Operator.new { |args:, results:| results << (args >> 2) <  (args >> 1) }
      GreaterThanOrEqual = Operator.new { |args:, results:| results << (args >> 2) >= (args >> 1) }
      LessThanOrEqual    = Operator.new { |args:, results:| results << (args >> 2) <= (args >> 1) }

      Assign = Operator.new { |results:| results << (results[results >> 2] = (results >> 1)) }
      Index = Operator.new { |args:, results:| 
        results << (args >> 2)[args >> 1] }
    end
  end
end


# body = Container.new(stack: [
#   Container.new(stack:[
#     :a, :ten, Keyword::Get.new
#   ]),
#   :eql, Keyword::Get.new, Keyword::Call.new
# ])
# rename_me = Container.new(known: {
#   ten: 10,
#   eql: Class.new(Proc){
#           def to_s
#             "< eql >"
#           end
#           alias :inspect :to_s
#         }.new do |rename_me:|
#           raw_args = rename_me.pop
#           args = raw_args.call(rename_me: rename_me.clone)
#           rename_me[args.shift] = args.shift
#         end
# })

# p body.call(rename_me: rename_me)

































