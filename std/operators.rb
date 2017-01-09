require_relative 'functions'
module Std
  module Functions
    module Operators
      Add = Function.new { |args:, results:| results << (args >> 2) +  (args >> 1) }
      Sub = Function.new { |args:, results:| results << (args >> 2) -  (args >> 1) }
      Mul = Function.new { |args:, results:| results << (args >> 2) *  (args >> 1) }
      Div = Function.new { |args:, results:| results << (args >> 2) /  (args >> 1) }
      Mod = Function.new { |args:, results:| results << (args >> 2) %  (args >> 1) }
      Pow = Function.new { |args:, results:| results << (args >> 2) ** (args >> 1) }

      LShift = Function.new { |args:, results:| results << (args >> 2) << (args >> 1) }
      RShift = Function.new { |args:, results:| results << (args >> 2) >> (args >> 1) }
      And    = Function.new { |args:, results:| results << (args >> 2) &  (args >> 1) }
      Or     = Function.new { |args:, results:| results << (args >> 2) |  (args >> 1) }
      Xor    = Function.new { |args:, results:| results << (args >> 2) ^  (args >> 1) }

      Equal              = Function.new { |args:, results:| results << (args >> 2) == (args >> 1) }
      NotEqual           = Function.new { |args:, results:| results << (args >> 2) != (args >> 1) }
      GreaterThan        = Function.new { |args:, results:| results << (args >> 2) >  (args >> 1) }
      LessThan           = Function.new { |args:, results:| results << (args >> 2) <  (args >> 1) }
      GreaterThanOrEqual = Function.new { |args:, results:| results << (args >> 2) >= (args >> 1) }
      LessThanOrEqual    = Function.new { |args:, results:| results << (args >> 2) <= (args >> 1) }

      Assign = Function.new { |args:, results:| results << (results[args >> 2] = (args >> 1)) }
    end
  end
end


















