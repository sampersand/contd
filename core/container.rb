require_relative 'keyword'
class Container

  attr_reader :stack, :knowns
  def initialize(stack: nil, knowns: nil)
    @stack  = stack || []
    @knowns = knowns || {}
  end

  # --- Array & Hash Methods --- #
  def update(other)
    @stack.concat other.stack
    @knowns.update other.knowns
  end

  # --- Array Methods --- #
  def pop
    @stack.pop
  end

  def push(value)
    @stack.push(value)
  end

  # --- Hash Methods --- #
  def [](item)
    begin
      raise ArgumentError, "Knons & stack have valid `#{item}`" if @knowns[item] && @stack[item]
    rescue TypeError => e
      # ignore
    end

    @knowns[item] || @stack[item]
  end

  def []=(item, value)
    @knowns[item] = value
  end

  # --- Proc Methods --- #
  def call(result:)
    body = @stack.each
    loop do
      if (token = body.next).is_a? Keyword
        token.process(body: body, result: result)
      else
        result.stack << token
      end
    end
    result
  end

  # --- Repr Methods --- #
  def to_s
    "<#{@stack} | #{@knowns}>"
  end


end


get = Keyword::Get.new; call = Keyword::Call.new; newl = Keyword::Newline.new
body = Container.new(stack: [
  # :foo, call, :a,           # foo @ (5)
  # :car, :eql, get, call, :a # car =@ a
  # car foo @ 5!  :car, :foo, call, :ten, get,
  # :Car,
  #   :eql, get, call,
  # Container.new(stack: [
  #   :wheels, 
  #     :eql, get, call,
  #   4,
  #   newl,
  #   :result,
  #     :eql, get, call,
  #   Container.new(stack: [
  #     4,
  #       :+, get, call,
  #     5,
  #   ]), call, Container.new,
  #     :*, get, call,
  #   3
  # ])
])


require_relative '../std/operators'
args = Container.new(knowns: {
    eql: Std::Functions::Operators::Assign,
    ten: 10,
})

result = body.call(result: args)
puts result.stack













