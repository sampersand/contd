class Identifier

  def initialize(token)
    @token = token
  end

  # ----- Representation ----- #
  def to_s
    @token.to_s
  end

  def inspect
    "#{self.class}( #{to_s} )"
  end

  def awesome_inspect(options)
    self
  end
end