class Container

  attr_reader :stack, :knowns

  def initialize(stack: nil, knowns: nil)
    @stack = stack || []
    @knowns = knowns || {}
  end

  # ---- Other methods ---- #
  def update(other)
    fail unless other.respond_to?(:stack)
    fail unless other.respond_to?(:knowns)
    @stack.concat(other.stack)
    @knowns.update(other.knowns)
  end

  def clone
    self.class.new(stack: @stack.clone, knowns: @knowns.clone )
  end

  # ---- String repr ---- #
  def to_s
    if @knowns.empty?
      stack_s
    elsif @stack.empty?
      knowns_s
    else
      "( #{stack_s}, #{knowns_s} )"
    end
  end

  def stack_s
    "[#{@stack.join(', ')}]"
  end
  def knowns_s
    "{#{@knowns.collect{ |k, v| "#{k}: #{v}" }.join(', ')}}"
  end

  def inspect #maybe change this later?
    "#{self.class}( #{@stack}, #{@knowns} )"
  end

  # ---- Array methods ---- #
  def each(&block)
    @stack.each(&block)
  end

  def empty?
    @stack.empty?
  end

  def <<(value)
    @stack << value
  end

  def pop
    self >> 1
  end

  def >>(pos)
    @stack.delete_at(-pos)
  end

  # ---- Hash methods ---- #
  def [](key)
    @knowns[key]
  end

  def []=(key, value)
    @knowns[key] = value
  end

  # ---- Function methods ---- #
  def call(args, results)
    raise 'How to deal with args with positionals?' unless args.empty?
    results.update(args)
    call!(results)
  end

  def call!(results)
    itr = each
    loop do 
      case (token = itr.next)
      when Keyword::Newline
        results.pop #and throw it away
      when Keyword::Get
        fail if results.empty?
        key   = results.pop
        value = results[key]
        raise NameError, "Undefined token `#{key}`" unless value
        results << value
      when Keyword::Call
        func = results.pop
        args = itr.next
        call_results = Container.new
        args.call(results, call_results)
        func.call(call_results, results)
      else
        results << token
      end
    end
  end

end





