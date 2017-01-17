class Function
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

  def call(args, current, override_args: true)
    args = args.call(Container.new, current.clone) if override_args
    @func.call(args, current)
  end

end