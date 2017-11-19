require 'rpn_dclovell/version'
require 'rpn_dclovell/calculator'
require 'rpn_dclovell/terminal_interactor'
require 'rpn_dclovell/cli_controller'

module RpnDclovell
  # Execute a command line interpeter for the calculator
  class CLI
    def self.run
      lexer = Lexer.new
      interactor = TerminalInteractor.new(lexer)
      calculator = Calculator.new
      controller = CliController.new(interactor, calculator)
      controller.serve
    end
  end
end
