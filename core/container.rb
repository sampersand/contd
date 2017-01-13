class Container
  require_relative 'keyword'
  require_relative 'stack_iter'

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

  def clone
    self.class.new(stack: @stack.clone, knowns: @knowns.clone)
  end

  # --- Array Methods --- #
  def pop
    @stack.pop
  end

  def delete_at(pos)
    @stack.delete_at(pos)
  end

  def push(value)
    @stack.push(value)
  end

  def to_a
    @stack.collect{ |e| e.respond_to?(:to_a) ? e.to_a : e }
  end


  # --- Hash Methods --- #
  def [](item)
    begin
      raise ArgumentError, "Knons & stack have valid `#{item}`" if @knowns[item] && @stack[item]
    rescue TypeError => e
      # ignore
    end

    @knowns[item]# || @stack[item]
  end

  def []=(item, value)
    @knowns[item] = value
  end

  # --- Proc Methods --- #
  def call(result:)
    body = StackIter.new @stack
    i = 0
    loop do
      i += 1; fail if i > 100
      token = body.next(priority: 0)
        raise(token.to_s) unless token.stack.length <= 1
        token = token.stack[0]
        break unless token
      case token
      when Keyword
        token.process(body: body, result: result)
      else
        result.stack << token
      end
    end
    result
  end

  # --- Repr Methods --- #
  def to_s
    "<#{@stack.reject{ |_, v| v.is_a?(Proc)}} | #{@knowns.reject{ |_, v| v.is_a?(Proc)}}>"
  end
  alias :inspect :to_s

end


get = Keyword::Get.new; call = Keyword::Call.new; newl = Keyword::Newline.new
body = Container.new(stack: [
  # :foo, call, :a,           # foo @ (5)
  # :car, :eql, get, call, :a # car =@ a
  :car,
    :eql, get, call,
  Container.new(stack: [
        :TEN,
          :eql, get, call,
        :ten, get
  ]), call,
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
    eql: proc{ |result:| result.push (result[result.delete_at(-2)] = result.pop).to_s },
    ten: 10,
})

result = body.call(result: args)
p result













