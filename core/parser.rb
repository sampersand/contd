module Parser
  require_relative '../core/container'

  module_function


  def parse(input, options)
    result = Container.new
    iter = input.each
    
  end

end



require_relative '../std/options'
input = 'x = 3'


option = Options.new
res = Parser::parse(input, option)
p res
