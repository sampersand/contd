require_relative 'options'

module Std

  private 

  class PluginClass
    attr_reader :options

    def self.option_method(sym)
      define_method(sym) do |*a, &b|
        @options.each do |option|
          next unless option.respond_to?(sym)
          res = option.method(sym).call(*a, &b) and return res
        end
        nil
      end
    end

    option_method :whitespace?
    option_method :comment?
    option_method :end_comment?

    def initialize(*options) @options = options end
    def each_token(input, &block) input.each_char(&block) end

    def handle_token(token, result, iter)
      case
      when whitespace?(token) # do nothing
      when comment?(token)
        iter.next until end_comment?(iter.peek)
      else
        result << token
      end

      true # this class can handle any token

    end
  end

  public

  Plugin = PluginClass.new Options

end




















