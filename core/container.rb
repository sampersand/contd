require_relative 'keyword'

class Container
  # --- Constructor & Attrs --- #
    attr_reader :known, :stack, :config
    def initialize(stack: [], known: {})
      @stack = stack
      @known = known
    end

  # --- Stack Functions --- #
    def pop(*a); @stack.pop(*a) end #*a should be [] or [amnt]
    def push(obj) @stack.push obj end
    def delete_at(pos) @stack.delete_at pos end
    def shift(*a); @stack.shift(*a) end #*a should be [] or [amnt]
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

    def split!
      [self.class.new(stack: @stack), self.class.new(known: @known)]
    end

    def split
      clone.split!
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
      stack_s = @stack.empty? ? '' : "stack: #{filtered_stack}"
      known_s = @known.empty? ? '' : "known: #{filtered_known}"
      sep = stack_s.empty? || known_s.empty? ? '' : ', '
      "#{self.class.name}(#{stack_s}#{sep}#{known_s})"
    end

    def to_s
      case
      when empty? then "<>"
      when @stack.empty? then filtered_known.to_s
      when @known.empty? then filtered_stack.to_s 
      else "<#{filtered_stack}, #{filtered_known}>"
      end
    end

    def filtered_stack
      @stack
      # @stack.select{ |e| !e.respond_to?(:keep_in_filter) || e.keep_in_filter }
    end

    def filtered_known
      @known.select{ |_, v| !v.respond_to?(:keep_in_filter) || v.keep_in_filter }
    end

  # --- Execution --- #
    def call!(current)
      fail 'Do not run `call` on a Container with known' unless @known.empty?
      until @stack.empty?
        case token = shift
        when Keyword::Newline
          current.pop # and do nothing
        when Keyword::Get
          to_get = current.pop
          result = current[to_get]
          raise "No such known `#{to_get}` found" unless result
          current.push result
        when Keyword::Call
          func = current.pop
          args = current.pop
          func.call(args, current)
        else
          fail "Unknown keyword #{token}" if token.is_a?(Keyword)
          current.push token
        end
      end
      current
    end

    def call(args, current)
      new_current = args.clone.call!(Container.new(known: current.known.clone))
      clone.call!(new_current)
    end

    def debug_call(args, current)
      new_current = args.clone.call!(Container.new(known: current.known.clone))
      clone.call!(new_current)
    end

end








