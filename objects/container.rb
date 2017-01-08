class Container

  # ----- Attributes ----- #
  attr_reader :stack
  attr_reader :knowns

  # ----- Initializer ----- #
  def initialize(stack: nil, knowns: nil)
    @stack  = stack || []
    @knowns = knowns || {}
    fail unless @stack.respond_to?(:each)
    fail unless @stack.respond_to?(:pop)
    fail unless @stack.respond_to?(:push)
    fail unless @knowns.respond_to?(:[])
    fail unless @knowns.respond_to?(:[]=)
  end



  # ----- Execution ----- #
  def execute(results)
    @stack.each do |token|
      case token
      when Keyword::Newline
        results.pop
      when Keyword::Get
        key = results.pop
        val = results.knowns[key]
        raise NameError, "Unknown token: #{key.inspect}" unless val
        results << val
      when Keyword::Call
        fail if results.stack.empty? 
        # results.pop.call(results)
        results.pop(-2).call(results)
      else
        fail "TODO: Keyeword #{token}" if token.is_a?(Keyword)
        results << token
      end
    end
  end

  def call(results)
    if results.stack.empty?
      execute(results)
      return
    end
    new_results = results.clone_knowns
    args = results.pop
    args.call(new_results)
    execute(new_results)
    results << new_results.pop

  end

  # ----- cloning ---- #
  def clone_knowns
    self.class.new(stack: nil, knowns: @knowns.clone)
  end

  def clone
    self.class.new(stack: @stack.clone, knowns: @knowns.clone)
  end

  # ----- Accessing ----- #
  def <<(ele) 
    @stack << ele
  end

  def pop(num=nil)
    return @stack.pop unless num
    @stack.delete_at(num)
  end

  def shift
    @stack.shift
  end
  def unshift(ele)
    @stack.unshift(ele)
  end


  def []=(key, value)
    @knowns[key] = value
  end

  def keys
    @knowns.keys
  end

  def last
    @stack.last
  end

  def first
    @stack.first
  end

  def last=(val)
    @stack[-1] = val
  end

  def first=(val)
    @stack[0] = val
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
    # @knowns.collect{ |k, v| [k, v.awesome_inspect(options)] }.awesome_inspect(options)
  end

end








