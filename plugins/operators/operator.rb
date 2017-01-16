class Operator
  def initialize(name)
    @name = name
    # func is derived from name
  end

  def to_s
    @name.to_s
  end

  def inspect
    "#{self.class}( `#{@name.inspect}` )"
  end

  def call(rename_me:)
    puts rename_me, self
    exit
  end
end