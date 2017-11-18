module RpnDclovell
  # Container to pass commands into the calculator
  class Token
    attr_reader :type, :value

    def initialize(type, value)
      @type = type
      @value = value
    end
  end
end
