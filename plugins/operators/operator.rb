class Operator
  attr_reader :name
  attr_reader :identity

  def initialize(name, identity=1)
    @name = name
    @identity = identity
  end

  def to_s
    @name.to_s
  end

  def inspect
    "#{self.class}( `#{@name.inspect}`#{@identity == 1 ? '' : ", #{@identity}"} )"
  end

  def call(current)
    arg_container = current.pop.call(current.clone)
    current << arg_container.stack.reduce(@identity, &@name)
  end

end