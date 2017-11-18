RSpec.describe RpnDclovell::Calculator do
  before :example do
    @calc = RpnDclovell::Calculator.new
  end

  it 'computes 2, 3, + as 5' do
    @calc.accept(RpnDclovell::Token.number(2))
    @calc.accept(RpnDclovell::Token.number(3))
    plus = RpnDclovell::Token.operator('+')
    expect(@calc.accept(plus)).to eq(5)
  end

  it 'computes 3, 5, + as 8' do
    @calc.accept(RpnDclovell::Token.number(3))
    @calc.accept(RpnDclovell::Token.number(5))
    plus = RpnDclovell::Token.operator('+')
    expect(@calc.accept(plus)).to eq(8)
  end

  it 'computes 9, 1, - as 8' do
    @calc.accept(RpnDclovell::Token.number(9))
    @calc.accept(RpnDclovell::Token.number(1))
    minus = RpnDclovell::Token.operator('-')
    expect(@calc.accept(minus)).to eq(8)
  end

  it 'computes 5, 3, - as 2' do
    @calc.accept(RpnDclovell::Token.number(5))
    @calc.accept(RpnDclovell::Token.number(3))
    minus = RpnDclovell::Token.operator('-')
    expect(@calc.accept(minus)).to eq(2)
  end

  it 'computes -5, 3, - as -8' do
    @calc.accept(RpnDclovell::Token.number(-5))
    @calc.accept(RpnDclovell::Token.number(3))
    minus = RpnDclovell::Token.operator('-')
    expect(@calc.accept(minus)).to eq(-8)
  end

  it 'computes 2, 3, * as 6' do
    @calc.accept(RpnDclovell::Token.number(2))
    @calc.accept(RpnDclovell::Token.number(3))
    times = RpnDclovell::Token.operator('*')
    expect(@calc.accept(times)).to eq(6)
  end

  it 'computes 3, 5, * as 15' do
    @calc.accept(RpnDclovell::Token.number(3))
    @calc.accept(RpnDclovell::Token.number(5))
    times = RpnDclovell::Token.operator('*')
    expect(@calc.accept(times)).to eq(15)
  end

  it 'computes 10, 5, / as 2' do
    @calc.accept(RpnDclovell::Token.number(10))
    @calc.accept(RpnDclovell::Token.number(5))
    divide = RpnDclovell::Token.operator('/')
    expect(@calc.accept(divide)).to eq(2)
  end

  it 'computes 5, 8, / as 0.625' do
    @calc.accept(RpnDclovell::Token.number(5))
    @calc.accept(RpnDclovell::Token.number(8))
    divide = RpnDclovell::Token.operator('/')
    expect(@calc.accept(divide)).to be_within(0.0001).of(0.625)
  end
end
