class Keyword
  def to_s
    self.class.name
  end

  def inspect
    "#{self.class}"
  end

  def priority
    self.class::PRIORITY
  end

  class Newline < Keyword
    def process(body:, result:)
      result.pop #and throw away
    end

    PRIORITY = 7
  end

  class Get < Keyword
    def process(body:, result:)
      result.push result[result.pop]
    end
    PRIORITY = 1
  end

  class Call < Keyword
    def process(body:, result:) # I am not sure this is 100% fool-proof
      func = result.pop
      rhs = body.next(priority: Keyword::Get::PRIORITY)
      rc = result.clone
      res = rhs.call(result: rc)
      puts "res   : #{res},\nresult: #{result}"
      exit
      func.call(result: result)
    end
    PRIORITY = 2

  end

end






























