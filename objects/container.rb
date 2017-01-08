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
  def call!(result)
    @stack.each do |token|
      case token
      when Keyword::Newline
        result.pop
      when Keyword::Get
        key = result.pop
        val = result.knowns[key]
        raise NameError, "Unknown token: #{key.inspect}" unless val
        result << val
      when Keyword::Call
        result.pop
        call(result) # UNKNOWN IF THIS WORKS
      else
        fail "TODO: Keyeword #{token}" if token.is_a?(Keyword)
        result << token
      end
    end
    result
  end

  def call(results)
    call!(clone_knowns)
  end
  def execute
    call(clone_knowns)
  end

  # ----- cloning ---- #
  def clone_knowns
    self.class.new(stack: nil, knowns: @knowns.clone)
  end

  # ----- Accessing ----- #
  def <<(ele) 
    @stack << ele
  end

  def pop(num=nil)
    return @stack.pop unless num
    @stack.delete_at(num)
  end

  def []=(key, value )
    @knowns[key] = value
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
body = Container.new(stack: [
  # stack(:foo, stack(stack(:x, GET, 2), :+, GET, CALL)), :set, GET, CALL,
  # stack(stack(:x, 4), :set, GET, CALL), :foo, GET, CALL,
  
  stack(), stack(stack(:x, 4), :set, GET, CALL), CALL
  # stack(stack(:x, GET, 2), :+, GET, CALL), CALL,

])

args = Container.new(knowns: {
  :+   => Operators::Add,
  :set => Operators::Assign,
  # :foo => stack(:x, GET, 2, :+, GET, CALL)
})
result = body.execute(args)
require 'ap'
ap result, index: false
p result.knowns




