module RpnDclovell
  # Container to pass commands into the calculator
  class Token
    attr_reader :type, :value

    def initialize(type, value)
      @type = type
      @value = value
    end

    def ==(other)
      other.is_a?(Token) && other.type == type && other.value == value
    end

    def hash
      { type: type, value: value }.hash
    end

    def self.operator(operator)
      new(:operator, operator)
    end

    def self.number(value)
      new(:number, value)
    end

    def self.command(command)
      new(:command, command)
    end
    HELP = command('help').freeze
    QUIT = command('quit').freeze

    def self.error(origin)
      new(:error, origin)
    end

    def operator?
      type == :operator
    end

    def number?
      type == :number
    end

    def command?
      type == :command
    end

    def error?
      type == :error
    end
  end
end
