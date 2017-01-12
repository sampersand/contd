class Keyword
  def to_s
    self.class.name
  end

  def inspect
    "#{self.class}"
  end

  class Newline < Keyword
    def process(body:, result:)
      result.pop #and throw away
    end
  end

  class Get < Keyword
    def process(body:, result:)
      result.push result[result.pop]
    end
  end

  class Call < Keyword
    def process(body:, result:)
      func = result.pop
      p [body.peek]
    end
  end

end






























