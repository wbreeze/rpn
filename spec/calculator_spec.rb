# rubocop:disable Style/BlockDelimiters
RSpec.describe RpnDclovell::Calculator do
  before :example do
    @calc = RpnDclovell::Calculator.new
  end

  it 'computes 2, 3, + as 5' do
    @calc.accept(RpnDclovell::Token.number(2))
    @calc.accept(RpnDclovell::Token.number(3))
    operator = RpnDclovell::Token.operator('+')
    expect(@calc.accept(operator)).to eq(5)
  end

  it 'computes 3, 5, + as 8' do
    @calc.accept(RpnDclovell::Token.number(3))
    @calc.accept(RpnDclovell::Token.number(5))
    operator = RpnDclovell::Token.operator('+')
    expect(@calc.accept(operator)).to eq(8)
  end

  it 'computes 9, 1, - as 8' do
    @calc.accept(RpnDclovell::Token.number(9))
    @calc.accept(RpnDclovell::Token.number(1))
    operator = RpnDclovell::Token.operator('-')
    expect(@calc.accept(operator)).to eq(8)
  end

  it 'computes 5, 3, - as 2' do
    @calc.accept(RpnDclovell::Token.number(5))
    @calc.accept(RpnDclovell::Token.number(3))
    operator = RpnDclovell::Token.operator('-')
    expect(@calc.accept(operator)).to eq(2)
  end

  it 'computes -5, 3, - as -8' do
    @calc.accept(RpnDclovell::Token.number(-5))
    @calc.accept(RpnDclovell::Token.number(3))
    operator = RpnDclovell::Token.operator('-')
    expect(@calc.accept(operator)).to eq(-8)
  end

  it 'computes 2, 3, * as 6' do
    @calc.accept(RpnDclovell::Token.number(2))
    @calc.accept(RpnDclovell::Token.number(3))
    operator = RpnDclovell::Token.operator('*')
    expect(@calc.accept(operator)).to eq(6)
  end

  it 'computes 3, 5, * as 15' do
    @calc.accept(RpnDclovell::Token.number(3))
    @calc.accept(RpnDclovell::Token.number(5))
    operator = RpnDclovell::Token.operator('*')
    expect(@calc.accept(operator)).to eq(15)
  end

  it 'computes 10, 5, / as 2' do
    @calc.accept(RpnDclovell::Token.number(10))
    @calc.accept(RpnDclovell::Token.number(5))
    operator = RpnDclovell::Token.operator('/')
    expect(@calc.accept(operator)).to eq(2)
  end

  it 'computes 5, 8, / as 0.625' do
    @calc.accept(RpnDclovell::Token.number(5))
    @calc.accept(RpnDclovell::Token.number(8))
    operator = RpnDclovell::Token.operator('/')
    expect(@calc.accept(operator)).to be_within(0.0001).of(0.625)
  end

  context 'chained computations' do
    it 'computes 5 9 1 - / as 0.625' do
      @calc.accept(RpnDclovell::Token.number(5))
      @calc.accept(RpnDclovell::Token.number(9))
      @calc.accept(RpnDclovell::Token.number(1))
      @calc.accept(RpnDclovell::Token.operator('-'))
      operator = RpnDclovell::Token.operator('/')
      expect(@calc.accept(operator)).to be_within(0.0001).of(0.625)
    end

    it 'computes -3 -2 * 5 + as 11' do
      @calc.accept(RpnDclovell::Token.number(-3))
      @calc.accept(RpnDclovell::Token.number(-2))
      @calc.accept(RpnDclovell::Token.operator('*'))
      @calc.accept(RpnDclovell::Token.number(5))
      operator = RpnDclovell::Token.operator('+')
      expect(@calc.accept(operator)).to eq(11)
    end

    it 'computes 5 8 + 13 - as 0' do
      @calc.accept(RpnDclovell::Token.number(5))
      @calc.accept(RpnDclovell::Token.number(8))
      @calc.accept(RpnDclovell::Token.operator('+'))
      @calc.accept(RpnDclovell::Token.number(13))
      operator = RpnDclovell::Token.operator('-')
      expect(@calc.accept(operator)).to eq(0)
    end

    it 'raises exception given an unknown operator' do
      expect {
        @calc.accept(RpnDclovell::Token.number(5))
        @calc.accept(RpnDclovell::Token.number(8))
        @calc.accept(RpnDclovell::Token.operator('©'))
      }.to raise_error(ArgumentError, /lacks an evaluator/)
    end

    it 'raises exception given an invalid number' do
      expect {
        @calc.accept(RpnDclovell::Token.number('abc'))
      }.to raise_error(ArgumentError, /not a number/)
    end

    it 'raises exception given invalid token type' do
      expect {
        @calc.accept(RpnDclovell::Token::HELP)
      }.to raise_error(ArgumentError, /operation for token type/)
    end

    it 'raises exception given insufficient data' do
      op = '+'
      expect {
        @calc.accept(RpnDclovell::Token.operator(op))
      }.to raise_error(ArgumentError,
        "too few operands for operator \"#{op}\""
      )
    end
  end
end
