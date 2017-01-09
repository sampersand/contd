module Builtins
  require_relative 'identifier'
  class Function
    attr_reader :name
    def initialize(name, &func)
      @name = Identifier.new( name )
      @func = func
    end

    def to_s
      "#{@name}"
    end

    def inspect
      "#{self.class}( #{@name} )"
    end

    def call(args:, result:)
      @func.call(args: args, result: result)
    end
  end


  Add = Function.new(:+){ |args:, result:|
    result << (args >> 2) + args.pop
  }
  Div = Function.new(:/){ |args:, result:|
    result << (args >> 2) / args.pop
  }  
  Assign = Function.new(:'='){ |args:, result:|
    result << (result[args >> 2] = args.pop)
  }
end




















