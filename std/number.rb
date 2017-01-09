class Number < Identifier
  def initialize(token)
    @token = @token.to_i
  end

  def +(other)
    self.class.new( @token + other.token )
  end

end