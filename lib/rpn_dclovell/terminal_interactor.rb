require 'rpn_dclovell/lexer'

module RpnDclovell
  # Interact with a person on a terminal command line
  class TerminalInteractor
    attr_accessor :input, :output

    def initialize(lexer, input = $stdin, output = $stdout)
      @lexer = lexer
      self.input = input
      self.output = output
    end

    def greeting
      output.write <<-'GREETING'

  Welcome. Type "q" to quit, "h" for help.
  I always wait politely for you to press the enter key.

      GREETING
    end

    def prompt_input
      output.write('rpn=> ')
      input.eof? ? [Token::QUIT] : @lexer.lex(input.gets)
    end

    def display_result(value)
      output.puts "\t#{value}"
    end

    def show_help
      output.write <<-'HELP'
  This is a calculator that accepts and evaluates expressions in
  postfix (Reverse Polish) notation.

  It will save any number that you type.

  When you type an operator, it will retrieve two of the numbers,
  apply the operation, and save the result.

  Whenever you press the enter key, it evaluates what you have typed
  and displays the latest result.  It then prompts for more input.

  To leave, simply type "q" or "bye" and then press the enter key.

  Currently supported operations are:
    - '+' addition
    - '-' subtraction
    - '*' multiplication
    - '/' division

  Here is an example session:

          rpn=> 2 3 +
                  5
          rpn=> 3 *
                  15
          rpn=> 3 /
                  5.0
          rpn=> 3 -
                  2.0
          rpn=> q
                  2.0

      HELP
    end

    def goodbye
      output.write("\n  Goodbye.\n\n")
    end

    def show_error(message)
      output.write("  There was an error. #{message}\n")
    end
  end
end
