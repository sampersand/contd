class Operator
  attr_reader :name, :priority

  def initialize(name, priority, &func)
    @name = name
    @priority = priority
    @func = func
  end

  def to_s
    @name.to_s
  end

  def inspect
    "#{self.class}( `#{@name.inspect}`, `#{@priority.inspect} )"
  end

  def call(args, current, override_args: true)
    if override_args
      new_current = current.clone
      args.call(Container.new, new_current)
      args = new_current.pop
    end

    if @func
      @func.call(args, current)
    else
      current << args.stack.reduce(&@name.to_sym)
    end
  end

end