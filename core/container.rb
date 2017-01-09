require_relative 'keyword'
class Container

  # ---- Attributes ---- #
  attr_reader :stack, :knowns

  # ---- Initializer ---- #
  def initialize(stack: nil, knowns: nil)
    @stack = stack || []
    @knowns = knowns || {}
  end

  # ---- Other methods ---- #
  def merge!(other)
    fail unless other.respond_to?(:stack)
    fail unless other.respond_to?(:knowns)
    #does the stack even matter??
    # @stack = other.stack.concat(@stack)#.concat(other.stack)
    # p @stack
    # @stack.concat(other.stack)
    @knowns.update(other.knowns)
    self
  end

  def clone
    self.class.new(stack: @stack.clone,
                   knowns: @knowns.clone )
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

  def inspect
    "#{self.class}( #{@stack}, #{@knowns} )"
  end

  # ---- Array methods ---- #

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

  def call(args:, results:)
    results.merge!(args) #should this be cloned first?
    iter = @stack.each
    loop {
      case (token = iter.next)
      when Keyword::Newline then handle_newline(results: results, iter: iter, token: token)
      when Keyword::Get     then handle_get(    results: results, iter: iter, token: token)
      when Keyword::Call    then handle_call(   results: results, iter: iter, token: token)
      else                       handle_else(   results: results, iter: iter, token: token)
      end
    }
  end

  private

  def handle_newline(results:, iter:, token:)
    results.pop
  end

  def handle_call(results:, iter:, token:)
    func = results.pop
    args = iter.next
    call_results = self.class.new
    args.call(args: results, results: call_results)
    func.call(args: call_results, results: results)
  end

  def handle_get(results:, iter:, token:)
    fail if results.empty?
    key   = results.pop
    value = results[key]
    raise NameError, "Undefined token `#{key}`" unless value
    results << value
  end

  def handle_else(results:, iter:, token:)
    results << token
  end
end



