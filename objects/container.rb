class Container

  # ----- Attributes ----- #
  attr_reader :stack
  attr_reader :knowns

  # ----- Initializer ----- #
  def initialize(stack: [], knowns: {})
    @stack  = stack
    @knowns = knowns
  end


  # ----- Cloning ----- #
  def deep_clone
    new_stack = @stack.collect{ |e| }

    self.class.new(stack: new_stack, knowns: new_knowns)
  end

  # ----- Execution ----- #
  def execute(args)
    clone.execute!
  end


  # ----- Setters ----- #
  def <<(obj)
    @stack << obj
  end

  def []=(key, obj)
    @knowns[key] = obj
  end

  # ----- Representation ----- #
  def to_s
    return "()" if @stack.empty? && @knowns.empty?
    return knowns_str if @stack.empty?
    return stack_str if @knowns.empty?
    "(#{stack_str}, #{knowns_str})"
  end

  def inspect
    "#{self.class}#{to_s}"
  end

  def stack_str
    "[#{@stack.join(', ')}]"
  end

  def knowns_str
    "{#{@knowns.collect{|k, v| "#{k}: #{v}"}.join(', ')}}"
  end

  def ai(options)
    awesome_inspect(options).ai(options)
  end

  def awesome_inspect(options)
    @stack.collect{ |ele| ele.awesome_inspect(options) }
  end

end



