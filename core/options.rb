class Options
  def process_token(token:, body:, result:)
    case token
    when Keyword
      token.process(body: body, result: result)
    else
      result.stack << token
    end
  end

  def next_token(priority:)
    res = Container.new(options: self)
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