class OverallObject

  def inspect
    body_str = inspect_body_str
    body_str = "( #{body_str} )" if body_str
    "#{self.class}#{body_str}"
  end

  protected

  def inspect_body_str
    to_s
  end
end