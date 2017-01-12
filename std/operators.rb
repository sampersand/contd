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

      Assign = Operator.new { |args:, results:| results << (results[args >> 2] = (args >> 1)) }
      Index = Operator.new { |args:, results:| 
        results << (args >> 2)[args >> 1] }
    end
  end
end
















