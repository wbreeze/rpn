RSpec.describe RpnDclovell::Token do
  context 'constructor and accessors' do
    before :context do
      @type = :number
      @value = 3.14
      @token = RpnDclovell::Token.new(@type, @value)
    end

    it 'captures a token type' do
      expect(@token.type).to eq(@type)
    end

    it 'captures a token value' do
      expect(@token.value).to eq(@value)
    end
  end

  context 'provides a factory' do
    it 'for numbers' do
      value = 21.4
      token = RpnDclovell::Token.number(value)
      expect(token.type).to eq(:number)
      expect(token.value).to eq(value)
    end

    it 'for operators' do
      operator = '+'
      token = RpnDclovell::Token.operator(operator)
      expect(token.type).to eq(:operator)
      expect(token.value).to eq(operator)
    end
  end

  context 'provides type check functions' do
    it 'for number type' do
      token = RpnDclovell::Token.number(7)
      expect(token.number?).to be true
      expect(token.operator?).to be false
    end

    it 'for operator type' do
      token = RpnDclovell::Token.operator('+')
      expect(token.operator?).to be true
      expect(token.number?).to be false
    end
  end
end
