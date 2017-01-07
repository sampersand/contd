require_relative 'overall_object'
class Keyword < OverallObject

  def to_s
    self.class.to_s
  end

  def awesome_inspect(options)
    self
  end

  protected

  def inspect_body_str; end # empty for a reason

end

Keyword::Call = Class.new(Keyword)