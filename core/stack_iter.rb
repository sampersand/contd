class StackIter
  def initialize(stack)
    @stack = stack
  end

  def peek(priority:)
    clone.next(priority: priority)
  end

  def next(priority:)
    res = Container.new
    loop do 
      break unless @stack[0]
      break if get_priority(res.push(@stack.shift)[-1]) >= priority
    end
    res
  end

  def get_priority(token) #replace this later
    return token.priority if token.respond_to?(:priority)
    case token
    when :'=' then 6
    when :+, :- then 5
    when :*, :/, :% then 4
    when :** then 3
    else 0
    end
  end
end

















