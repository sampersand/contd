class Identifier
  attr_reader :token
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


  def hash
    @token.hash
  end
  def ==(other)
    self.class == other.class && @token == other.token
  end
  alias :eql? :==
end