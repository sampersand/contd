require_relative 'overall_object'
class Container < OverallObject
  attr_reader :body
  def initialize(body:)
    @body = body
  end

  def to_s
    "[#{@body.join(', ')}]"
  end


  def ai(options)
    awesome_inspect(options).ai(options)
  end

  def awesome_inspect(options)
    @body.collect do |ele|
      ele.awesome_inspect(options)
    end
  end


  protected

  def inspect_body_str
    "[#{@body.collect(&:inspect).join(', ')}]"
  end

end
