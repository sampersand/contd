class Keyword
  def to_s
    self.class.name
  end

  def inspect
    "#{self.class}"
  end
end

Keyword::Get = Class.new(Keyword)
Keyword::Call = Class.new(Keyword)
Keyword::Newline = Class.new(Keyword)
Keyword::This = Class.new(Keyword)
