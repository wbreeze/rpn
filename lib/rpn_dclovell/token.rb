module RpnDclovell
  # Container to pass commands into the calculator
  class Token
    attr_reader :type, :value

    def initialize(type, value)
      @type = type
      @value = value
    end

    def self.operator(operator)
      new(:operator, operator)
    end

    def self.number(value)
      new(:number, value)
    end

    def operator?
      type == :operator
    end

    def number?
      type == :number
    end
  end
end
