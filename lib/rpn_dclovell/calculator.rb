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
        @stack.push(token.value)
      when :operator
        @stack.push(process_operator(token.value))
      else
        raise ArgumentError,
          "Calculator lacks an operation for token type, #{token.type}"
      end
      @stack.last
    end

    private

    def process_operator(operator)
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
          "Calculator lacks an evaluator for operator, #{operator}"
      end
    end
  end
end
