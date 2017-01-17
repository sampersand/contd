class Keyword

  PRIORITY = 0

  def initialize(name=nil)
    @name = name.to_s if name
  end

  def to_s
    @name or self.class.name.split('::').last
  end

  def inspect
    @name and "#{self.class}( #{@name.inspect} )" or "#{self.class}"
  end

  def priority
    self.class::PRIORITY
  end

  class Newline < Keyword
    PRIORITY = 30
  end
  class Comma < Keyword
    PRIORITY = 30
  end
end

Keyword::Get = Class.new(Keyword)
Keyword::Call = Class.new(Keyword)





























