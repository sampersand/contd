require_relative '../plugin_module'

require_relative 'math/add'
require_relative 'math/sub'
require_relative 'math/mul'
require_relative 'math/div'
require_relative 'math/mod'
require_relative 'math/pow'

module Operators
  module Math
    extend PluginModule

    PLUGINS = [Add, Sub, Mul, Div, Mod, Pow]

  end
end