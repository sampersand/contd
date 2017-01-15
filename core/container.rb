require_relative 'keyword'

class Container
  # --- Constructor & Attrs --- #
    attr_reader :known, :stack, :config
    def initialize(stack: [], known: {})
      @stack = stack
      @known = known
    end

  # --- Stack Functions --- #
    def pop; @stack.pop end
    def push(obj) @stack.push obj end
    def delete_at(pos) @stack.delete_at pos end
    def shift; @stack.shift end
    def unshift(obj) @stack.unshift obj end
    alias :<< :push

    def to_a
      @stack.clone
    end

    def each_token(&block)
      @stack.each(&block)
    end

  # --- Hash Functions --- #
    def [](key); @known[key] end
    def []=(key, value); @known[key] = value end

    def to_h
      @known.clone
    end

  # --- Stack & Hash Functions --- #
    def empty?
      @stack.empty? && @known.empty?
    end

    def clone
      self.class.new(stack: @stack.clone, known: @known.clone)
    end

    def update(other)
      @stack.concat other.to_a
      @known.update other.to_h
      self
    end

  # --- Representation --- #
    def inspect
      stack_s = @stack.empty? ? '' : "stack: #{@stack}"
      known_s = @known.empty? ? '' : "known: #{@known}"
      sep = stack_s.empty? || known_s.empty? ? '' : ', '
      "#{self.class.name}(#{stack_s}#{sep}#{known_s})"
    end

    def to_s
      case
      when empty? then "<>"
      when @stack.empty? then @known.to_s
      when @known.empty? then @stack.to_s 
      else "<#{@stack}, #{@known}>"
      end
    end

  # --- Execution --- #
    def call!(rename_me:)
      fail 'Do not run `call` on a Container with rename_me' unless @known.empty?
      until @stack.empty?
        case token = shift
        when Keyword::Newline
          rename_me.pop # and do nothing
        when Keyword::Get
          to_get = rename_me.pop
          result = rename_me[to_get]
          raise "No such known `#{to_get}` found" unless result
          rename_me.push result
        when Keyword::Call
          func = rename_me.pop
          func.call(rename_me: rename_me)
        else
          fail "Unknown keyword #{token}" if token.is_a?(Keyword)
          rename_me.push token
        end
      end
      rename_me
    end

    def call(rename_me:)
      clone.call!(rename_me: rename_me)
    end

end
