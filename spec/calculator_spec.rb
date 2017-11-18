RSpec.describe RpnDclovell::Calculator do
  before :example do
    @calc = RpnDclovell::Calculator.new
  end

  it 'computes 2, 3, + as 5' do
    @calc.accept(RpnDclovell::Token.new(:number, 2))
    @calc.accept(RpnDclovell::Token.new(:number, 3))
    plus = RpnDclovell::Token.new(:operator, '+')
    expect(@calc.accept(plus)).to eq(5)
  end

  it 'computes 3, 5, + as 8' do
    @calc.accept(RpnDclovell::Token.new(:number, 3))
    @calc.accept(RpnDclovell::Token.new(:number, 5))
    plus = RpnDclovell::Token.new(:operator, '+')
    expect(@calc.accept(plus)).to eq(8)
  end
end
