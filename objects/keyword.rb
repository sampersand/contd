class Keyword

  # ----- Representation ----- #
  def to_s
    self.class.to_s
  end
  alias :inspect :to_s

  def awesome_inspect(options)
    self
  end
end

Keyword::Call     = Class.new(Keyword)
Keyword::Get      = Class.new(Keyword)
Keyword::Newline  = Class.new(Keyword)