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
        process_operator(token.value)
      else
        raise ArgumentError,
          "Calculator lacks an operation for token type, #{token.type}"
      end
    end

    private

    def process_operator(operator)
      case operator
      when '+'
        @stack.pop + @stack.pop
      else
        raise ArgumentError,
          "Calculator lacks an evaluator for operator, #{operator}"
      end
    end
  end
end
