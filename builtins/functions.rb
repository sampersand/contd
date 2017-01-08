module Functions
  AllFunctions = {}

  class Function
    def initialize(name, &func)
      @name = name
      @func = func
      AllFunctions[@name] = self
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

  public
  Index = Function.new(:index){ |results|
    arg_results, index = get_indexes(results)
    knowns_has = arg_results.knowns.include?(index)
    index_has = (0...arg_results.stack.length).include?(index)
    if knowns_has
      raise IndexError, "Both knowns and stack have `#{index}` defined!" if index_has
      results << arg_results.knowns[index]
    elsif index_has
      results << arg_results.stack[index.to_i]
    else
      raise IndexError, "Neither knowns nor stack have `#{index}` defined!"
    end
  }
  AllFunctions[:'.'] = Index

  IndexKnowns = Function.new(:index_stack){ |results|
    arg_results, index = get_indexes(results)
    results << arg_results.knowns[index]
  }
  IndexStack = Function.new(:index_stack){ |results|
    arg_results, index = get_indexes(results)
    results << arg_results.stack[index.to_i]
  }

  Display = Function.new(:disp){ |results|
    new_knowns = results.clone_knowns
    results.pop.call(new_knowns)
    args = new_knowns.stack
    puts args.pop.to_s
  }

  Switch = Function.new(:switch){ |results|
    arg = results.pop
    arg_knowns = results.clone_knowns
    arg.call(arg_knowns)
    switch_on = arg_knowns.pop

    body = results.pop
    body_knowns = results.clone_knowns
    body.call(body_knowns)


    res = body_knowns.knowns[switch_on]
    raise "No case `#{args}` found" unless res
    results << res
  }



  private

  def self.get_indexes(results)
    args = Container.new(stack: [results.stack.delete_at(-2), results.pop])
    arg_results = results.clone_knowns

    args.call(arg_results)
    index = arg_results.pop
    container = arg_results.pop

    container.call(arg_results)
    [arg_results, index]
  end
end













