class Parser
  require_relative 'container'

  # --- Attributes and Class methods --- #
    attr_reader :plugins

    def self.plugin_method(sym)
      define_method(sym) do |*a, &b|
        @plugins.each do |plugin|
          next unless plugin.respond_to?(sym)
          res = plugin.method(sym).call(*a, &b) and return res
        end
        nil
      end
    end


    plugin_method :each_token
    plugin_method :handle_token


  def initialize(*plugins)
    @plugins = plugins
  end

  def parse(input)
    result = Container.new
    iter = each_token(input) or fail "No usable `each_token` found!"
    loop do 
      token = iter.next
      handle_token(token, result, iter) or fail("Cannot process token `#{token}`")
    end
    result
  end

end












