class Container
  require_relative 'keyword'

  attr_reader :stack, :knowns, :options
  def initialize(stack: nil, knowns: nil, options:)
    @stack  = stack || []
    @knowns = knowns || {}
    @options = options
  end

  # --- Array & Hash Methods --- #
  def update(other)
    @stack.concat other.stack
    @knowns.update other.knowns
    # do nothing with other's options
  end

  def clone
    self.class.new(stack: @stack.clone,
                   knowns: @knowns.clone,
                   options: @options.clone)
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
    body = @stack.each
    loop do
      token = @options.next_token(priority: 0)[0] or break
      @options.process_token(token: token, body: body, result: result)
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
    :eql, get,
  Container.new(stack: [
        :TEN,
          :eql, get,
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
require_relative 'options'
args = Container.new(knowns: {
    eql: proc{ |result:| result.push (result[result.delete_at(-2)] = result.pop).to_s },
    ten: 10,
}, options: Options.new)

result = body.call(result: args)
p result













