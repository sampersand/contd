require_relative 'plugin_module'

require_relative 'numbers'
require_relative 'whitespace'
require_relative 'text'
require_relative 'keywords'
require_relative 'variable'
require_relative 'comments'
require_relative 'operators'
require_relative 'containers'
require_relative 'functions'

module Standard
  extend PluginModule

  PLUGINS = [Functions, Text, Containers,
             Numbers, Comments,
             Operators, Keywords, Variable, Whitespace]
end


















