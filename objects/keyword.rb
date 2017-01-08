require_relative 'identifier'
class Keyword < Identifier

  # # ----- Representation ----- #
  # def to_s
  #   self.class.to_s
  # end

  # def awesome_inspect(options)
  #   self
  # end
end

Keyword::Call     = Class.new(Keyword)
Keyword::Get      = Class.new(Keyword)
Keyword::Newline  = Class.new(Keyword)