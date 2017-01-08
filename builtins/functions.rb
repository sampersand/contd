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

  IndexKnowns = Function.new(:index_stack){ |results|
    arg_results, index = get_indexes(results)
    results << arg_results.knowns[index]
  }
  IndexStack = Function.new(:index_stack){ |results|
    arg_results, index = get_indexes(results)
    results << arg_results.stack[index.to_i]
  }

  Display = Function.new(:disp){ |results|
    to_disp = results.pop
    puts to_disp.to_s
  }

  private

  def self.get_indexes(results)
    args = results.pop
    arg_results = results.clone_knowns

    args.call(arg_results)
    index = arg_results.pop
    container = arg_results.pop

    container.call(arg_results)
    [arg_results, index]
  end
end













