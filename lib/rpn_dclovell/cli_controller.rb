require 'rpn_dclovell/token'

module RpnDclovell
  # Coordinate activity of an interface with the calculator
  class CliController
    def initialize(interactor, computer)
      @interactor = interactor
      @computer = computer
      @last_result = 0
    end

    def serve
      @interactor.greeting
      loop do
        tokens = @interactor.prompt_input
        quit_seen = tokens.reduce(false) do |quit, token|
          quit || process_token(token)
        end
        @interactor.display_result(@last_result)
        break if quit_seen
      end
      @interactor.goodbye
    end

    private

    def process_token(token)
      if token == Token::HELP
        @interactor.show_help
      elsif token.operator? || token.number?
        @last_result = @computer.accept(token)
      end
      token == Token::QUIT
    end
  end
end
