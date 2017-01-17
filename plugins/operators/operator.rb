class Operator
  attr_reader :name

  def initialize(name, &func)
    @name = name
    @func = func
  end

  def to_s
    @name.to_s
  end

  def inspect
    "#{self.class}( `#{@name.inspect}` )"
  end

  def call(args, current)
    args = args.call(Container.new, current.clone)
    if @func
      current << @func.call(args, current)
    else
      current << args.stack.reduce(&@name.to_sym)
    end
  end

end