module Builtins
  class Function
    attr_reader :name
    def initialize(name, &func)
      @name = name
      @func = func
    end

    def to_s
      "#{@name}"
    end

    def inspect
      "#{self.class}( #{@name} )"
    end

    def call(args, results)
      @func.call(args, results)
    end
  end


  Add = Function.new(:+){ |args, results|
    results << (args >> 2) + args.pop
  }
  Div = Function.new(:/){ |args, results|
    results << (args >> 2) / args.pop
  }  
  Assign = Function.new(:'='){ |args, results|
    results << (results[args >> 2] = args.pop)
  }
end




















