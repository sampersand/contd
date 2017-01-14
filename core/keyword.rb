class Keyword
  def to_s
    self.class.name.split('::').last
  end

  def inspect
    "#{self.class}"
  end
end

Keyword::Get = Class.new(Keyword)
Keyword::Call = Class.new(Keyword)
Keyword::Newline = Class.new(Keyword)





























