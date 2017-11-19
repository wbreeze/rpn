module RpnDclovell
  # Accept and execute commands as tokens, interpret them, and return
  # computed values
  class Calculator
    def initialize
      @stack = []
    end

    def accept(token)
      case token.type
      when :number
        @stack.push(process_number(token.value))
      when :operator
        @stack.push(process_operator(token.value))
      else
        raise ArgumentError,
          "Calculator lacks an operation for token type, \"#{token.type}\""
      end
      @stack.last
    end

    private

    def process_number(value)
      if value.is_a? Numeric
        value
      else
        raise ArgumentError,
          "Supplied value, \"#{value}\" is not a number"
      end
    end

    # rubocop:disable Style/GuardClause
    def stack_check(operator)
      if @stack.length < 2
        raise(ArgumentError, "too few operands for operator \"#{operator}\"")
      end
    end

    # rubocop:disable Metrics/AbcSize
    def process_operator(operator)
      stack_check(operator)
      case operator
      when '+'
        @stack.pop + @stack.pop
      when '*'
        @stack.pop * @stack.pop
      when '-'
        decrement = @stack.pop
        base = @stack.pop
        base - decrement
      when '/'
        denominator = @stack.pop
        numerator = @stack.pop
        numerator.to_f / denominator
      else
        raise ArgumentError,
          "Calculator lacks an evaluator for operator, \"#{operator}\""
      end
    end
  end
end
