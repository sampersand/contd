class Keyword
  def initialize(name=nil)
    @name = name.to_s if name
  end

  def to_s
    @name or self.class.name.split('::').last
  end

  def inspect
    @name and "#{self.class}( #{@name.inspect} )" or "#{self.class}"
  end
end

Keyword::Get = Class.new(Keyword)
Keyword::Call = Class.new(Keyword)
Keyword::Newline = Class.new(Keyword)





























