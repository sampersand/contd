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
        results.pop.call(results)
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
    args = results.pop
    args.call(results)
    execute(results)
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

  def []=(key, value)
    @knowns[key] = value
  end

  def keys
    @knowns.keys
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










require_relative 'keyword'
require_relative 'identifier'
require_relative '../builtins/operators'

GET = Keyword::Get.new
CALL = Keyword::Call.new
NEWL = Keyword::Newline.new
def stack(*args) Container.new(stack: args) end
def func(id) [id, GET, CALL] end
body = stack(
    stack(:foo, stack( stack(:x, GET, 4), *func(:+) )), *func(:'='),
    stack(stack(:x, 9), *func(:'=')), *func(:foo),
)

args = Container.new(stack: [], knowns: {
  :+   => Operators::Add,
  :'=' => Operators::Assign,
  # :foo => stack(:x, GET, 2, :+, GET, CALL)
})
body.call(args)
require 'ap'
ap args.stack
ap args.knowns







