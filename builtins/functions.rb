module Functions
  class Function
    def initialize(name, &func)
      @name = name
      @func = func
    end

    def to_s
      @name.to_s
    end

    def call(results)
      @func.call(results)
    end
    def awesome_inspect(options)
      self
    end
    def inspect
      "#{self.class}( #{@name} )"
    end
  end

  IndexStack = Function.new(:index_stack){ |results|
    args = results.pop
    arg_results = results.clone_knowns

    args.call(arg_results)
    index = arg_results.pop
    container = arg_results.pop

    container.call(arg_results)
    results << arg_results.stack[index]
  }
  IndexKnowns = Function.new(:index_stack){ |results|
    args = results.pop
    arg_results = results.clone_knowns

    args.call(arg_results)
    index = arg_results.pop
    container = arg_results.pop

    container.call(arg_results)
    results << arg_results.knowns[index]
  }
end















