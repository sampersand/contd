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
    # @stack = @stack.clone.concat(other.stack)
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
      when Keyword::This    then handle_this( results: results, iter: iter, token: token)
      else                       handle_else(   results: results, iter: iter, token: token)
      end
    }
  end

  private

  def handle_newline(results:, iter:, token:)
    results.pop
  end

  def handle_this(results:, iter:, token:)
    results << results.clone
  end

  def handle_call(results:, iter:, token:)
    func = results.pop
    args = iter.next
    arg_results = self.class.new
    args.call(args: results, results: arg_results)
    func_results = results
    func.call(args: arg_results, results: results)
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



# Object = {
#   init = {
#     { cls = cls! }.update( args! )
#   }
# }

# Car = {
#   init = {
#     cls!.super_cls!.init(args = {maker = maker!})
#   }

#   super_cls = Object
#   wheels = 4
# }

# Car!.wheels # => 4
# c = Car!.init(cls = Car!, maker = 'honda') # => {maker = 'honda', **Car}
# c.maker  # => 'honda'
# c.wheels # => 4


body = Container.new(stack: [
  :eql,
  Keyword::Get.new,
  Keyword::Call.new,
  Container.new

])

require_relative '../std/operators'
args = Container.new(knowns: {
    eql:  Std::Functions::Operators::Assign,
})

results = Container.new
body.call(args: args, results: results)
puts results













