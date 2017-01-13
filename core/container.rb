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

  def clone
    self.class.new(stack: @stack.clone,
                   knowns: @knowns.clone)
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
  def last
    @stack.last
  end


  # --- Hash Methods --- #
  def [](item)
    @knowns[item]# || @stack[item]
  end

  def []=(item, value)
    @knowns[item] = value
  end

  # --- Proc Methods --- #
  def call(result:, options:)
    body = @stack.each
    loop do
      token = next_group(body: body,
                         priority: options.lowest_priority,
                         options: options)

      fail token.to_s unless token.stack.length <= 1
      token = token.stack[0] || break

      case token
      when options.infix_token?
        result.push Container.new(stack: [
          result.pop,
          next_group(body: body,
                     priority: options.priority_of(token),
                     options: options).
                        call(result: result.clone,
                             options: options).pop,
        ])
        result.push token
        result.push :'!'
        p result.to_a
        redo
        # p res.call(result: result.clone, options: options)
        # p result
        # res = token.call
        # exit
      when options.get_token?
        last = result.last
        result.push(result[result.pop] || fail("Unknown local #{last}"))
        p result
      else
        result.push token
      end
    end
    result
  end

  # --- Repr Methods --- #
  def to_s
    "<#{@stack.reject{ |_, v| v.is_a?(Proc)}} | #{@knowns.reject{ |_, v| v.is_a?(Proc)}}>"
  end
  alias :inspect :to_s


  
  private

  def next_group(body:, priority:, options:)
    res = self.class.new
    loop do 
      case options.priority_of(res.push( body.next ).last) <=> priority
      when 0, 1 then
        break
      when -1 # then nothing
      else fail "#{res.last} cannot be compared to #{priority}"
      end
    end
    res
  end

end





