class Operator
  attr_reader :names, :priority

  def initialize(*names, priority:, &func)
    @names = names
    @priority = priority
    @func = func
  end

  def to_s
    @names.to_s
  end

  def inspect
    "#{self.class}( `#{@names[0].inspect}`, `#{@priority.inspect} )"
  end

  def call(args, current, override_args: true)
    args = args.call(Container.new, current.clone) if override_args
    if @func
      current << @func.call(args, current)
    else
      current << args.stack.reduce(&@names[0].to_sym) #0th name is the keyword
    end
  end

end












