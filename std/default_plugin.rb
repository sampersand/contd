# require_relative 'default_options'

# module Std

#   class DefaultPlugin
#     attr_reader :options

#     def self.option_method(sym)
#       define_method(sym) do |*a, &b|
#         @options.each do |option|
#           next unless option.respond_to?(sym)
#           res = option.method(sym).call(*a, &b) and return res
#         end
#         nil
#       end
#     end

#     def next_token(iter)
#       iter.next
#     end

#     def handle_token(token, result, iter)
#       case token
#       when whitespace? # do nothing
#       when start_comment?
#         nil until end_comment? === iter.next
#       when keyword?
#         result << (get_keyword token or raise "No keyword found for `#{token}`")
#       end

#       true # this class can handle any token

#     end
#   end

# end




















