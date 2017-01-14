module Std
  module Operator

    class Operator
      attr_reader :func
      attr_reader :name
      def initialize(name, func)
        @func = func
        @name = name
      end

      def to_s
        @name.to_s
      end

      def inspect
        "#{self.class.name.split('::').last}(#{@name})"
      end


      def call(rename_me:)
        @func.call(rename_me: rename_me)
      end
    end

    private

    class OperatorWrapper
      attr_reader :func
      def initialize(&func)
        @func = func
      end

      def new(name)
        Operator.new(name, self)
      end

      def call(rename_me:)
        raw_args = rename_me.pop
        args = raw_args.call(rename_me: rename_me.clone)
        rename_me << @func.call(args, rename_me)
      end
    end
  end
end

module Std
  module Operator

    Add                = OperatorWrapper.new { |args| args.delete_at(-2) +  args.pop }
    Sub                = OperatorWrapper.new { |args| args.delete_at(-2) -  args.pop }
    Mul                = OperatorWrapper.new { |args| args.delete_at(-2) *  args.pop }
    Div                = OperatorWrapper.new { |args| args.delete_at(-2) /  args.pop }
    Mod                = OperatorWrapper.new { |args| args.delete_at(-2) %  args.pop }
    Pow                = OperatorWrapper.new { |args| args.delete_at(-2) ** args.pop }

    LShift             = OperatorWrapper.new { |args| args.delete_at(-2) << args.pop }
    RShift             = OperatorWrapper.new { |args| args.delete_at(-2) >> args.pop }
    And                = OperatorWrapper.new { |args| args.delete_at(-2) &  args.pop }
    Or                 = OperatorWrapper.new { |args| args.delete_at(-2) |  args.pop }
    Xor                = OperatorWrapper.new { |args| args.delete_at(-2) ^  args.pop }

    Equal              = OperatorWrapper.new { |args| args.delete_at(-2) == args.pop }
    NotEqual           = OperatorWrapper.new { |args| args.delete_at(-2) != args.pop }
    GreaterThan        = OperatorWrapper.new { |args| args.delete_at(-2) >  args.pop }
    LessThan           = OperatorWrapper.new { |args| args.delete_at(-2) <  args.pop }
    GreaterThanOrEqual = OperatorWrapper.new { |args| args.delete_at(-2) >= args.pop }
    LessThanOrEqual    = OperatorWrapper.new { |args| args.delete_at(-2) <= args.pop }

    Assign = OperatorWrapper.new{ |args, rename_me|
      rename_me[args.delete_at(-2)] = args.pop
    }
  end
end












