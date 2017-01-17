module PluginModule

  module ExtendedMethods
    # def added(parser)
    #   self::PLUGINS.each{ |o| o.respond_to?(:added) and o.added(parser) }
    # end

    def handle_next(**k)
      self::PLUGINS.any?{ |o| o.handle_next(**k) }
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end