require_relative '../plugin_module'

require_relative 'radix/binary'
require_relative 'radix/octal'
require_relative 'radix/denary'
require_relative 'radix/hexadecimal'

module Numbers::Radix
  extend PluginModule

  PLUGINS = [Binary, Hexadecimal, Octal, Denary]

end
