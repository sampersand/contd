class Operator
  def initialize(name, &func)
    raise "Function needed for operator `#{name.inspect}`" unless block_given?
    @name = name
    @func = func
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