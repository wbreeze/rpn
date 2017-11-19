require 'rpn_dclovell/token'
require 'rpn_dclovell/calculator'
require 'rpn_dclovell/terminal_interactor'

module RpnDclovell
  class CliController
    def initialize(interactor, computer)
      @interactor = interactor
      @computer = computer
      @last_result = 0
    end

    def serve
      @interactor.greeting
      begin
        tokens = @interactor.prompt_input
        quit_seen = tokens.reduce(false) do |quit, token|
          quit ||= process_token(token) unless quit
        end
        @interactor.display_result(@last_result)
      end until quit_seen
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
