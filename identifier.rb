class Identifier
  attr_reader :token
  def initialize(token)
    @token = token
  end
  def to_s
    @token.to_s
  end
  def inspect
    "#{self.class}( #{@token} )"
  end

  def hash
    @token.hash
  end

  def ==(other)
    other.respond_to?(:token) && @token == other.token
  end

  def eql?(other)
    to_s == other.to_s
  end

end