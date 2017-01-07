require_relative 'overall_object'
class Identifier < OverallObject
  def initialize(token:)
    @token = token
  end

  def to_s
    @token.to_s
  end
  def awesome_inspect(options)
    # @token
    self
  end
end